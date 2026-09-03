---
name: world-class-design
description: The end-to-end process for designing any product, feature, screen, or flow so the output is distinctive instead of AI slop. Runs Discover to Define to Deliver with a scout, an implementer, a fresh-context design critic scoring against a studio bar, an asset generator, a reducer, and a copy editor. Use whenever the ask is to design or redesign a product, feature, screen, flow, landing page, prototype, or UI, or to make an existing design look less AI-generated. Triggers on "design this feature", "design a screen", "build a prototype", "make this look better", "redesign", "this looks AI-generated", "make it look premium".
---

# World-Class Design

Based on Anshu Chimala's process (ex-Apple design R&D). The premise: LLMs are next-token
predictors, so at every design decision they pick the most agreeable token. That averaging is
exactly what makes AI design bland. Great design starts from a feeling and makes unexpected
choices. Everything below exists to push the model off its default path and then hold it to a
studio quality bar.

Three stages, eight techniques. Do not skip stages. Do not collapse the agents into one.

## Non-negotiables

1. **Variety comes from outside the model.** Never ask an agent to "be creative" or "be random".
   Inject a seed string or a specific, opinionated brief. Both is better.
2. **The critic never sees the code.** Fresh context, screenshot only, same prompt every time.
3. **The stopping score lives with you, not the critic.** Never tell the critic what score ends
   the loop.
4. **The user picks the direction.** Stage 1 always ends with real options in front of them.
   An agent choosing the direction is how you land back in the average.
5. **Do not ban AI tells up front.** Banning them at brief time makes the model overthink and
   invent stranger patterns. Hunt them in Stage 3 instead.
6. **All AI copy is Lorem Ipsum.** It is placeholder for layout only, and it gets rewritten by a
   human before anything ships.
7. **Removing beats adding.** The model will never volunteer to delete. That push is your job.

## Stage 0: Frame and load house rules (do this yourself, no agents)

### Load the house rules

This skill knows nothing about any particular product. Before anything else, assemble a **house
rules block** for this project. Look, in order:

1. `CLAUDE.md` / `AGENTS.md` in the working directory and up the tree
2. Any design system, token file, style guide, brand doc, or existing prototypes in the repo
3. Anything the user has already told you in this conversation
4. A `design-house-rules.md` in the project, if one exists

Then ask the user for whatever is still missing. Keep it to the questions that would actually
change the design.

The house rules block is the only project-specific input in this whole system. Pass it
**verbatim** to the scout, the implementer, the asset generator, the reducer and the copy
editor. None of them can infer it.

The critic is the one exception: give it only the audience, the devices and the accessibility
floor, never the palette, type spec or brief. A critic holding the brand sheet marks against the
sheet, and you lose the outside eye the whole loop exists for.

What belongs in it: the audience and the constraint that audience imposes, device and network
reality, language and reading level, vocabulary rules and forbidden words, tone, brand palette
and type if fixed, the existing design system if one must be respected, accessibility floor, and
anything the product must never say or imply.

Format and a worked example: `references/house-rules.md`

### Frame the work

Then write four lines and show them to the user before spending a token on agents:

- **What** we are designing (screen, flow, page, whole product)
- **Who** it is for, and the one constraint that audience imposes
- **The feeling** we want them to have (a feeling, not an adjective list)
- **House rules** that apply, summarised

If the user has already given you the direction, skip straight to Stage 2 with their direction
as the brief. Do not run a discovery they did not ask for.

## Stage 1: Discover: explore the space of possibilities

Goal: get well past the purple-gradient default before committing to anything.

**Run 4 `design-direction-scout` agents in parallel, in one message.** Each one:

- generates its own seed string with `scripts/seed.sh` (this is what makes the four differ)
- writes a bold, specific design brief
- builds one rough hero screen so the direction can be seen, not just read

