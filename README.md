# lean-verify

A [Claude Code](https://claude.com/claude-code) skill that uses the [Lean 4](https://lean-lang.org/) theorem prover as a small, practical tool for:

- **Bug hunting**: find integer overflow, bit-manipulation, and boundary-condition bugs *with concrete counterexamples* (`bv_decide`).
- **Safe optimization**: prove that an optimized or refactored version is equivalent to the naive one for **all** inputs.

It targets small functions and single rewrite rules, not whole-program verification. It is language-agnostic (Rust, C, Go, TS, ...): you model the target in Lean, then translate any counterexample back to the original code.

## Install

Clone into your Claude Code skills directory:

```bash
git clone https://github.com/hirosassa/lean-verify ~/.claude/skills/lean-verify
```

Lean itself is installed on demand by the skill (see `references/setup.md`), after asking you.

## Layout

| Path | Contents |
|---|---|
| `SKILL.md` | Skill entry point: when to use it, workflow, modeling pitfalls |
| `references/bug-hunting.md` | Counterexample-driven bug hunting |
| `references/perf-equivalence.md` | Proving optimizations equivalent |
| `references/tactics.md` | Tactic cheat sheet (core-only first) |
| `references/setup.md` | Installing Lean / elan, minimal lake project |
| `scripts/check_lean.sh` | Checks the Lean environment |
| `assets/examples/` | Runnable Lean examples |

## Try the examples

```bash
lean assets/examples/induction_decide_omega.lean
lean assets/examples/bv_overflow_and_strength_reduction.lean   # bad_ng is expected to fail with a counterexample
```

## License

MIT
