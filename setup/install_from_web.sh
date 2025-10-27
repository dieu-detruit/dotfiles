#!/bin/bash

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# deno
curl -fsSL https://deno.land/install.sh | sh

# pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -

# starship
curl -sS https://starship.rs/install.sh | sh
