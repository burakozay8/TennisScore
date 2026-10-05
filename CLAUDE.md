# Working rules

- This project is built incrementally, together with the developer.
  The plan document is a roadmap, not a spec to implement in one go.
- The roadmap lives in `notes/PLAN.tr.md` (not committed).
- Never scaffold the whole project, and never write several types at once.
- One step = one type, one function, or one view (usually 10-40 lines).
  Split large functions rule by rule across steps.
- Before writing code: describe the step in 2-3 sentences, list the files
  and signatures you will touch, then wait for approval.
- After writing code: run the relevant tests, explain the change briefly,
  then STOP and wait for "continue".
- Add only what the current step needs: no future fields, no protocols,
  no abstractions, no helpers "for later", no TODOs, no commented-out code.
- If the developer says "I'll write it", review their code instead.
- Commit only when the developer asks; stage only the current step's files,
  by path. Never create or edit files outside the current step.
