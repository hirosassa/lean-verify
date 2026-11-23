# lean-verify

A [Claude Code](https://claude.com/claude-code) skill that uses the [Lean 4](https://lean-lang.org/) theorem prover as a small, practical tool for:

- **Bug hunting**: find integer overflow, bit-manipulation, and boundary-condition bugs *with concrete counterexamples* (`bv_decide`).
- **Safe optimization**: prove that an optimized or refactored version is equivalent to the naive one for **all** inputs.

It targets small functions and single rewrite rules, not whole-program verification. It is language-agnostic (Rust, C, Go, TypeScript, ...): you model the target in Lean, then translate any counterexample back to the original code.

## Install

With the GitHub CLI (`gh skill`, preview):

```bash
gh skill install hirosassa/lean-verify lean-verify
# target a specific agent / scope if needed, e.g. --agent claude-code
```

Or clone manually:

```bash
git clone https://github.com/hirosassa/lean-verify /tmp/lean-verify
cp -r /tmp/lean-verify/skills/lean-verify ~/.claude/skills/
```

Lean itself is installed on demand by the skill (see `references/setup.md`), after asking you.

## Layout

| Path | Contents |
|---|---|
| `skills/lean-verify/SKILL.md` | Skill entry point: when to use it, workflow, modeling pitfalls |
| `skills/lean-verify/references/bug-hunting.md` | Counterexample-driven bug hunting |
| `skills/lean-verify/references/perf-equivalence.md` | Proving optimizations equivalent |
| `skills/lean-verify/references/tactics.md` | Tactic cheat sheet (core-only first) |
| `skills/lean-verify/references/setup.md` | Installing Lean / elan, minimal lake project |
| `skills/lean-verify/scripts/check_lean.sh` | Checks the Lean environment |
| `skills/lean-verify/assets/examples/` | Runnable Lean examples |

## Try the examples

```bash
lean skills/lean-verify/assets/examples/induction_decide_omega.lean
lean skills/lean-verify/assets/examples/bv_overflow_and_strength_reduction.lean   # bad_ng is expected to fail with a counterexample
```

## License

MIT
