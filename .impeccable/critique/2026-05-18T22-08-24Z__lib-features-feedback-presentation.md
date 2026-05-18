---
timestamp: 2026-05-18T22-08-24Z
slug: lib-features-feedback-presentation
---
#### Design Health Score

| # | Heuristic | Score | Key Issue |
|---|-----------|-------|-----------|
| 1 | Visibility of System Status | 2/4 | Submitting only shows a minimal `'...'` loading state on the button and pops on success. Silent failure on empty input leaves the user with zero system feedback. |
| 2 | Match System / Real World | 2/4 | The form is a generic modern mobile column and does not match the immersive, highly tactile, calligraphic "cardboard detective game" setting ("The Cardboard Confessional"). |
| 3 | User Control and Freedom | 3/4 | Users can dismiss the sheet easily using the "Close" button, but doing so discards typed content without any confirmation. |
| 4 | Consistency and Standards | 1/4 | Crucial architectural inconsistency: `_contactController` is initialized and passed in the state layer, but **the contact details text field is completely missing from the UI widget tree!** |
| 5 | Error Prevention | 1/4 | Empty submissions are silently ignored in the Cubit. Tapping the "Send" button does nothing, with no front-end guardrails to prevent blank submissions. |
| 6 | Recognition Rather Than Recall | 3/4 | Uses standard hint text placeholders. Lacks quick tactile category chips (e.g. "Bug", "Suggestion", "Role Idea") to minimize keyboard input. |
| 7 | Flexibility and Efficiency | 2/4 | Missing contact input prevents the user from receiving developer responses. No fast shortcuts or templates exist for rapid, pass-around social gaming input. |
| 8 | Aesthetic and Minimalist Design | 2/4 | Highly sterile and bare-bones layout. Lacks hand-drawn paper cutouts, sketchy border textures, and elegant calligraphic headers. |
| 9 | Error Recovery | 1/4 | Because empty submission fails silently, there is no error validation or actionable guidance to help users diagnose and recover from the error. |
| 10 | Help and Documentation | 2/4 | Lacks quick task-focused text instructing players what kind of suggestions are helpful to the game creators. |
| **Total** | | **19/40** | **Poor (Major UX overhaul required; core experience broken)** |

---

#### Anti-Patterns Verdict

* **LLM Design Assessment**: The screen lacks any organic, sketchy feel. It falls into the "bland developer form" trap. By using plain material text fields and borders without a header or descriptive Arabic calligraphy, it completely diverges from the game's immersive physical cardboard identity.
* **Deterministic Scan**: Completed successfully with 0 standard markup violations (as this is a native Flutter codebase).

---

#### Overall Impression

The feedback presentation feature is highly functional in its under-the-hood logic but completely unfinished in its visual execution. It contains a major UI omission where the contact details input is missing entirely despite having controllers and repository support. Visually, it feels sterile and disconnected from the beautifully calligraphic, sketchy Arabic cardboard world of *Imposter*. The biggest opportunity is to transform this sheet from a generic form into a tactile **"Letter to the Detective"** or a rugged paper clue note.

---

#### What's Working

1. **Proper State-to-Navigation Flow**: The `BlocConsumer` handles the success state well, immediately displaying a toast and closing the sheet dynamically.
2. **Haptic Foundation**: The underlying `AppButton` implements tactile spring scale animations and haptics, ensuring interactive clicks have a raw physical feedback feel.

---

#### Priority Issues

* **[P1] Missing Contact Details Input Field**
  * **Why it matters**: The `_contactController` is declared, initialized, and disposed in the state, but is never instantiated as a widget. Users are completely unable to leave their contact email/phone for replies.
  - **Fix**: Add a second `AppTextField` with `controller: _contactController` and proper descriptive labels.
  - **Suggested command**: `impeccable craft`

* **[P1] Silent Failure on Empty Feedback Submission**
  - **Why it matters**: Tapping the send button with an empty text box triggers the tap animation but performs no action and gives no validation feedback, confusing players.
  - **Fix**: Disable the "Send" button when `_feedbackController.text` is empty, or display a specific Arabic validation toast.
  - **Suggested command**: `impeccable harden`

* **[P2] Lack of "Cardboard Confessional" Aesthetic & calligraphic headings**
  - **Why it matters**: The interface lacks the rich ArefRuqaa calligraphic branding, torn paper textures, and sketched outline aesthetics of the game, making it feel like a corporate SaaS app.
  - **Fix**: Add a stylized calligraphic header, a brief hand-written subtitle, and wrap input segments in a torn paper or sketchy board frame.
  - **Suggested command**: `impeccable delight`

* **[P2] Generic Button Loading State**
  - **Why it matters**: Displaying `'...'` as the button title during submission feels like a lazy placeholder and violates the calligraphic brand design system.
  - **Fix**: Show a dedicated, styled Arabic loading title or integrated tactile progress indicators.
  - **Suggested command**: `impeccable polish`

---

#### Persona Red Flags

* **Jordan (First-Timer)**
  * **Red Flag**: Opens the sheet to suggest an idea. Accidental double-tap or blank click on "Send" does absolutely nothing. The app does not tell them why it failed or how to fix it, leading Jordan to assume the button is broken.

* **Casey (Distracted Mobile User)**
  * **Red Flag**: Plays the game at a noisy gathering. Typing long paragraphs on a phone keyboard is stressful and slow. The sheet offers no quick, easy-tap category chips (e.g. "Bug 🐞", "Role Idea 🎭", "Suggest 💡"), forcing extensive typing.

* **Tareq (Gatherer / Social Gamer)**
  * **Red Flag**: Hosts the local gathering. Tareq wants to quickly drop the developer a message so they can reply. But the contact field is completely missing, leaving Tareq with no way to ensure a follow-up.

---

#### Minor Observations

* The text field hints and text sizes should use dynamic responsive values (`context.p(x)`) to scale nicely on diverse screen shapes.
* In the dispose method, both controllers are correctly disposed, which prevents memory leaks.

---

#### Questions to Consider

1. **How might we turn this feedback sheet into a thematic game piece?** What if it were styled as a "Torn Police Report Note" or a "Secret Detective Telegram" with a distinct calligraphic title?
2. **Can we make the submission flow more fluid for passed mobile devices?** What if we added quick-tap emoji category chips to minimize keyboard typing?
3. **What is the ideal way to present the contact field?** Should it be a persistent input, or a progressive disclosure option (e.g. "Want a reply?")?
