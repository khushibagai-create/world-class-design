# World-Class Design

A multi-agent design process for Claude Code. One skill, six agents, three stages. It exists to
stop Claude producing the same design everyone else gets.

## Why this exists

An LLM is a next-token predictor. At every design decision, whether that is a colour, an
arrangement, or a size, it picks the token most likely to please everyone. Averaged over a whole
page that is design by committee, and it is why AI-generated designs share a look: the purple
gradient, text on the left, graphic on the right, everything in a rounded card.

Good design does the opposite. It starts from a feeling and makes choices that are specific,
sometimes uncomfortable, and memorable. You cannot prompt your way there by asking for
creativity, because the model cannot choose randomly. It can only predict.

So this process forces the issue: variety is injected from outside the model, and quality is
judged by an agent that never sees the code.

## Install

```
/plugin marketplace add khushibagai-create/world-class-design
/plugin install world-class-design
```

Or copy it in by hand:

```bash
git clone https://github.com/khushibagai-create/world-class-design.git
cp -R world-class-design/skills/world-class-design ~/.claude/skills/
cp world-class-design/agents/design-*.md ~/.claude/agents/
```

## Use it

Ask for design work in plain language. The skill triggers on its own:

- "design the onboarding flow for this"
- "build a prototype for the settings screen"
- "redesign this landing page"
- "this looks AI-generated, fix it"

Or invoke it directly with `/world-class-design`.

## Do this one thing first

Copy `templates/design-house-rules.md` into your project and fill it in.

The process is product-agnostic on purpose. Nothing in it knows your audience, your vocabulary,
your palette, or what your product must never say. That all enters through one house rules
block, assembled in Stage 0 and handed to every agent.

Skip it and every agent quietly designs for the same imaginary 28-year-old on a MacBook.

If your project already has that context in its `CLAUDE.md`, the skill will find it there and
you can skip the template. It also reads your design system, token files, and existing screens
before asking you anything.

## What actually happens

**Stage 0: Frame.** Loads your house rules, then writes four lines back to you: what we are
designing, who for, the feeling, the rules in play. Costs nothing, catches the wrong brief early.

**Stage 1: Discover.** Four `design-direction-scout` agents run in parallel. Each generates a
random seed string with a shell script and derives a design direction from it, then builds a
rough hero screen so you can see it rather than read about it.

The seed string is the trick. "Make it unique" produces the same non-random output every time,
because the model cannot be random. A string from `/dev/urandom` genuinely can, and the model
reads it as inspiration. Four runs, four different designs, none of them the default.

You then pick. Not the agent. If you paste AI's ideas back into AI, you get the average idea and
anyone could have run it. Your reaction to the four options is the only thing in this process
nobody else could reproduce.

**Stage 2: Define.** `design-implementer` builds the chosen direction properly. Then the loop
that does most of the work:

1. Screenshot the design.
2. Spawn `design-critic` in a **fresh context**, with the screenshots and nothing else. No code,
   no rationale, no earlier critiques.
3. It names the aesthetic, imagines how a top studio would execute it, lists the gaps, scores
   out of 10.
4. The implementer applies the fixes. Repeat until 9/10.

The builder cannot judge its own work. It has read its own code and remembers its own reasoning.
The critic has neither, which is the whole point. Run the critic on the strongest model you have
and the implementer on something cheaper. Taste is worth paying for, typing is not.

Then `design-asset-generator` replaces code-drawn gradients and shapes with real generated
imagery, and optionally video: matted loops that layer into the UI without reading as video, and
scroll-scrubbed transitions interpolated between keyframes.

**Stage 3: Deliver.** `design-reducer` runs two passes: cut everything that does not earn its
place, then work the AI-tells checklist trying alternatives. `design-copy-editor` treats every
AI-written line as Lorem Ipsum and rewrites it short and plain, then hands you a line-by-line
table to approve. One final critic pass, then delivery.

## The rules that make it work

Break these and you get an expensive version of what you already had.

1. **Variety comes from outside the model.** Never ask an agent to be creative or random. Inject
   a seed string, an opinionated brief, or both.
2. **The critic never sees the code.** Fresh context, screenshots only, the same prompt every
   round. Change the prompt between rounds and the scores mean nothing.
3. **Never tell the critic the passing score.** The orchestrator holds it. A critic that knows
   the bar will find its way there.
4. **You pick the direction.** An agent choosing it is how you land back in the average.
5. **Do not ban AI tells in the brief.** Banning gradients and cards up front makes the model
   overthink and invent stranger patterns. Hunt them in Stage 3, one at a time, trying the
   alternative and keeping whichever is better.
6. **All AI copy is placeholder.** A human reads and rewrites every line before it ships.
7. **Removing beats adding.** The model will never volunteer to delete. That push is yours.

There is a convergence check after round two and a five-round cap, so a critic loop cannot burn
tokens forever.

## Optional API keys

Both stages degrade gracefully. If a key is missing the agent says so once and continues with
code-drawn assets.

- `GEMINI_API_KEY`: image generation
- `FAL_KEY`: video generation, interpolation and matting via fal.ai, which aggregates the
  current models so you are not integrating each one

Make separate keys with tight spend limits for agent use, keep them in a gitignored
`.env.agents`, and never let them reach product code.

## What is in here

```
skills/world-class-design/
  SKILL.md                        the orchestrator
  references/critic-prompt.md     the critic prompt, used verbatim every round
  references/ai-tells.md          overused patterns and their alternatives
  references/house-rules.md       the per-project block: format, sources, who gets what
  references/direction-ideation.md  finding an aesthetic anchor with your taste in the loop
  references/asset-generation.md  images, video, matting, keys
  scripts/seed.sh                 random seed string
  scripts/shot.sh                 headless Chrome screenshot
agents/
  design-direction-scout.md       Stage 1, seeded directions
  design-implementer.md           Stage 2, builds it
  design-critic.md                Stage 2 and 3, fresh eyes, scores it
  design-asset-generator.md       Stage 2, real imagery and motion
  design-reducer.md               Stage 3, subtraction and AI tells
  design-copy-editor.md           Stage 3, kills AI copy
templates/design-house-rules.md   copy this into your project
```

Swap `design-implementer` for your own builder agent if you have one that already carries your
design language. Everything else stays the same.

## Credit

The process, the techniques and the AI-tells list come from **"How to turn your AI into a
world-class designer" by Anshu Chimala**, published in Lenny's Newsletter on 1 September 2026.
Anshu led design and software engineering teams at Apple for 12 years working on research and
prototyping for future AI products.

https://www.lennysnewsletter.com/p/how-to-turn-your-ai-into-a-world

The seed-string technique is String Seed of Thought, published by Sakana AI.

This repository is an implementation of that process as Claude Code agents. Read the original
for the reasoning, the before-and-after examples, and everything this summary compresses.
