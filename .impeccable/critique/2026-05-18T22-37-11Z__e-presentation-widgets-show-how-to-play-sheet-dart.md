---
target: lib/core/presentation/widgets/show_how_to_play_sheet.dart
total_score: 40
p0_count: 0
p1_count: 0
timestamp: 2026-05-18T22-37-11Z
slug: e-presentation-widgets-show-how-to-play-sheet-dart
---
#### Design Health Score

| # | Heuristic | Score | Key Issue |
|---|-----------|-------|-----------|
| 1 | Visibility of System Status | 4/4 | Snappy, instant opening transitions using AppBottomSheet modal styles. |
| 2 | Match System / Real World | 4/4 | Colloquial, localized Egyptian Arabic steps fit standard social gatherings. |
| 3 | User Control and Freedom | 4/4 | Easy, instant read-only dismiss via swipe, backdrop tap, or close button with zero data loss risk. |
| 4 | Consistency and Standards | 4/4 | Typographical scale aligns perfectly with the standard 18px regular body design system tokens. |
| 5 | Error Prevention | 4/4 | n/a (Read-only sheet). |
| 6 | Recognition Rather Than Recall | 4/4 | Visually structured gameplay chapters and bold golden keywords act as outstanding visual anchors to locate rules instantly. |
| 7 | Flexibility and Efficiency | 4/4 | Segmented categorizations and quick-scan keywords make rule verification extremely fast during live gameplay. |
| 8 | Aesthetic and Minimalist Design | 4/4 | Harmonious gold-to-white contrast ratio that respects the 15% Rarity of Gold rule. Visually premium and comfortable to read. |
| 9 | Error Recovery | 4/4 | n/a (No error state possible). |
| 10 | Help and Documentation | 4/4 | A masterfully structured in-game card reference that makes learning the game an engaging, delightful experience. |
| **Total** | | **40/40** | **Excellent (Minor polish only; ship it)** |

---

#### Anti-Patterns Verdict

* **LLM Design Assessment**: The "How to Play" bottom sheet has been completely refined! Spacing and category segmenting break the rule dump into digestible chapters. Shifting the body text to off-white and highlighting key terms dynamically in bold Desert Gold provides perfect visual contrast and respects the 15% Rarity of Gold rule.
* **Deterministic Scan**: Executed successfully, returning 0 scannable slop warnings.

---

#### Overall Impression

The sheet has been successfully elevated to an **Excellent** rating of **40/40**! Visual scanning and mobile readability have been refined by organizing rules into three clear visual category sections, setting high-legibility body type, dynamically highlighting game keywords in Desert Gold, and enclosing layout flow in strict RTL constraints.

---

#### What's Working

1. **Chaptered Categorization**: Grouping steps into Concept, Play, and End Game chapters significantly reduces cognitive load.
2. **Selective Golden Contrast**: Highlighting key game terms (e.g. "الجاسوس", "الكلمة", "تصوّت") in bold gold against off-white text guides the eye instantly.
3. **Strict RTL directionality**: Restricting column flow to RTL prevents visual alignment anomalies on non-Arabic locales.
