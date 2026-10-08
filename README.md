# quantifai-homebrew-tap

Homebrew tap for QuantifAI tools. One formula: [`quantifai-sync`](https://github.com/nino-chavez/quantifai-sync),
the telemetry sync agent.

> **Status: paused.** QuantifAI stopped active development in 2026. The formula points at a
> real, tagged `v0.4.6` release and installs, but nothing here is maintained.

## Install

```bash
brew tap nino-chavez/quantifai https://github.com/nino-chavez/quantifai-homebrew-tap
brew trust --formula nino-chavez/quantifai/quantifai-sync
brew install quantifai-sync
```

The trust step is required. Current Homebrew refuses to load a formula from a tap you have not
trusted, and `brew tap` does not grant trust. Without it, `brew install` stops with "Refusing
to load formula ... from untrusted tap". The command above trusts this one formula; `brew trust
nino-chavez/quantifai` trusts the whole tap instead. Tested with Homebrew 7.0.7.

If you tapped this repo earlier under another name, `brew upgrade` stops with the same error.
The error prints the trust command for your tap's name.

The URL is not optional. Homebrew's short `brew tap user/name` form resolves to a repo named
`homebrew-name` — this repo is `quantifai-homebrew-tap`, so the short form can't find it.
Renaming the repo to `homebrew-quantifai` would fix that; it hasn't been done because the
project is paused.

## What's in here

```
Formula/
  quantifai-sync.rb    darwin + linux, arm64 + amd64
```

## Reaching out

nino@ninochavez.co
