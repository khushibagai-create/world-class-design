# Finding a direction with the user's taste in the loop

The hardest moment in design is the blank screen. The fix is to go broad before going deep, and
to make sure the choice of direction is the user's, not an agent's. If you ask AI for ideas and
paste AI's ideas back into AI, you get the average idea. Anyone could have run that. The user's
reaction to the options is the only thing in this process that no one else could reproduce.

## Two ways to inject variety

### 1. Seed strings (works with no input from the user)

The model cannot act randomly. It can only predict the most likely token, so "make it unique" or
"choose at random" produces the same non-random output every time. Variety has to come from
outside. This is the String Seed of Thought technique (Sakana AI).

Give the agent this procedure:

> 1. Generate a long random alphanumeric string using a shell script.
> 2. Define the creative direction (colour scheme, layout, typography, motion, texture) based on
>    that string. Look beyond the surface: subpatterns, repeated characters, special numbers,
>    anything that suggests something to you.
> 3. Use your judgement to bring that direction to life and make it look great.
>
> Do not reveal the string in the design. It is only for your inspiration.

Run it four times and you get four genuinely different designs. No two runs match.

### 2. An ambitious, specific brief (works better, needs the user's taste)

A wild, concrete vision gives the model something to decide against, instead of deciding on the
fly. Shape:

> Build me [thing], with [specific aesthetic anchor]. [What each part should feel like].
> [The constraint that makes it hard].

Examples from the source:

- "a bold pixel art theme and stunning graphics. Each section should feel like a still from a
  video game, yet somehow it should still function as a landing page"
- "set in an isometric living 3D city, where different features are represented by
  neighbourhoods or buildings"
- "a radically asymmetric layout, dissonant colours and typography, and uncomfortable negative
  space. Break all the rules but still make it look good"

Best results come from combining both: the user's anchor across all four scouts, seed strings
varying the execution underneath.

## Helping the user find an anchor

Three steps, and the user is in the middle of all of them.

**1. Ask for a long list, deliberately thin.** The point is to spark the user's imagination, not to
be right.

> I want to come up with a bold, unique design language for [product]. List as many ideas as you
> can, with short high-level descriptions. Go broad, not deep.

Twenty one-liners. "Industrial control panel." "Field notebook." "Old broadcast test card."

**2. Visualise their favourites and let them react.** Build the two or three they circle, cheap
and rough. Then take the reaction verbatim, including the negative half, which is the useful
half:

> Industrial control panel: I'm imagining something tactile, clicky satisfying buttons, nice
> sounds. Initially I pictured something cartoony or skeuomorphic, but that feels tacky to me,
> avoid it. Instead I want consistent components and small touches that land the look without
> going overboard. Grey gradients would be boring, it needs more texture. Maybe colour, while
> keeping the control-panel feel. Sharpen this based on my tastes.

**3. Iterate until the user is satisfied, then have AI write the build prompt.**

> Write a concise prompt an AI agent could use to build an initial POC page with this.

That prompt becomes the Stage 1 brief.

## Two rules

Run the ideas that sound terrible. "There is no way this works" is usually you underestimating
the agent. If it fails, throw it out, it cost one screen.

Keep the briefs that fail. Re-run them when a new model ships. That is how you know you are
using what the current models can actually do.
