set -x EDITOR 'nvim -p'
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -x FZF_DEFAULT_OPTS '--preview "begin; cat {}; or tree -C {}; end 2> /dev/null | head -200"'
set -x RUBYMOTION_ANDROID_NDK '/Users/aaron/.rubymotion-android/ndk'
set -x RUBYMOTION_ANDROID_SDK '/Users/aaron/.rubymotion-android/sdk'

set PATH ~/bin (yarn global bin) $PATH
