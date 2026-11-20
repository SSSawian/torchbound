local h = require("./harness")
local Roll = require("../src/ReplicatedStorage/Shared/Logic/Roll")
local Weapons = require("../src/ReplicatedStorage/Shared/Config/Weapons")

print("Roll")

h.test("pick с одним элементом всегда возвращает его", function()
	local items = { { id = "a", weight = 1 } }
	for _ = 1, 10 do
		h.eq(Roll.pick(items, math.random).id, "a")
	end
end)

h.test("элемент с весом 0 не выпадает", function()
	local items = { { id = "zero", weight = 0 }, { id = "one", weight = 1 } }
	for _ = 1, 1000 do
		h.eq(Roll.pick(items, math.random).id, "one")
	end
end)

h.test("rng на границе 0.9999 не выходит за массив", function()
	local items = { { id = "a", weight = 1 }, { id = "b", weight = 1 } }
	h.eq(
		Roll.pick(items, function()
			return 0.99999999
		end).id,
		"b"
	)
end)

h.test("распределение совпадает с весами ±2% на 100k роллов", function()
	math.randomseed(42)
	local counts = {}
	local n = 100000
	for _ = 1, n do
		local w = Roll.pick(Weapons, math.random)
		counts[w.id] = (counts[w.id] or 0) + 1
	end
	local chances = Roll.chances(Weapons)
	for i, w in Weapons do
		h.near((counts[w.id] or 0) / n * 100, chances[i], 2, w.id)
	end
end)

h.test("lanes возвращает по оружию на каждую дорожку", function()
	h.eq(#Roll.lanes(Weapons, 3, math.random), 3)
end)

h.test("шансы в сумме 100%", function()
	local sum = 0
	for _, c in Roll.chances(Weapons) do
		sum += c
	end
	h.near(sum, 100, 1e-6, "сумма")
end)

return nil
