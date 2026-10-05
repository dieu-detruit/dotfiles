# installer が ~/.zshrc に追記していた行。生成器は既存の ~/.zshrc を読まないので、
# モジュールに移さないと再生成のたびに消える。
. "$HOME/.local/bin/env"

. "$HOME/.local/share/rokoko-device-sdk/env"
