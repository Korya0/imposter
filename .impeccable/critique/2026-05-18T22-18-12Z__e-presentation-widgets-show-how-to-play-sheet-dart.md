---
timestamp: 2026-05-18T22-18-12Z
slug: e-presentation-widgets-show-how-to-play-sheet-dart
---
#### Design Health Score

| # | Heuristic | Score | Key Issue |
|---|-----------|-------|-----------|
| 1 | Visibility of System Status | 3/4 | User can see steps sequentially, but lacks visual feedback on reading progress or scrolling position. |
| 2 | Match System / Real World | 2/4 | Step numbers are flat perfect vector circles. Overriding font weights to bold turns elegant Arabic script into standard corporate bullet points. |
| 3 | User Control and Freedom | 1/4 | **Severe Layout Blocker**: The sheet is not scrollable! Users have no way to scroll down to read the full list of 10 steps, locking them in. |
| 4 | Consistency and Standards | 2/4 | Step text overrides the core `Body` styles to use a heavy bold gold (`font22W400Primary` copied with `w700`), violating the 18px body and 65ch rhythm rules. |
| 5 | Error Prevention | 2/4 | A bottom overflow banner is highly likely to trigger on average screen sizes because a standard `Column` is used instead of a scrollable viewport. |
| 6 | Recognition Rather Than Recall | 3/4 | List index helps sequence instructions, but lack of contextual visual symbols or sketchy dividers forces extensive verbal scanning. |
| 7 | Flexibility and Efficiency | 2/4 | Passing a phone with a dense, non-scrollable bold text wall slows down noisy local gathering parties. |
| 8 | Aesthetic and Minimalist Design | 2/4 | Visual composition is sterile and misses the core "Cardboard Confessional" style. No paper tape, sketchy card outlines, or flat-ink shadows. |
| 9 | Error Recovery | 2/4 | If the screen overflows, the user is trapped and cannot recover because scrolling is physically impossible. |
| 10 | Help and Documentation | 3/4 | The sheet acts as the core documentation, but its layout constraints render it physically unreadable on many devices. |
| **Total** | | **22/40** | **Acceptable (Address weak areas, solid foundation)** |

---

#### Anti-Patterns Verdict

* **LLM Design Assessment**: The widget relies on a rigid Material column layout and standard vector container shapes. The circle index containers are perfect vector shapes instead of hand-drawn paper cutouts or flat offset squares. This breaks the tactile cardboard aesthetics required by the creative core direction.
* **Deterministic Scan**: Passed cleanly with 0 violations (non-markup target).

---

#### Overall Impression

The "How to Play" bottom sheet is a highly critical screen for user onboarding, yet it contains a severe layout bug: it does not support scrolling. In addition, its visual styling falls into the "clinical developer form" trap with clean circles and heavy text weights. By converting this screen into a scrollable, highly tactile list using cardboard-styled badges and proper responsive line spacing, we can make reading the game rules feel like reading a mysterious secret dossier.

---

#### What's Working

1. **Clean List Parsing**: Mapping the centralized `AppStrings.howToPlaySteps` list with their indices dynamically is elegant and clean.
2. **Proper Spacing Foundation**: Spacing of 16px bottom padding on row items creates a reasonable vertical rhythm.

---

#### Priority Issues

* **[P0] Non-Scrollable List Overflow**
  * **Why it matters**: The list has 10 paragraphs, which exceeds the height of standard mobile viewports, causing a bottom overflow crash (yellow-and-black stripes) and hiding half the rules.
  * **Fix**: Wrap the list column inside a `SingleChildScrollView` or use a `ListView`.
  * **Suggested command**: `impeccable layout`

* **[P1] Vector Circles & Inconsistent Cardboard Aesthetic**
  * **Why it matters**: Perfect circular index badges feel like a generic SaaS tutorial instead of a hand-made cardboard tabletop game.
  * **Fix**: Replace the perfect circles with hand-drawn physical offset cardboard badges with sketchy solid shadows.
  * **Suggested command**: `impeccable delight`

* **[P2] Text Weight & Size Clamour**
  * **Why it matters**: Displaying all 10 long steps in large 22px bold primary gold text creates visual monotony and cognitive fatigue.
  * **Fix**: Style the step numbers in high-contrast Burnt Charcoal on Desert Gold, and use standard 18px body weight for the instructions.
  * **Suggested command**: `impeccable typeset`

---

#### Persona Red Flags

* **Jordan (First-Timer)**
  * **Red Flag**: Eager to learn the rules. Jordan opens the sheet and sees a yellow layout crash banner at the bottom. Half the steps are invisible, making it impossible to learn how to play. Jordan closes the app in disappointment.

* **Tareq (Gatherer / Social Gamer)**
  * **Red Flag**: Tareq passes his device around to teach new players. Because the text is formatted as a single dense block of bold gold sentences, players take too long to read it, stalling the lively party.

---

#### Minor Observations

* The bottom padding is hardcoded to 16px. Using responsive sizing (`context.p(16)`) would fit various device scales more elegantly.
* The method lacks proper compile-time const modifiers on child subtrees.

---

#### Questions to Consider

1. **How can we make these rules easier to digest in a social party?** What if each rule was formatted as a separate card or a paginated booklet that players can swipe through?
2. **Can we make the index numbers look like raw game pieces?** What if the number badges were styled as pieces of torn cardboard with raw black outline offsets?
3. **What is the best way to divide these steps visually?** Should we add subtle hand-drawn horizontal graphite divider lines between instructions?
