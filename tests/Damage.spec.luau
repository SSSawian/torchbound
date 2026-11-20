local h = require("./harness")
local Damage = require("../src/ReplicatedStorage/Shared/Logic/Damage")

print("Damage")

h.test("compute округляет вниз и учитывает множитель", function()
	h.eq(Damage.compute(5, 1.5), 7)
end)

h.test("отрицательные урон и множитель дают 0", function()
	h.eq(Damage.compute(-3, 2), 0)
	h.eq(Damage.compute(3, -2), 0)
end)

h.test("apply: овердамаг убивает и считает лишнее", function()
	local hit = Damage.apply(10, 25)
	h.eq(hit.killed, true)
	h.eq(hit.dealt, 10)
	h.eq(hit.overkill, 15)
	h.eq(hit.hpLeft, 0)
end)

h.test("apply: 0 урона ничего не меняет", function()
	local hit = Damage.apply(10, 0)
	h.eq(hit.killed, false)
	h.eq(hit.hpLeft, 10)
end)

return nil
