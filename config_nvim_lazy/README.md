# nvim settings with lazy.nvim

setup following the instruction at https://lazy.folke.io/

## Installation
- put `.config/nvim/lua/config/lazy.lua` and paste script from "Structured Setup" section.
- load the file in `init.lua` with `require("config.lazy")`

## structure
migrated dein plugin settings to lazy.nvim style lua.

.
├── init.lua
├── lazy-lock.json
├── lua
│   ├── config
│   │   └── lazy.lua
│   ├── plugins
│   │   ├── copilot.lua
│   │   ├── lang_support.lua
│   │   ├── parentheses.lua
│   │   └── syntax.lua
│   └── preferences
│       ├── basic.lua
│       ├── clang_format.lua
│       ├── cmake_format.lua
│       ├── init.lua
│       └── python_format.lua
└── README.md

5 directories, 13 files
