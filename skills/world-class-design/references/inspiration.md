# Working from inspiration the user gives you

When the user hands you a reference, a site they admire, a screenshot, a product whose design
language they like, that reference is worth more than anything the discovery stage can invent.
It is a real design language with real decisions in it, and it is verifiable. Seed strings exist
to solve the blank-page problem. A reference means there is no blank page.

So when a reference arrives, the job changes from "explore a space" to "extract a language, then
compose in it". That is a different and easier problem, and the results are consistently better.

## Extract before you design

Never look at a reference and design from the impression it left. Extract it properly and write
the extraction down, because everything downstream reads that file rather than re-forming a
vague memory.

**From a URL:** fetch it. Where the fetch gives you markup and CSS, read the real values. Where
it does not, screenshot the page and read the screenshot.

**From a screenshot:** read the image and sample the actual colours rather than naming them.
"Warm off-white" is not a value. `#FDF8F0` is.

**From a named product** ("make it feel like Linear"): if Mobbin is connected, pull real screens
of it. Otherwise fetch the site. Do not design from what you remember of a product, because what
you remember is the averaged version, which is the thing this whole skill exists to avoid.

## What to extract

Write this into `design-language.md` next to the work:

- **Palette.** Exact hex values, and the role each one plays: ground, surface, primary text,
  secondary text, the one accent, borders. Note which colour is used sparingly, because
  restraint in the reference is a decision you should copy.
- **Type.** The families, or the nearest Google Font. The actual scale in px. Weights in use.
  How tight the tracking is on headings. How many levels the reference actually uses, which is
  usually fewer than you would choose.
- **Shape language.** Corner radii, border weights, whether things sit in cards at all, shadow
  depth, how surfaces separate from each other.
- **Spatial rhythm.** The base unit. Section padding. How much air sits around the densest
  element on the page.
- **The signature element.** The one thing someone would recognise the product by: Flo's cycle
  ring, Duolingo's streak flame, Spotify's now-playing bar, a distinctive table or terminal.
  This is the highest-value thing in the extraction, and it is the one most often missed.
- **Motion.** What moves, how far, how fast, and what deliberately does not move.
- **What the reference refuses to do.** Often the sharpest signal. No gradients. No shadows.
  Never more than one accent. Only two type sizes.

## Then compose, do not copy

The extraction is a vocabulary, not a layout. Building a near-copy of the reference with the
user's content dropped in is a failure, just a different one from AI slop.

Two ways this goes right:

**Match mode**, when the user wants to look like the reference (their own product, a design
system, a company they are pitching): compose new screens using the extracted vocabulary
faithfully. Reuse real components where they exist. Judge against "would this pass as part of
that product".

**Inspiration mode**, when the user just admires the reference: take the vocabulary and the
attitude, then diverge on structure. The reference sets the quality bar and the taste, not the
composition. Judge against "does this stand on its own while clearly sharing that sensibility".

Ask which one you are in if it is not obvious from how they described it. It changes everything
downstream.

## What this does to the stages

**Stage 1.** With a reference in hand, seeded discovery is usually the wrong tool. Either skip
it (match mode: go straight to building in the extracted language) or run the scouts with the
extraction as a fixed anchor, varying composition and the signature move underneath it rather
than varying the whole language. Do not let four scouts invent four unrelated palettes when the
user already told you the palette.

**Stage 2.** The extraction goes to the implementer verbatim. Exact hex values, exact scale.
"Warm and minimal" reaching the implementer instead of real values is how a good reference turns
back into slop.

**Stage 2b.** The reference is the best possible ranking set for the critic. It is the actual
bar the user has in mind, which is better than a generic bar from a library. Pass the reference
screenshots and ask the critic to rank ours among them.

**Stage 3.** "What the reference refuses to do" is a subtraction checklist. If the reference
never uses a gradient and ours has three, that is the answer.
