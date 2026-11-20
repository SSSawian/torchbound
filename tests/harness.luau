-- Мини-раннер тестов для Lune (без внешних зависимостей).
local harness = {}

local passed, failed = 0, 0

function harness.test(name: string, fn: () -> ())
	local ok, err = pcall(fn)
	if ok then
		passed += 1
		print("  ok   " .. name)
	else
		failed += 1
		print("  FAIL " .. name .. "\n       " .. tostring(err))
	end
end

function harness.eq(actual: any, expected: any, msg: string?)
	if actual ~= expected then
		error(
			string.format(
				"%s: ожидалось %s, получено %s",
				msg or "eq",
				tostring(expected),
				tostring(actual)
			),
			2
		)
	end
end

function harness.near(actual: number, expected: number, tolerance: number, msg: string?)
	if math.abs(actual - expected) > tolerance then
		error(
			string.format(
				"%s: ожидалось %.3f ± %.3f, получено %.3f",
				msg or "near",
				expected,
				tolerance,
				actual
			),
			2
		)
	end
end

function harness.summary(): number
	print(string.format("\nИтого: %d прошло, %d упало", passed, failed))
	return failed
end

return harness
