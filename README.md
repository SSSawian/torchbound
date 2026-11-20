# Torchbound

Roblox-игра (рабочее название): спуск по пиксельным катакомбам, три дорожки с монстрами, ролл оружия, факел вместо HP. 2D-интерфейс, mobile-first, вся случайность на сервере.

## Как устроена работа
- **Источник правды — облачное место в Studio** (Team Create). Код пишет Claude через Studio MCP.
- **Этот репозиторий — копия кода и место для тестов.** Rojo не используется (решение владельца 20.11).
- Скрипты из Studio каждый день выгружаются сюда: см. [`tools/BACKUP.md`](tools/BACKUP.md).
- Чистая логика (`Shared/Logic`) и конфиги баланса (`Shared/Config`) пишутся и тестируются здесь, в CI, потом переносятся в Studio.

## Структура (повторяет дерево Studio)
```
src/
  ServerScriptService/Server/               серверные сервисы
  StarterPlayer/StarterPlayerScripts/Client/ клиентские контроллеры и UI
  ReplicatedStorage/Shared/
    Config/                                 цифры баланса
    Logic/                                  чистые функции без Roblox API
tests/                                      тесты логики (Lune)
docs/ROADMAP.md                             снимок главной дорожной карты
tools/                                      инструкции по бэкапу
```

## Проверки
CI на каждый PR: формат (StyLua), линтер (Selene), тесты логики (`lune run tests/run.luau`).
