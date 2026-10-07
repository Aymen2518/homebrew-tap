# Aymen2518/homebrew-tap

Homebrew formulas for [agentless](https://github.com/Aymen2518/agentless).

```bash
brew install Aymen2518/tap/agentless     # taps automatically
agentless version

brew upgrade agentless                   # after a new formula version lands here
brew uninstall agentless && brew untap Aymen2518/tap
```

## Bumping the formula after an agentless release

```bash
V=0.2.3
SHA=$(curl -sL https://github.com/Aymen2518/agentless/releases/download/v$V/SHA256SUMS | awk '/tar.gz/{print $1}')
sed -i '' -E "s|/v[0-9.a-z]+/agentless_cli-[0-9.a-z]+\.tar\.gz|/v$V/agentless_cli-$V.tar.gz|; s|sha256 \"[0-9a-f]+\"|sha256 \"$SHA\"|" Formula/agentless.rb
brew audit --strict Aymen2518/tap/agentless && brew upgrade agentless && brew test agentless
git commit -am "agentless $V" && git push
```
