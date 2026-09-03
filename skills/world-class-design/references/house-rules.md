# House rules

The process in this skill is product-agnostic on purpose. Nothing in it knows your audience,
your vocabulary, your palette, or what your product must never say. That knowledge enters at one
point only: the **house rules block** assembled in Stage 0 and passed verbatim to every agent.

Get this right and the same skill produces work that fits a meditation app for retirees, a
developer tool, and a children's game. Skip it and every agent quietly designs for the same
imaginary 28-year-old on a MacBook.

## Where the rules come from

In order, stopping when you have enough:

1. `CLAUDE.md` or `AGENTS.md` in the working directory, then up the tree. Most projects already
   have their vocabulary, audience and constraints written there.
2. A design system, token file, `tailwind.config`, style guide, or brand doc in the repo.
3. Existing screens or prototypes. Read the actual palette and type off them rather than
   inventing a new one.
4. What the user has already said in this conversation.
5. A `design-house-rules.md` in the project, if the project keeps one.

Then ask for what is still missing, and only for what would change the design. Two or three
questions, not a questionnaire.

## The block

Keep it under a page. Every line should be one an agent could violate.

```
HOUSE RULES

Audience:        who they are, and the one thing about them that constrains the design
Devices:         what they are actually holding, on what connection
Language:        which language, what reading level, what stays untranslated
Vocabulary:      the words we use, and the words we never use
Tone:            how it should sound, and the registers that are off-limits
Palette:         fixed hex values if fixed, or "open" if the direction may choose
Type:            fixed families if fixed, or "open"
Design system:   what must be reused rather than reinvented, with a path
Accessibility:   contrast floor, minimum type size, tap target size
Never:           claims, framings, or references the product must not make
```

Mark anything genuinely open as **open**. An agent handed a fixed palette designs inside it; an
agent handed "open" explores. Do not lock down more than the project actually requires, or Stage
1 has nowhere to go.

## Worked example

```
HOUSE RULES

Audience:        women 40+ in smaller cities, first-generation smartphone users. If a first-time
                 user cannot work out the next tap without help, the design has failed.
Devices:         mid-range Android, 4G that drops. Nothing heavy, static fallback for motion.
Language:        English UI. Domain words stay in the local language where no natural
                 translation exists.
Vocabulary:      "members" not "users". "sessions" not "classes".
Tone:            warm, plain, non-pushy. No urgency, no FOMO, no guilt.
Palette:         open, but it must survive on a cheap LCD in daylight.
Type:            open. Body text never below 16px.
Design system:   reuse the existing component library at ./design-system if the screen has an
                 equivalent.
Accessibility:   4.5:1 minimum contrast, 48px tap targets.
Never:           imply the member is behind, failing, or losing anything by missing a day.
```

That block is what makes the difference between the scout inventing a fashionable dark-mode
dashboard and the scout designing something the actual audience can use. Only the block changes
between projects. The rest of the skill does not.

## Which agents need which parts

| Agent | Needs |
|---|---|
| `design-direction-scout` | Everything. The direction is where audience fit is won or lost. |
| `design-implementer` | Everything, particularly the design system and accessibility floor. |
| `design-critic` | Audience, devices, accessibility. **Not** palette or type, or it will judge compliance instead of quality. |
| `design-asset-generator` | Devices, palette, and the "never" list. |
| `design-reducer` | Audience and accessibility, so it does not cut something the audience needs. |
| `design-copy-editor` | Language, vocabulary, tone, and the "never" list. Most of its job. |

The critic is the deliberate exception. Give it the constraints a design can genuinely fail on,
and withhold the stylistic ones. A critic holding the full brand sheet starts marking against
the sheet, and you lose the fresh outside eye that the loop exists for.