If the user already has an aesthetic in mind ("industrial control panel", "1970s field
notebook", "first light through a window"), give that to every scout as an anchor and let the
seed strings vary the execution underneath it. Their taste plus seeded variance beats either
alone.

Then:

1. Screenshot all four (`scripts/shot.sh`).
2. Show the user the four, one line each on what the direction is going for.
3. Ask which ones pull them, and what they react against. Reactions are the signal, not scores.
4. If nothing lands, run four more with sharper anchors. Cheap. Do not defend the first batch.

Ideas that sound like they will not work are the ones worth trying. If a direction makes you
think "there is no way this works", run it. Save briefs that fail and retry them on newer models.

Full ideation protocol, including how to help the user find an anchor:
`references/direction-ideation.md`

## Stage 2: Define: deepen the chosen direction

### 2a. Build it

Hand the chosen brief plus the house rules block to `design-implementer`. Full flow, real
states, real interactions.

If the project has its own implementer or prototype agent that already carries its design
language, use that one in place of `design-implementer` and give it the same brief. The rest of
the process is unchanged.

### 2b. The critic loop, the core of this process

Repeat until the critic independently scores 9/10 or higher, max 5 rounds:

1. Screenshot the current design (every key screen, not just the hero).
2. Spawn `design-critic` **in a fresh context, given only the screenshots**. No code, no
   rationale, no earlier critiques, no mention of what round this is.
3. Use `references/critic-prompt.md` **verbatim, unchanged, every round**. Changing the prompt
   between rounds makes the scores meaningless.
4. Give the implementer the critique and let it revise.

Rules:

- The critic runs on the strongest model available (`model: opus`); the implementer can run
  cheaper. Taste is worth the tokens; typing is not. In the source process the critic was under
  10% of output tokens.
- **Check convergence after round 2.** If the score has not moved at least a point, stop and
  bring it to the user. A loop that cannot converge burns tokens forever.
- If you have 3-5 reference screenshots of work at the quality bar, pass them to the critic as a
  ranking set (ours plus theirs, ranked by polish). That is the most objective form of this
  loop and the scores get far more stable. Treat references as a baseline, never a target to
  copy.

### 2c. Enrich with generated assets

Coding agents reach for gradients and CSS shapes because those are easy, and those are the
loudest AI tells. Spawn `design-asset-generator` to add real imagery, shaders, 3D, or motion.

Needs `GEMINI_API_KEY` (currently not set on this machine) for images, and `FAL_KEY` for video.
If a key is missing, say so once, name what it would unlock, and continue without it rather
than stalling. Setup and the video techniques: `references/asset-generation.md`

Then run the critic loop again. Assets change the composition.

## Stage 3: Deliver: polish into something people love

### 3a. Cut

Spawn `design-reducer`. Its only job is subtraction: every element that does not earn its place
comes out. Restraint is what reads as premium. Expect it to remove glows, gradients, redundant
labels, containers around things that need no container, and custom controls that are worse than
the platform's native ones.

### 3b. Remove AI tells

Same agent, second pass, against `references/ai-tells.md`. Go tell by tell, try the alternative,
keep it only if it is genuinely better. Intentional, not a blanket ban.

### 3c. Rewrite the copy

Spawn `design-copy-editor`. It shortens and de-slops every line, then hands the user a
line-by-line table to approve. Copy is the single fastest way a design reads as AI-made, and
this is the one step a human must actually touch. Never ship the agent's draft silently.

### 3d. Final pass

One more critic run on the finished screens. Then deliver: the files, the design brief, the
critic's final score and its remaining nits, and a plain list of what still needs a human.

## Agents in this system

| Agent | Stage | Model | Job |
|---|---|---|---|
| `design-direction-scout` | 1 | opus | Seeded, opinionated briefs plus a rough hero to see them |
| `design-implementer` | 2a | sonnet | Builds the real thing from the brief |
| project's own builder | 2a | - | If the project has one, it replaces `design-implementer` |
| `design-critic` | 2b, 3d | opus | Fresh eyes, screenshots only, scores against a studio bar |
| `design-asset-generator` | 2c | sonnet | Generated images, shaders, 3D, video, matting |
| `design-reducer` | 3a, 3b | opus | Cuts elements, hunts AI tells |
| `design-copy-editor` | 3c | opus | Kills AI copy, hands over for the human pass |

## Scripts

- `scripts/seed.sh`: random alphanumeric seed string
- `scripts/shot.sh <file.html> <out.png> [width] [height]`: headless Chrome screenshot

## References

- `references/critic-prompt.md`: the critic prompt, used verbatim
- `references/ai-tells.md`: overused patterns and their alternatives
- `references/direction-ideation.md`: finding an anchor with the user's taste in the loop
- `references/house-rules.md`: the per-project block, where it comes from, who gets which parts
- `references/asset-generation.md`: image, video, matting, keys
