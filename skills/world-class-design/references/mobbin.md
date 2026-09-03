# Mobbin

Mobbin is a searchable library of real screens from shipped products, reachable over MCP. It is
optional. Everything in this skill works without it. It is worth connecting anyway, and this
file explains exactly what it changes, because "it makes results better" is not a reason.

## What it actually fixes

The critic loop has a known weak point, and the source process names it. Ranked by how objective
the instruction is:

- **Bad:** "judge if this looks beautiful and not AI-generated." Too subjective, scores swing
  wildly between runs.
- **OK:** "review the aesthetic we are going for, imagine how a top studio would execute it,
  judge us against that bar." A consistent framework, but the bar lives in the model's head.
- **Great:** "here are 5 designs, 4 professional and 1 ours. Rank them by polish and taste."
  Concrete, objective, and gives the critic a visual baseline instead of an imagined one.

Without a reference library you are stuck at OK, because you have no professional examples to
hand the critic. Mobbin is where those four come from, matched to your actual pattern rather
than whatever the model happens to remember. That is the upgrade: it moves the critic from
imagining a quality bar to seeing one.

Second use, earlier: it stops the scouts designing cold. Search the pattern first, look at how
shipped products actually solve it, then design against that knowledge.

## Connecting it

```bash
claude mcp add mobbin --scope user --transport http https://api.mobbin.com/mcp
```

Then `/mcp`, select mobbin, authenticate in the browser.

Auth does not persist reliably between sessions. Expect to re-authenticate, and treat a tool
error as "needs auth" before treating it as broken.

## Offering it

Ask once, at Stage 0, and make the trade concrete rather than selling it:

> Mobbin is connected. I will pull 4 real shipped screens for this pattern and have the critic
> rank our design against them, which gives a far more stable score than judging against an
> imagined bar.

or, when it is not connected:

> Mobbin is not connected. Without it the critic judges against an imagined quality bar, which
> works but drifts between rounds. With it, I rank our design against 4 real shipped screens for
> this pattern, and the scores get much more reliable. Connecting takes about a minute:
> `claude mcp add mobbin --scope user --transport http https://api.mobbin.com/mcp`, then `/mcp`
> to authenticate. Want to, or shall I go ahead without it?

Take no for an answer and do not ask again in the same session.

## Where it plugs in

**Stage 1, grounding the scouts.** Before spawning them, search the pattern
(`search_flows` for a journey, `search_screens` for a single screen, `search_sections` for a
web section). Read the images. Write 3-5 lines on what shipped products actually do here, and
pass that to every scout as context.

This is grounding, not a moodboard. The scouts still have to be bold. What they gain is knowing
which conventions exist, so that breaking one is a decision rather than an accident.

**Stage 2b, the ranking critic.** The critic fetches 4 reference screens itself, given only a
neutral pattern query from you, never the brief. It ranks all five, says what puts each where it
is, and says what would move ours up one place.

Use the **same query every round** so the reference set stays comparable. A score against a
different baseline each round is not a trend.

**Stage 3, checking a specific tell.** When unsure whether a pattern is a tell or a convention,
search it. If ten shipped products in the category do it, it is a convention and it can stay.

## Rules

- References are a baseline and a moodboard, **never a target to copy**. The point is to clear
  the bar, not to blend in with it. A design that could be swapped into any of the four has
  failed differently but has still failed.
- Cite each screen you show the user as a markdown link to its `mobbin_url`.
- Look at the images. The metadata is not the screen.
- Search one thing per query. Two intents in one query returns mush.
- Keep `limit` low. These are images and they are expensive in context.
- Never let the critic see the brief through the query. "habit tracking daily check-in screen"
  is fine. "warm minimal check-in screen for our yoga app, sage green" is a leak.
