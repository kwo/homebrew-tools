# opencode

Guide for running `opencode` with Homebrew on macOS.

## Install

`opencode` is distributed by Homebrew core:

```sh
brew install opencode
```

Install the service wrapper from this tap:

```sh
brew install kwo/tools/opencode-service
```

## Run interactively

```sh
opencode
```

## Run as a Homebrew service

```sh
brew services start kwo/tools/opencode-service
brew services list | rg opencode-service
```

Restart after config changes:

```sh
brew services restart kwo/tools/opencode-service
```

Stop the service:

```sh
brew services stop kwo/tools/opencode-service
```

## Configure the service

Edit:

```sh
$(brew --prefix)/etc/opencode-service.env
```

Then restart:

```sh
brew services restart kwo/tools/opencode-service
```

## Logs

```sh
tail -f $(brew --prefix)/var/log/opencode-service.log
tail -f $(brew --prefix)/var/log/opencode-service.err.log
```
