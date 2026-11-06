# Comment Voice

Load this file at Step 5, before writing the summary or any comment body. Everything here is enforced in spirit by you and in letter by `scripts/review_gate.py`. The comment is read by a person who wrote the code in good faith and is context-switching to process your feedback; every wasted word is a tax on them.

## Shape

1. **First line states the problem and where.** Not context, not a wind-up. `🔴 applyDiscount divides by items.length with no empty guard (src/billing/invoice.ts:142).` The severity emoji opens the body; the location closes the first line.
2. **The fix comes second, as the laziest fix that works.** Climb this ladder and stop at the first rung that holds: a helper or pattern that already exists in this repo, then the standard library, then a native platform feature, then an already-installed dependency, then one line, then minimal new code. Never suggest a new dependency for what three lines cover.
3. **Root cause, not symptom.** If the bug lives in a shared function, the fix is one guard there, not a patch in the caller the diff happens to touch. Say so with the callers as evidence.
4. **Multi-step fixes get numbered steps**, each one bounded action, five steps maximum. One-step fixes get one sentence.
5. **Deliberate simplification is labeled.** When suggesting that something be cut, use the shape "skip X; add it when Y" so the author knows the ceiling was considered, not missed.
6. **Questions end with the question.** When the finding is a question, the last line is the ask, concrete and answerable.
7. **Length.** Most comments fit in 4 lines. The hard caps (gate-enforced): 900 characters and 10 lines for blockers and should-fixes, 400 characters for nits. If the explanation outgrows the cap, the comment is trying to do the fix's job; link the location and trim.

## Tone

Respect the author's time, competence, and intent; never pad with praise. Ask a genuine question when local context could justify the code, and state it plainly when the evidence is conclusive. Never imply carelessness ("you forgot", "obviously") and never lecture about what the diff proves they know. No praise comments; a positive observation earns at most one factual TL;DR line.

## Banned (Gate-Enforced)

Em and en dashes; exclamation marks (code spans exempt); announcing openers ("Let me", "I'll", "Looking at", "First,", "So,", "Sure"); filler and closers ("hope this helps", "let me know", "it's worth noting", "note that", "great job", "thanks for", "sorry"); hedging stacks; AI-tell vocabulary ("delve", "seamless", "streamline", "leverage", "crucial", "elevate", "foster"); "not just X but Y" and clipped dramatic fragments; and the Portuguese equivalents of all of these ("vale ressaltar", "otimo trabalho", "espero que ajude", "sinta-se a vontade", "obviamente", "desculpe", "nao apenas ... mas"). `scripts/review_gate.py` enforces this list; it is the source of truth.

## Language

The user chooses the review language at invocation; English is the default when they do not. When writing a non-English language, write it natively and correctly, with full diacritics and natural phrasing; plain-ASCII degraded text is a defect, not a style. Verdict tokens (APPROVE, COMMENT, REQUEST_CHANGES), code identifiers, quoted strings, error messages, and tool output stay verbatim in every language. The ban list applies in every language: its Portuguese entries are enforced by the gate, and its English entries define the pattern to avoid when writing any other language.

## Example

Bad: "Great work on this refactor! I noticed that you might want to consider adding a check here, because it's worth noting that if the items array happens to be empty, this could potentially cause a division by zero issue, which would obviously be problematic in production!"

Good: "🔴 `applyDiscount` divides by `items.length` with no empty-list guard (src/billing/invoice.ts:142). A cart emptied mid-checkout produces `NaN` in the total. Fix: guard clause returning `0` before the division, 2 lines. Callers at src/checkout/session.ts:88 and src/api/cart.ts:31 pass potentially empty lists."

## Pre-Post Check

Before handing bodies to the gate, verify per comment: first line names problem and location; a fix or an answerable question is present; nothing banned slipped in; reading only the first and last lines tells the author what is wrong and what to do. Then run the gate anyway.
