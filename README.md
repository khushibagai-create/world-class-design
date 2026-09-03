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

Two commands, and the first one is not optional:

```
/plugin marketplace add khushibagai-create/world-class-design
/plugin install world-class-design
```

If you see `Plugin "world-class-design" not found in any marketplace`, you skipped the first
line. `install` only searches marketplaces you have already added.

Costs about 826 tokens per session once installed. The stage prompts load only when the skill
actually fires.

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

**Stage 0: Frame.** Loads your house rules, then asks three questions and nothing more: is
there a design system or existing product to match, is there anything you admire that it should
work from, and (only if you have not already connected it) whether to connect Mobbin.

The second question is the one that matters most. Give it a link to a site you admire,
screenshots, or a product whose design language you want this to feel like, and it extracts that
language properly first: real hex values, the real type scale, the shape language, the signature
element, and what the reference refuses to do. A real reference beats anything the discovery
stage can invent, because it is a real design language with real decisions in it and the work
can be checked against it.

Then it writes four lines back to you: what we are designing, who for, the feeling, the rules in
play.

**Stage 1: Discover.** Skipped entirely if you gave it a reference to match, because four
agents inventing four palettes when you already named the palette is wasted work. This stage is
for the genuine blank page.

Otherwise: four `design-direction-scout` agents run in parallel. Each generates a
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

## Optional: Mobbin

Everything works without it. Here is what it changes, so you can decide.

The critic loop is the part of this process that does the most work, and its weak point is that
it judges against a quality bar it imagines. That bar drifts between rounds, so the scores
wobble. The fix is to give the critic a bar it can see: 4 real shipped screens for your pattern,
with yours as the fifth, ranked by polish. Same idea, far more stable scores.

[Mobbin](https://mobbin.com) is a searchable library of real screens from shipped products. With
it connected, the critic pulls its own four references every round, matched to your pattern
rather than to whatever the model happens to remember.

```bash
claude mcp add mobbin --scope user --transport http https://api.mobbin.com/mcp
```

Then `/mcp`, select mobbin, authenticate. Auth does not persist reliably between sessions, so
expect to re-run it.

It also grounds the discovery stage: search the pattern first, see how shipped products solve
it, then design. The scouts still have to be bold, but breaking a convention becomes a decision
rather than an accident.

The skill offers this once at Stage 0 and takes no for an answer.

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
  references/inspiration.md       extracting a design language from a reference you give it
  references/mobbin.md            the optional reference library and what it changes
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
