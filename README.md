# sys

My system configuration (currently for an M-series macOS device.)

I use nix-darwin to manage my system. This allows me to rebuild the state as and when, and do so across multiple machines.

## Tools used

- [nix-darwin](https://github.com/LnL7/nix-darwin)
- [nix-homebrew](https://github.com/zhaofengli/nix-homebrew)

## References I used

- [Nix installation docs](https://nixos.org/download/#nix-install-macos)
- The nix-darwin & nix-homebrew docs (see above)
- [This great blog post by Dhananjay Balan](https://blog.dbalan.in/blog/2024/03/25/boostrap-a-macos-machine-with-nix/index.html)
- [How to auto refresh all (most?) macOS settings after applying flake](https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236)

## TODO

- [ ] Investigate nix-colors pkg (for settings consistent colours across apps)

## Setting up the system

1. Install xcode dev tools.
```
xcode-select --install
```

2. Give Terminal.app full disk access (see [here](https://github.com/LnL7/nix-darwin/issues/1049#issuecomment-2323505111))

    This allows nix-darwin to configure things like com.apple.universalaccess.

    > System Settings > Privacy & Security > Full Disk Acces > *select Terminal.app*

    _TODO: Find out if I need to do this for kitty too, for future runs after everything including kitty is installed._

3. Install nix (see [here](https://nixos.org/download/#nix-install-macos)).
```
sh <(curl -L https://nixos.org/nix/install)
```

4. Clone this repo.
```
cd  ~/Developer
```
```
git clone git@github.com:jakecleary/sys.git
```

5. Install nix-darwin.
```
nix run nix-darwin -- switch --flake ~/Developer/sys
```

6. Init system using nix-darwin
```
darwin-rebuild switch --flake ~/Developer/sys
```

## Applying config changes to the system

```
darwin-rebuild switch --flake ~/Developer/sys
```

## Updating existing package sources & packages

1. Update input sources.
```
nix flake update
```

2. Update packages based on updated input sources.
```
darwin-rebuild switch --flake /Developer/sys
```