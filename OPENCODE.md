# opencode

Guide for running `opencode` with Homebrew on macOS.

## Install

`opencode` is distributed by Homebrew core:

```sh
brew install opencode
```

Install the web service wrapper from this tap:

```sh
brew install kwo/tools/opencode-web
```

## Run interactively

```sh
opencode
```

## Run as a Homebrew service

```sh
brew services start opencode-web
brew services list | rg opencode-web
```

Restart after config changes:

```sh
brew services restart opencode-web
```

Stop the service:

```sh
brew services stop opencode-web
```

## Configure the service

Edit:

```sh
$(brew --prefix)/etc/opencode-web.env
```

Then restart:

```sh
brew services restart opencode-web
```

## Logs

```sh
tail -f $(brew --prefix)/var/log/opencode-web.log
tail -f $(brew --prefix)/var/log/opencode-web.err.log
```
