---
target: lib/core/presentation/widgets/show_how_to_play_sheet.dart
total_score: 31
p0_count: 0
p1_count: 3
timestamp: 2026-05-18T22-34-50Z
slug: e-presentation-widgets-show-how-to-play-sheet-dart
---
#### Design Health Score

| # | Heuristic | Score | Key Issue |
|---|-----------|-------|-----------|
| 1 | Visibility of System Status | 4/4 | Instant, snappy opening animation from the home screen using AppBottomSheet modal styles. |
| 2 | Match System / Real World | 4/4 | Excellent Arabic wording. Phrasing is natural, humorous, and captures the friendly gathering game spirit. |
| 3 | User Control and Freedom | 4/4 | Read-only sheet is easy to close via backdrop tap, drag down, or the close button, with no dirty state risks. |
| 4 | Consistency and Standards | 2/4 | Typographical hierarchy is neglected: uses enormous 22px bold Desert Gold text for multi-line body list items, breaking design standards. |
| 5 | Error Prevention | 4/4 | n/a (Read-only reference sheet). |
| 6 | Recognition Rather Than Recall | 2/4 | No visual grouping or segmentation of rules. Players must search the entire wall of 10 steps to find a specific rule during gameplay. |
| 7 | Flexibility and Efficiency | 2/4 | Flat list format makes quick rule verification slow. Needs structural segments (e.g. Roles, Gameplay, Voting). |
| 8 | Aesthetic and Minimalist Design | 2/4 | Violates the "Rarity of Gold" design system rule. The entire body is rendered in saturated gold, creating massive visual noise. |
| 9 | Error Recovery | 4/4 | n/a (No error state possible). |
| 10 | Help and Documentation | 3/4 | Localized steps are highly informative, but visual layout degrades their scan-readability. |
| **Total** | | **31/40** | **Good (Address weak areas, solid foundation)** |

---

#### Anti-Patterns Verdict

* **LLM Design Assessment**: The "How to Play" sheet currently presents a heavy, undifferentiated **wall of text**. Coloring every single line of the 10 steps in bright Desert Gold violates the *Rarity of Gold* rule (which mandates gold occupies under 15% of the screen). This creates high visual fatigue. The bold 22px typographic scale is also way too large for body copy, making it look like a series of headlines rather than readable game guidelines.
* **Deterministic Scan**: Executed successfully, returning 0 scannable slop warnings (as standard in custom Flutter configurations).

---

#### Overall Impression

The textual content is absolutely brilliant and localized perfectly for Egyptian/Arabic players. However, its visual execution feels heavy and uncurated. By breaking the 10 rules into structured visual categories (e.g. Setup, Game Loop, Win Conditions), reducing the typographic scale, and shifting the body text to high-legibility white/off-white (leaving gold exclusively for emphasis), we can transform a tiring read into a beautifully premium, easy-to-scan reference card.

---

#### What's Working

1. **Snappy & Intuitive Integration**: Leverages `AppBottomSheet` and fits nicely within the global navigation and modal transitions.
2. **Humorous and Conversational Copy**: Phrased beautifully, avoiding stiff instructions and matching the lighthearted mood of social deduction games.
3. **Clean Number Indicators**: The circle indicators are high-contrast (black numbers inside primary gold circle widgets), forming distinct visual anchors.

---

#### Priority Issues

* **[P1] Visual Overstimulation & Rarity of Gold Violation**:
  * *Why it matters*: Saturated gold text covers nearly 80% of the screen. Since everything is gold, the primary gold elements (headers, numbers) lose their highlighting power, and the screen feels loud and fatiguing to read.
  * *Fix*: Set the rule body text style to standard high-legibility off-white (e.g. `AppColors.white.withValues(alpha: 0.8)` or a clean 18px white font), reserving `Desert Gold` only for headers, numbers, and key emphasized words.
  * *Suggested command*: `impeccable colorize` (specifically to optimize color weight and contrast)
* **[P2] Lacks Layout Grouping (Wall of Text)**:
  * *Why it matters*: Presenting 10 rules in a flat list forces Jordan (first-timer) to scan the entire block sequentially. There's no division between who the Spy is, how asking questions works, or how players vote.
  * *Fix*: Structure the list into 3 distinct visual sections (e.g., "فكرة اللعبة والأدوار" for steps 1-2, "طريقة اللعب" for steps 3-6, and "نهاية الدور والتصويت" for steps 7-10) using small, stylized category headers and custom sketchy dividers.
  * *Suggested command*: `impeccable layout`
* **[P2] Over-scaled Typography (Enormous Body Copy)**:
  * *Why it matters*: Size 22px bold copy is too large for paragraphs. It restricts the line length, causing text lines to wrap frequently, which makes the sheet excessively tall on smaller mobile screens and forces painful vertical scrolling.
  * *Fix*: Set the step text size to standard body size (18px) and regular weight (`FontWeightHelper.w400.weight`).
  * *Suggested command*: `impeccable typeset`
* **[P3] Lack of Directionality Safety**:
  * *Why it matters*: While the text elements are right-aligned internally on Arabic locales, standard `Row` children (the circle number and text) may flip visually based on the global context language, potentially rendering number-on-left layout bugs on English system locales.
  * *Fix*: Explicitly wrap the modal contents in a `Directionality(textDirection: TextDirection.rtl, ...)` to ensure the Arabic numbers and rules lay out consistently from right-to-left regardless of system language settings.
  * *Suggested command*: `impeccable adapt`

---

#### Persona Red Flags

* **Jordan (First-Timer)**: Opens "How to Play" to quickly check a rule during a live round. Jordan is met with a massive, continuous wall of bright gold text. Feeling overwhelmed by the cognitive reading load, Jordan closes the sheet immediately and guesses the rules blindly, leading to a poor first-game experience.
* **Casey (Distracted Mobile User)**: Glances at the instructions in a dimly lit coffee shop. The absolute black background contrasted with a screen full of bright, bold, 22px golden text creates high visual glare. Casey finds the text wrapping frequently on her compact screen, forcing extensive scrolling to read all 10 steps.

---

#### Questions to Consider

* Could we group the rules into distinct cardboard evidence cards or clean collapsible sections to make the interface feel even more physical?
* Should we emphasize key game terms (like "الجاسوس" or "المواطنين") in Desert Gold while keeping the rest of the sentence in off-white?
