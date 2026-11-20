--!strict
-- Чистый модуль ролла: без Roblox API, чтобы тестировался в облаке через Lune.
-- Случайность передаётся снаружи: на сервере это Random.new():NextNumber(), в тестах math.random.

local Roll = {}

export type Weighted = { weight: number }
export type Rng = () -> number -- возвращает число в [0, 1)

function Roll.totalWeight<T>(items: { T & Weighted }): number
	local total = 0
	for _, item in items do
		assert(item.weight >= 0, "weight must be >= 0")
		total += item.weight
	end
	return total
end

-- Выбирает один элемент по весам.
function Roll.pick<T>(items: { T & Weighted }, rng: Rng): T & Weighted
	assert(#items > 0, "items must not be empty")
	local total = Roll.totalWeight(items)
	assert(total > 0, "total weight must be > 0")
	local target = rng() * total
	local acc = 0
	for _, item in items do
		acc += item.weight
		if target < acc then
			return item
		end
	end
	return items[#items]
end

-- Роллит по одному элементу на каждую дорожку.
function Roll.lanes<T>(items: { T & Weighted }, laneCount: number, rng: Rng): { T & Weighted }
	local result = table.create(laneCount)
	for i = 1, laneCount do
		result[i] = Roll.pick(items, rng)
	end
	return result
end

-- Шанс каждого элемента в процентах: для окна «Шансы» (правила Roblox).
function Roll.chances<T>(items: { T & Weighted }): { number }
	local total = Roll.totalWeight(items)
	local out = table.create(#items)
	for i, item in items do
		out[i] = if total > 0 then item.weight / total * 100 else 0
	end
	return out
end

return Roll
