--!strict
-- Набор оружия для ролла. Цифры — черновик баланса v0, правятся в 01_дизайн/БАЛАНС.md.
-- weight: относительный шанс выпасть в слоте; damage: базовый урон по монстру над дорожкой.

export type Weapon = {
	id: string,
	name: string,
	damage: number,
	weight: number,
}

local Weapons: { Weapon } = {
	{ id = "rusty_dagger", name = "Ржавый кинжал", damage = 2, weight = 40 },
	{ id = "short_sword", name = "Короткий меч", damage = 4, weight = 25 },
	{ id = "torch_club", name = "Дубина-факел", damage = 6, weight = 15 },
	{ id = "bone_bow", name = "Костяной лук", damage = 8, weight = 10 },
	{ id = "iron_axe", name = "Железный топор", damage = 12, weight = 6 },
	{ id = "rune_spear", name = "Рунное копьё", damage = 18, weight = 3 },
	{ id = "ember_blade", name = "Тлеющий клинок", damage = 30, weight = 0.9 },
	{ id = "rage_sigil", name = "Знак Ярости", damage = 0, weight = 0.1 },
}

return Weapons
