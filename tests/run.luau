-- Запуск: lune run tests/run.luau
local process = require("@lune/process")
local h = require("./harness")

require("./Roll.spec")
require("./Damage.spec")

process.exit(if h.summary() > 0 then 1 else 0)
