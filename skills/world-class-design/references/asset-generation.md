# Generated assets: images, motion, video

Coding agents love writing code, so they reach for gradients, CSS shapes and basic patterns
instead of real imagery. Those are among the strongest AI-design tells. Generated images, depth
effects and motion signal effort beyond the surface, and they are the fastest way to give a flat
design personality.

## Keys

Neither key is set on this machine right now. If one is missing, say so once, name what it
unlocks, and carry on without it.

**Images: `GEMINI_API_KEY`.** The `gemini-imagegen` skill already wraps Gemini's
`gemini-3-pro-image-preview` (up to 4K, all the standard aspect ratios, image editing and
multi-turn refinement). Use that skill rather than writing the API call by hand.

**Video: `FAL_KEY`.** fal.ai aggregates the video models, so one key covers generation,
interpolation and matting, and the agent can pick the current best model per job instead of you
maintaining integrations. The best video model changes every few months.

Setup, once:

> Create a gitignored file called `.env.agents`, store the key in it, and note in CLAUDE.md that
> these keys are for development use by agents and must not ship with the product.

Make a separate key with a tight spend limit for agent use, so a mistake is cheap and revoking
it breaks nothing else.

## Images

Prompt shape:

> The design is plain. Add personality using image generation. Consider shaders or 3D effects in
> combination with images to create more interesting visuals. Verify your work looks right
> frame by frame in the browser.

That last line matters. The agent must render and look, not assume.

Where generated imagery earns its place: hero and section backgrounds instead of gradients,
textures and grain, product or object renders, abstract 3D forms, illustration in a consistent
style, empty-state art. Where it does not: as a substitute for real screenshots, or as
decoration behind text it makes unreadable.

## Video

### Animated graphics that are not obviously video

Generate a looping clip against a solid-colour background, then chroma-key it out or run a video
matting model to remove the background. You get an animation you can layer anywhere in the UI
and it reads as part of the interface.

For convincing refraction and glass, render the object over the page's actual background colours
first so the refraction is baked in, then matte the background out.

> Replace the image on this page with a looping video clip. Have [object] [motion]. It should
> have glassy effects that refract the page background and cast light and shadow around it.
> Render the video over the page background colours first so the refraction bakes in, then
> remove the background with a video matting model. Find appropriate recent models for video
> generation and background removal.

This gets you caustics, refraction and physical motion that CSS cannot.

### Scroll-scrubbed transitions between states

Underrated. Most video models interpolate between keyframe images, so two product stills become
a transition clip. Play it on navigation, or scrub it frame by frame against scroll or swipe.

> Build a page that uses a video model to create interactive transitions between screens. Each
> screen shows [object] in a different state, with vertical motion appropriate for scrolling:
> [state 1], then [state 2], then [state 3]. Generate the first frame with image generation,
> then generate a clip from that frame to the next state. Use the final frame of each clip to
> seed the next transition so it continues seamlessly. Scrub the transitions frame by frame as
> the user scrolls. Use a video model with strong physics and consistency.

## Performance

Generated assets have weight, and the house rules say what the target device and network can
carry. A 4K hero image and a looping video are free on a desktop product for designers and
expensive on a mid-range Android phone on patchy data.

Use generated assets freely in prototypes, pitch decks and concept work. Before anything goes
into a shipping product, state the added weight and provide a static fallback for every moving
or heavy asset.
