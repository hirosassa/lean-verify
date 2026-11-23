# Setting up Lean 4

## 1. Check the installation

Run `scripts/check_lean.sh`. It prints whether `elan` / `lean` / `lake` are present and their versions.

## 2. Install (if missing; get the user's confirmation first)

`elan` is Lean's toolchain manager (the equivalent of rustup for Rust).

```bash
# macOS (Homebrew)
brew install elan-init
# or the official installer
curl https://elan.lean-lang.org/elan-init.sh -sSf | sh
```

After installing, restart the shell and run `elan default stable` to make the latest stable release the default.
**The first run takes minutes to download the toolchain.** Calling `lean` concurrently makes elan wait on a lock, so wait for it to finish.

## 3. Try it in a single file (core only)

`bv_decide` / `omega` / `decide` / `simp` / `#eval` all work with core alone.

```bash
lean file.lean        # no error = proof succeeded; counterexamples appear as errors
```

Put `import Std.Tactic.BVDecide` at the top of the file to use `bv_decide`.

## 4. Make it a project (when you need plausible or multiple files)

```bash
lake init myproof            # minimal setup, no Mathlib
cd myproof
cat >> lakefile.toml <<'EOF'

[[require]]
name = "plausible"
scope = "leanprover-community"
rev = "v4.36.0"       # match the version reported by `lean --version`
EOF
lake update && lake build
```

- Match `rev` to the version tag of the toolchain you use (a mismatch makes dependency resolution fail).
- `plausible` makes the **build fail** when it finds a counterexample. If `Found a counter-example!` appears with a shrunk input, that is a success signal (a bug was found).
- When you need Mathlib (`ring_nf`, `linarith`, ...) use `lake init myproof math`, but the first build is very heavy, so avoid it until it is really needed.

## 5. Where to work

Put trial-and-error files outside the repository (e.g. a scratchpad). If you keep verification results in the repository, put them in a dedicated directory such as `proofs/` and add the build output `.lake/` to `.gitignore`.
