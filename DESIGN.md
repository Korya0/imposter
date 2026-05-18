---
name: Imposter
description: A highly tactile, hand-drawn paper-cutout social deduction game in Arabic.
colors:
  primary: "#c3a24b"
  secondary: "#4c2d09"
  green: "#43a047"
  white: "#ffffff"
  background: "#000000"
  secondary-background: "#303230"
typography:
  display:
    fontFamily: "ArefRuqaa, system-ui, sans-serif"
    fontWeight: 700
    letterSpacing: "normal"
  body:
    fontFamily: "ArefRuqaa, system-ui, sans-serif"
    fontWeight: 400
    letterSpacing: "normal"
rounded:
  sm: "4px"
  md: "8px"
spacing:
  sm: "8px"
  md: "16px"
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.secondary}"
    rounded: "{rounded.sm}"
  card-primary:
    backgroundColor: "{colors.background}"
    textColor: "{colors.primary}"
    rounded: "{rounded.sm}"
---

# Design System: Imposter

## 1. Overview

**Creative North Star: "The Cardboard Confessional"**

Imposter's design system is an expressive, highly physical visual language that blends raw, organic, sketchy elements with rich calligraphic heritage. The entire interface feels like a tangible desktop game made of hand-cut cardboard, torn paper sheets, and rough graphite doodles. Deep black shadows anchor gold-tinted paper textures, creating a mysterious, high-contrast detective board that comes alive through playful animations and spring-based physical gestures.

This system rejects sterile flat-design systems (like clean vector shapes and modern gray grids) and avoids the futuristic glow of neon cyber-aesthetics. The interface must always feel hand-made, highly tactile, and culturally authentic.

**Key Characteristics:**
- **Hand-Drawn Tactility**: Outline borders are dynamically hand-sketched via custom painters and asset backdrops, avoiding perfect geometric shapes.
- **Antique Calligraphic Heritage**: High contrast and elegant calligraphic headers using the Arabic `ArefRuqaa` font.
- **Physical Spring Feedback**: Every action reacts physically (shrinking on tap, spring launches, and tactile haptic wiggles).

## 2. Colors

The color strategy is Committed, relying on a stark gold-on-black layout where primary colors carry high contrast and state transitions are visually distinct.

### Primary
- **Desert Gold** (#c3a24b): The primary color of mystery and heritage. Used for all hand-drawn custom painted borders, primary calligraphic headers, active selections, and highlight text.

### Secondary
- **Burnt Charcoal** (#4c2d09): A rich, warm gold-brown used primarily for primary button text, active ink effects, and deep shadow accents.

### Neutral
- **Stark Abyss** (#000000): The infinite dark background representing the void over which our sketchy cardboard game pieces float.
- **Graphite Grey** (#303230): Used for secondary backgrounds, dialog dividers, and inactive borders.
- **Clean Canvas** (#ffffff): Pure white, used sparingly for standard subheadings, body text description, and maximum legibility.

### Accent Green
- **Safe Zone** (#43a047): Used exclusively to show correct state matches, safe-zone timer segments, and round completion views.

### Named Rules
**The Rarity of Gold Rule.** Desert Gold (#c3a24b) is a powerful, saturated brand asset. It should cover no more than 15% of any screen surface, standing out sharply against the absolute black backdrop to direct the player's eye immediately.
**The No-Gradient Rule.** Gradients are strictly prohibited. Every color is flat and solid, deriving its texture exclusively from underlying hand-drawn raster paper maps or custom sketchy lines.

## 3. Typography

**Display Font:** ArefRuqaa (with bold weight 700)
**Body Font:** ArefRuqaa (with regular weight 400)

**Character:** A highly distinct, calligraphic Arabic pairing. `ArefRuqaa` evokes the luxury and history of Arabic script, which creates an intriguing, high-stakes detective board feel when contrasted against rugged hand-made shapes.

### Hierarchy
- **Display** (weight 700, size 45px, line-height 1.2): Secret role assignment displays, game end summaries, and primary screen headers.
- **Headline** (weight 700, size 36px, line-height 1.2): Section titles, timers, and button titles.
- **Title** (weight 700, size 24px, line-height 1.3): Settings option titles, category cards, and dialog headers.
- **Body** (weight 400, size 18px, line-height 1.5): Standard descriptions, instructions, and list labels. Max line length is 65ch.
- **Label** (weight 400, size 14px, letter-spacing normal): Small secondary counts, timer units, and metadata.

### Named Rules
**The Calligraphic Dominance Rule.** Every visual text element in the game must use `ArefRuqaa`. Standard system sans-serif is only permitted as a fallback in platform exceptions, preserving the immersive visual world.

## 4. Elevation

Depth is communicated entirely by physical paper layers and hand-drawn double outlines, rather than CSS-style radial blurs or soft shadows.

### Shadow Vocabulary
- **Sketchy Outline Offset** (stroke-width 2.0, paint-offset 4.0): Depth is conveyed by drawing an additional black custom stroke offset to the bottom-right, creating a clean hand-sketched shadow.

### Named Rules
**The Flat-Ink Shadow Rule.** Soft, blurry drop-shadows are banned. All elevations are represented by drawing solid offset outlines or stacking hand-cut paper layers with black margins.
**The Spring-Scale Action Rule.** When interactive elements are touched, they must scale down by 5% (to 95% scale) within 150ms using spring-like curves, mimicking physical card compression.

## 5. Components

Every sketchy widget should be large and tactile, optimized for passing the mobile device between players.

### Buttons
- **Shape:** Rectangular container utilizing the sketchy `AssetImage(AppAssets.paperWebp)` backdrop.
- **Primary:** Warm golden ArefRuqaa text (#4c2d09) centered on the rough paper backdrop with generous padding.
- **Hover / Active:** Shrinks slightly to 95% scale with a brief spring duration (150ms) and triggers light haptic feedback (`HapticFeedback.lightImpact()`).

### Cards / Containers
- **Corner Style:** Custom drawn, rugged borders using the dynamic `SketchyCardPainter`.
- **Background:** Stark Abyss black or Graphite Grey, framed by Desert Gold hand-sketched lines.
- **Shadow Strategy:** Offset black lines to indicate elevation.
- **Signature Tape Accent:** A custom painted piece of grey masking tape is drawn centered on top of primary category cards to enhance the "detective evidence board" vibe.

### Inputs / Fields
- **Style:** A sketchy hand-drawn border enclosing an input field, utilizing white text on dark grey container assets.
- **Focus:** Border paint thickens from 2.0 to 3.0 stroke width, transitioning dynamically without soft halos.

### Navigation
- **Style:** Minimalist custom app bar using sketched lines as divider borders and high-contrast gold ArefRuqaa icons.

## 6. Do's and Don'ts

### Do:
- **Do** use `ArefRuqaa` for all display text and Arabic game commands.
- **Do** incorporate `HapticFeedback.lightImpact()` on all custom button taps to give physical confirmation.
- **Do** draw custom outlines with `SketchyCardPainter` to represent card segments and frames.
- **Do** use thick borders and golden highlights to maintain high readability in low-light gathering settings.

### Don't:
- **Don't** use standard material default rounded buttons or clean flat gray grids (avoids the SaaS Cliché).
- **Don't** use neon gradients or soft drop-shadow blurs (avoids the Neon Cyberpunk style).
- **Don't** allow text blocks to expand beyond 65 characters without proper horizontal margins (maintains Pass-Around legibility).
- **Don't** use side-stripe borders greater than 1px as a colored accent on lists or cards (banned pattern).
