#!/usr/bin/env bash
# Check whether a Lean environment is available. Uses a timeout so it doesn't hang on a download/lock wait.
set -u

for cmd in elan lean lake; do
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "found: $cmd -> $(command -v "$cmd")"
  else
    echo "missing: $cmd"
  fi
done

if ! command -v elan >/dev/null 2>&1; then
  echo "elan is missing. Install it following references/setup.md (after confirming with the user)."
  exit 1
fi

# The first run may be slow while downloading the toolchain, or wait on another process's lock.
# Judging by process name picks up false positives (ourselves, unrelated shells), so decide by whether the command succeeds.
if command -v timeout >/dev/null 2>&1; then
  timeout 60 lean --version || { echo "lean --version did not finish within 60s. The toolchain may still be downloading. Wait for it to finish and rerun."; exit 2; }
else
  lean --version
fi
