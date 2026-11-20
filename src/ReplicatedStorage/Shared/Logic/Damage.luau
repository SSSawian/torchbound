--!strict
-- Чистый модуль урона по дорожке. Без Roblox API.

local Damage = {}

export type Hit = {
	dealt: number, -- сколько HP реально снято
	overkill: number, -- лишний урон сверх остатка HP
	killed: boolean,
	hpLeft: number,
}

-- Урон с множителем. Множитель < 0 считается нулём, дробный урон округляется вниз.
function Damage.compute(base: number, multiplier: number): number
	return math.floor(math.max(base, 0) * math.max(multiplier, 0))
end

function Damage.apply(hp: number, amount: number): Hit
	local clamped = math.max(amount, 0)
	local dealt = math.min(clamped, hp)
	local hpLeft = hp - dealt
	return {
		dealt = dealt,
		overkill = clamped - dealt,
		killed = hpLeft <= 0,
		hpLeft = hpLeft,
	}
end

return Damage
