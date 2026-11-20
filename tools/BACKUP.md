# Ежедневный бэкап скриптов из Studio

Источник правды для кода в игре — облачное место в Studio (Team Create). Этот репозиторий хранит копию.

Порядок (делает Claude через Studio MCP, раз в день, когда ПК владельца включён):
1. Занять замок `_queue/studio.md` в папке проекта.
2. Проверить, что открыто облачное место (`game.PlaceId ~= 0`).
3. Пройти по `ServerScriptService/Server`, `StarterPlayer/StarterPlayerScripts/Client`, `ReplicatedStorage/Shared` и выгрузить `Source` каждого скрипта в `src/<тот же путь>/<Имя>.luau` (`.server.luau` / `.client.luau` для Script / LocalScript).
4. Коммит `backup: скрипты из Studio ДД.ММ` в ветку `backup/<дата>`, PR в `main`.
5. Освободить замок.

Модули из `ReplicatedStorage/Shared/Logic` и `Config` Claude сначала пишет и тестирует здесь (CI), потом переносит в Studio по слову «вноси». Перед переносом — сверка, что в Studio файл не правили руками.
