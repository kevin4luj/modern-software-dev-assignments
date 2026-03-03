# CS146S Learning Workflow Memory

## Goal
Ensure every new assistant session in this repo can quickly recover:
- your learning method
- your current progress
- your latest blocker and next action

## Startup Checklist (Run at the beginning of each session)
1. Identify the active week.
2. Read `[week]/plan/plan.md`.
3. Read `[week]/plan/progress.md`.
4. If a task is mentioned, read its latest log file first (for example `week1/k_shot_prompting.log`).
5. Give a short "state recap" before making changes:
   - current goal
   - latest result
   - next step

## Your Working Conventions
- Use `./run_assignment.sh <weekX/task.py>` to run assignments.
- Trust the matching log file (`<weekX/task>.log`) as execution evidence.
- Judge pass/fail from task output semantics (e.g., `SUCCESS`), not only process exit code.

## Progress Update Rules
After each meaningful run or change, append a short entry to `[week]/plan/progress.md` including:
1. timestamp
2. command executed
3. observed result
4. diagnosis
5. next action

## Priority Order for Debugging
1. Environment/endpoint correctness (model server reachable, right `OLLAMA_HOST`).
2. Reproducibility (same command, same log path, deterministic settings).
3. Prompt/task fit (does the model reliably satisfy the rubric constraints).

## Current Known Context
- Week 1 is in progress.
- `run_assignment.sh` is your standard runner.
- `week1/k_shot_prompting.log` is the primary evidence file for the current blocker.
