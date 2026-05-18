---
target: lib/features/feedback/presentation
total_score: 31
p0_count: 0
p1_count: 2
timestamp: 2026-05-18T22-26-56Z
slug: lib-features-feedback-presentation
---
#### Design Health Score

| # | Heuristic | Score | Key Issue |
|---|-----------|-------|-----------|
| 1 | Visibility of System Status | 3/4 | Submitting displays a CircularProgressIndicator inside the button. However, text fields are not locked during loading, and no inline validation is shown on the fields. |
| 2 | Match System / Real World | 4/4 | Native, colloquial Arabic text makes players feel at home. |
| 3 | User Control and Freedom | 2/4 | Standard close button exists. However, if the user accidentally sweeps down or taps the sheet backdrop, their entire typed feedback is instantly lost without confirmation. |
| 4 | Consistency and Standards | 3/4 | Reusable components are used. However, text fields do not specify RTL text alignment, potentially defaulting to left-alignment on non-Arabic device locales. |
| 5 | Error Prevention | 3/4 | Blank submissions are blocked by the Cubit. However, the Send button remains active even when the text field is empty, rather than using dynamic UI constraints. |
| 6 | Recognition Rather Than Recall | 3/4 | Placeholders are descriptive, but they vanish once typed in, leaving no persistent labels for Casey or other mobile players. |
| 7 | Flexibility and Efficiency | 3/4 | Contact details allow for asynchronous follow-ups. However, no keyboard accelerators (e.g. Enter to submit) or auto-focusing on sheet open exist. |
| 8 | Aesthetic and Minimalist Design | 3/4 | Visual layouts are clean and high-contrast, but a typographic size inversion exists: hint text (22px) is larger than the actual typed input text (18px). |
| 9 | Error Recovery | 4/4 | Instantly displays clear, friendly Arabic validation toast instructing how to fix the issue. |
| 10 | Help and Documentation | 3/4 | Subtitle text concisely aids the user in knowing what to write. |
| **Total** | | **31/40** | **Good (Address weak areas, solid foundation)** |

---

#### Anti-Patterns Verdict

* **LLM Design Assessment**: Re-evaluated under Impeccable guidelines. The bottom sheet is functional and high-contrast, but suffers from mild usability anti-patterns (no keyboard submission, text fields unlocked during loading, and size-inversion in hints).
* **Deterministic Scan**: Executed successfully, showing 0 programmatical slop violations in this directory.

---

#### Overall Impression

The feedback sheet has a very solid and thematic layout in ArefRuqaa typography, blending beautifully with the game's high-contrast "Cardboard Confessional" style. However, its mobile usability can be vastly improved by preventing accidental progress loss, correcting the typographic scale of input fields, and implementing standard inputs locking during API loading states.

---

#### What's Working

1. **Colloquial Localization**: The Arabic phrasing is organic and engaging, fitting perfectly with standard Arabic gaming gatherings.
2. **State and Action Coordination**: Uses dedicated BloC logic (Cubit) to coordinate loading, success, and validation error states reliably.
3. **Themed Custom Modals**: Integrates seamlessly with the custom torn-paper style of `AppBottomSheet` and the paper texture backdrop of `AppButton`.

---

#### Priority Issues

* **[P1] Progress and Data Loss on Accidental Dismissal**: If a user accidentally sweeps the bottom sheet down or taps outside of it while writing feedback, the sheet closes instantly and wipes all their typed progress without confirmation.
  * *Why it matters*: Users typing long suggestions will be extremely frustrated if a slight mobile thumb slippage destroys their entire input.
  * *Fix*: Implement a validation check or confirmation alert on modal pop, or cache the draft locally, or set `isDismissible: false` to force intentional dismissal.
  * *Suggested command*: `impeccable polish`
* **[P2] Text Fields Unlocked During Submission**: Text fields remain fully editable while the submission request is in-flight.
  * *Why it matters*: Allows users to modify or completely delete their feedback *after* pressing send, which can lead to race conditions or confused inputs.
  * *Fix*: Bind the `enabled` attribute of `AppTextField`s to a boolean checking `state is! FeedbackLoading`.
  * *Suggested command*: `impeccable harden`
* **[P2] Inverted Typography Scale**: The placeholder hint font size (`font22W400Primary`) is larger (22px) than the actual typed input text (`font18W700Primary` - 18px).
  * *Why it matters*: Having input text that is physically smaller than the placeholder hint feels cramped, creates a jarring visual scale shift upon active typing, and wastes vertical field space.
  * *Fix*: Align the hint text style to match the typed style or use a smaller/equivalent size like `font18W700Primary` or a custom 18px regular.
  * *Suggested command*: `impeccable typeset`
* **[P3] Missing RTL Alignment Constraint**: `AppTextField` does not enforce `textAlign: TextAlign.right`.
  * *Why it matters*: On systems set to English locales, Arabic input defaults to left-aligned formatting, breaking standard cultural text flow.
  * *Fix*: Set `textAlign: TextAlign.right` explicitly on Arabic input fields inside `AppTextField` or allow customization.
  * *Suggested command*: `impeccable adapt`

---

#### Persona Red Flags

* **Casey (Distracted Mobile User)**: Taps the text field, typing out a detailed report with one hand. Casey gets interrupted by a notification, swipes the screen slightly, accidentally dismissing the bottom sheet. All her written text is immediately erased, leading to high frustration and abandonment.
* **Sam (Accessibility-Dependent User)**: Focuses on the input fields linearly. Once typing inside the text field, the placeholder text disappears entirely. Since there are no persistent text labels above the fields, Sam has to remember whether the second input is for contact email, contact phone, or name.

---

#### Minor Observations

* The thin loading spinner inside `AppButton` uses `AppColors.secondary` (dark brown), which has very low contrast against the textured paper background. Using a brighter accent or thicker stroke would make it much more obvious.
* The button has no keyboard accelerator (e.g. submitting on pressing "Done" on the keyboard).

---

#### Questions to Consider

* Could we cache the unsaved feedback in memory or local storage, so that if the sheet is closed, the next time they open it, their progress is restored?
* Should we disable the "Send" button dynamically when the feedback text field is empty, instead of waiting for a manual tap to show an error toast?
