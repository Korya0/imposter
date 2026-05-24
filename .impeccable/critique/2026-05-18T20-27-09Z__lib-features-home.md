---
target: lib/features/home
total_score: 32
p0_count: 1
p1_count: 2
timestamp: 2026-05-18T20-27-09Z
slug: lib-features-home
---
# Critique Report: lib/features/home

## Design Health Score

| # | Heuristic | Score | Key Issue |
|---|-----------|-------|-----------|
| 1 | Visibility of System Status | 3/4 | The screen loads instantly, but the buttons pop in statically without entering animations. |
| 2 | Match System / Real World | 3/4 | Excellent calligraphic font and paper textures, but the backdrop lacks cardboard/desk layout cues and buttons have no physics-backed tap compression. |
| 3 | User Control and Freedom | 4/4 | Simple and transparent navigation controls are solid. |
| 4 | Consistency and Standards | 3/4 | Standard button styles, but hardcoded heights and slightly mismatched text sizes (font32 vs font36) create slight layout inconsistencies. |
| 5 | Error Prevention | 4/4 | Minimal inputs on the home screen keep this robust. |
| 6 | Recognition Rather Than Recall | 3/4 | Placed secondary helpers ("How to Play" and "Feedback") above the primary action, increasing search time. |
| 7 | Flexibility and Efficiency | 2/4 | Passing the device in active gathering environments requires instant recognition. The lack of haptic feedback on custom button taps hampers physical confirmation. |
| 8 | Aesthetic and Minimalist Design | 2/4 | In a tactile game, the screen background is standard flat black. The layout uses `MainAxisAlignment.spaceEvenly`, causing a massive sterile void in the center of tall mobile screens. The main calligraphic branding text is hidden. |
| 9 | Error Recovery | 4/4 | Robust navigation controls with back/close sheets prevent any locks. |
| 10 | Help and Documentation | 4/4 | Clear, high-visibility "How to Play" action opens a sheet immediately. |
| **Total** | | **32/40** | **Good (Average Production Quality)** |

---

## Anti-Patterns Verdict

### Does this look AI-generated?
**No.** The layout is intentionally minimal and dark, using a flat background rather than generic SaaS dashboards, gradients, or glowing neon cyber-aesthetics. The typography uses the rich and authentic Arabic `ArefRuqaa` calligraphic style.

### LLM Assessment
While the core elements avoid common AI design tropes (no identical card grids, no glassmorphism, no side-stripe borders), it misses opportunities to make the "cardboard detective" theme truly pop:
1. **No Physical Compression**: Interactive button elements do not shrink/wiggle by 5% when tapped, violating the "Spring-Scale Action Rule" in `DESIGN.md`.
2. **Branding Text is Hidden**: The main game logo header has `showText: false` applied, hiding the calligraphic identity "مخفي" or "Spy" that would immediately set the cultural and aesthetic tone.
3. **Flat Backdrop**: The background is a solid `#000000` void rather than a textured cardboard surface or mystery evidence board.

### Deterministic Scan
The automated impeccable scanner completed with `0` findings, confirming that no raw HTML/JS/CSS design anti-patterns (such as side-stripe borders or text-gradient slop) are hardcoded into the layout.

---

## Overall Impression
The Home Screen has the bones of a great culturally-authentic game, but it currently behaves like a flat, sterile utility app instead of a physical, tactile cardboard game. By introducing physical press scaling, adding entrance animations to buttons, balancing the space evenly void, and showing the gorgeous calligraphic branding text, we can transform this into a high-stakes, responsive detective dashboard that wows players.

---

## What's Working
* **Calligraphic Elegance**: The styling uses the classic `ArefRuqaa` font beautifully for main headers and buttons, establishing an excellent Arabic cultural heritage context.
* **Paper-Cutout Texture**: The custom `AssetImage(AppAssets.paperWebp)` button background provides a lovely physical, organic hand-made feel to interactive targets.
* **Mobile Pass-Around Readiness**: The tap areas and padding (`AppPadding.viewH22(context)`) are generous, preventing accidental selections when passing the device.

---

## Priority Issues

### [P0] Missing Tactile Button Compression and Haptic Feedback
* **Why it matters**: In a pass-around physical game, players expect a rich, juicy response when pressing buttons. Currently, the buttons have no physics-backed tap compression (shrinking 5% on active press) and do not fire haptics (`HapticFeedback.lightImpact()`), violating the core "Spring-Scale Action Rule" in `DESIGN.md`.
* **Fix**: Wrap `AppButton`'s child in an interactive spring animation widget that scales down to `0.95` on tap and triggers light haptic impact feedback.
* **Suggested command**: `animate`

### [P1] Inverted Visual Hierarchy
* **Why it matters**: First-time and returning players scan from top to bottom. The primary call-to-action (CTA) "لنبدأ اللعب" (Let's Go) is placed at the very bottom, while less important utility links ("How to Play" and "Feedback") are placed *above* it. This creates unnecessary cognitive friction.
* **Fix**: Position the main "لنبدأ اللعب" (Let's Go) button as the dominant central action, placing the two secondary options side-by-side below it.
* **Suggested command**: `layout`

### [P1] Massive Sterile Void in Screen Center
* **Why it matters**: `_HomeViewBody` lays out the header and buttons inside a `Column` using `MainAxisAlignment.spaceEvenly`. On modern tall mobile devices (e.g. 19.5:9 aspect ratios), this pushes the logo to the absolute top and the buttons to the absolute bottom, leaving a large, dead black void in the middle of the screen, which breaks layout cohesion.
* **Fix**: Group the logo and a beautifully structured calligraphic subtitle closer together, adjust layout weights, and use explicit spacing with responsive vertical gaps rather than flat `spaceEvenly`.
* **Suggested command**: `layout`

### [P2] Main Calligraphic Branding Text is Hidden
* **Why it matters**: On the main landing page, the brand identity should be loudest. Currently, `AppLogoHeader` has `showText: false` set in `HomeView`, which hides the majestic calligraphic game name.
* **Fix**: Set `showText: true` on `AppLogoHeader` inside `HomeView`, ensuring the calligraphic `ArefRuqaa` game title animates in alongside the logo.
* **Suggested command**: `polish`

---

## Persona Red Flags

### Alex (Power User)
* **Feedback**: "I tap buttons quickly, but they feel like static images. There is no haptic click or visual bounce confirming my input instantly. Passing the phone around feels slow because I have to look closely at the screen to see if my tap registered."

### Jordan (First-Timer)
* **Feedback**: "When the screen loads, the first buttons I see are 'How to Play' and 'Feedback' sitting on top. I had to scan all the way to the bottom to find the actual 'Let's Go' button. The layout felt upside down."

---

## Minor Observations
* **Button Height Hardcoding**: In `AppButton`, height is hardcoded to `60` by default. In `HomeButtonsSection`, secondary buttons use `font32W700Secondary` while primary uses the default `font36W700Secondary`. The text heights may clip slightly on small screens since the height is fixed to 60.
* **Lack of Entry Choreography**: The main logo header slides and fades in beautifully, but the buttons section snaps onto the screen immediately, creating a jarring, uncoordinated initial loading sequence.
