# تقرير المخالفات لقواعد المشروع في مجلد العرض (`lib/core/presentation`) وتاسكات الإصلاح

بعد مقارنة الكود الموجود في مجلد `lib/core/presentation` بملف القواعد المركزي `.gemini/CLAUDE.md` و `.gemini/PROJECT_STRUCTURE.md`، تم رصد عدة مخالفات للقواعد الهندسية الصارمة المعمول بها في المشروع.

المخالفات تنقسم بشكل أساسي إلى:
1. **الأرقام والأحجام الثابتة (Hardcoded Sizes)**: وهو أمر محظور تماماً، حيث يجب استخدام امتدادات responsive على الـ `BuildContext` (مثل `context.h`, `context.w`, `context.p`, `context.s`).
2. **تجاوز الحد الأقصى لطول الكلاس في الوجت (Widget Class Size > 60 Lines)**: يمنع أن يتجاوز كلاس الوجت الواحد 60 سطراً من الكود للحفاظ على قابلية القراءة والأداء.
3. **استخدام Navigator الأصلي (Native Navigation)**: يُحظر استخدام `Navigator` مباشرة، ويُفرض استخدام `GoRouter` بشكل استحواذي في كل ما يخص التنقل وفحص حالة التنقل.

---

## 📋 حالة تنفيذ المهام (Tasks Execution Status)

### 📌 التجمع الأول: حل مشاكل الأرقام والأبعاد الثابتة (Hardcoded Dimensions Tasks)

#### ✅ [تم التنفيذ] المهمة 1: إصلاح الأبعاد الثابتة في `AppAnalogClock`
* **المسار**: [app_analog_clock.dart](file:///d:/flutter/flutter_Projects/imposter/lib/core/presentation/widgets/app_analog_clock.dart)
* **المخالفة**:
  * قيمة الحجم الافتراضية `this.size = 200` هي قيمة ثابتة لا تستخدم الـ Responsive sizing.
  * حجم النقاط المركزية في الرسم (`6` و `3`) ثابت تماماً وغير مستجيب.
* **الحل المنفذ**:
  * إزالة القيمة الافتراضية الثابتة من البارامترات وجعل الحجم الافتراضي يعتمد على `context.s(200)` داخل الـ `build`.
  * تحويل أبعاد الرسم داخل الـ `_ClockPainter` لتكون نسبية بالكامل بالاعتماد على الـ `radius` الفعلي (مثال: `radius * 0.1` و `radius * 0.06` و `radius * 0.03`) مما يحقق استجابة مثالية في الرسم بدون أي قيم صلبة.

#### ✅ [تم التنفيذ] المهمة 2: إصلاح العرض الثابت في `AppValueAdjuster`
* **المسار**: [app_value_adjuster.dart](file:///d:/flutter/flutter_Projects/imposter/lib/core/presentation/widgets/app_value_adjuster.dart)
* **المخالفة**:
  * العرض الافتراضي `this.width = 50` ثابت، ويتم تمريره مباشرة لـ `SizedBox(width: width)`.
* **الحل المنفذ**:
  * إزالة العرض الافتراضي الثابت وجعل العرض الافتراضي ديناميكياً باستخدام `context.w(50)` داخل الـ `build`.

#### ✅ [تم التنفيذ] المهمة 3: إصلاح الأبعاد الثابتة في `CustomDialog` و `showCustomDialog`
* **المسار**: [custom_dialog.dart](file:///d:/flutter/flutter_Projects/imposter/lib/core/presentation/widgets/custom_dialog.dart)
* **المخالفة**:
  * هناك قيم افتراضية صلبة غير مستجيبة لـ `borderRadius = 16` و `padding = const EdgeInsets.all(24)` و `insetPadding = const EdgeInsets.symmetric(horizontal: 40, vertical: 24)`.
* **الحل المنفذ**:
  * تم استيراد `build_context_extension.dart` وتعديل البارامترات لتكون اختيارية (Nullable).
  * تم تطبيق قيم مستجيبة بالكامل داخل الـ `build` باستخدام `context.p(16)` للـ Border radius، و `context.p(24)` للـ Padding، و `context.w(40)` / `context.h(24)` للـ insetPadding، و `context.w(1)` للـ Border width.

#### ✅ [تم التنفيذ] المهمة 4: إصلاح الأبعاد الثابتة في `AppSketchyCard`
* **المسار**: [app_sketchy_card.dart](file:///d:/flutter/flutter_Projects/imposter/lib/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart)
* **المخالفة**:
  * القيم الافتراضية للحد الأدنى للعرض والارتفاع صلبة وغير مستجيبة (`minWidth = 250` و `minHeight = 150`).
* **الحل المنفذ**:
  * تم جعل أبعاد الحد الأدنى اختيارية وتطبيق التحجيم الديناميكي داخل كلاس العرض `_InteractiveSketchyCard` باستخدام `context.w(250)` و `context.h(150)`.

#### ✅ [تم التنفيذ] المهمة 5: تعديل الحد الأقصى للعرض في `AppBottomSheet` ليتوافق مع هوية المشروع
* **المسار**: [app_bottom_sheet.dart](file:///d:/flutter/flutter_Projects/imposter/lib/core/presentation/widgets/app_bottom_sheet/app_bottom_sheet.dart)
* **المخالفة**:
  * استخدام `maxWidth: 550` كقيمة ثابتة يخالف هوية التصميم المحددة في ملف `PROJECT_STRUCTURE.md` التي تنص على أن الحد الأقصى للعرض هو `500px`.
* **الحل المنفذ**:
  * تغيير الحد الأقصى للعرض `maxWidth` ليكون `500` ليتماشى تماماً مع هوية المشروع والـ Boundary Limit.

---

### 📌 التجمع الثاني: تقسيم الكود وتقليل أحجام الكلاسات (Code Modularization Tasks)

> [!NOTE]
> **تم تجاوز هذه القاعدة بالكامل بناءً على طلب المستخدم الصريح للاحتفاظ بالملفات والكلاسات في حجمها الحالي دون تجزئة.**

#### ⚠️ [تم التجاوز بطلب المستخدم] المهمة 6: تقسيم كود `AppTextField` لتلبية شرط الحد الأقصى لعدد الأسطر (<= 60 سطر)
* **المسار**: [app_text_field.dart](file:///d:/flutter/flutter_Projects/imposter/lib/core/presentation/widgets/app_text_field.dart)

#### ⚠️ [تم التجاوز بطلب المستخدم] المهمة 7: اختصار أو تقسيم `CustomScrollScaffold` (62 سطراً)
* **المسار**: [custom_scroll_scaffold.dart](file:///d:/flutter/flutter_Projects/imposter/lib/core/presentation/widgets/custom_scroll_scaffold.dart)

#### ⚠️ [تم التجاوز بطلب المستخدم] المهمة 8: تقسيم أو اختصار `CustomSliverAppBar` (64 سطراً)
* **المسار**: [custom_sliver_app_bar.dart](file:///d:/flutter/flutter_Projects/imposter/lib/core/presentation/widgets/custom_sliver_app_bar.dart)

#### ⚠️ [تم التجاوز بطلب المستخدم] المهمة 9: مراجعة وتقسيم ملف `app_sketchy_card.dart`
* **المسار**: [app_sketchy_card.dart](file:///d:/flutter/flutter_Projects/imposter/lib/core/presentation/widgets/app_sketchy_card/app_sketchy_card.dart)

---

### 📌 التجمع الثالث: إصلاح حصر التوجيه ونظام الملاحة (Navigation Engine Purity Tasks)

#### ✅ [تم التنفيذ] المهمة 10: إزالة الاستخدام المباشر لـ `Navigator` في `CustomSliverAppBar`
* **المسار**: [custom_sliver_app_bar.dart](file:///d:/flutter/flutter_Projects/imposter/lib/core/presentation/widgets/custom_sliver_app_bar.dart)
* **المخالفة**:
  * استخدام `Navigator.canPop(context)` بالتداخل مع GoRouter.
* **الحل المنفذ**:
  * تم تعديل فحص إمكانية الرجوع للاعتماد حصرياً وبالكامل على `GoRouter.of(context).canPop()`، مما يحقق حصر التنقل وإزالته للـ Navigator التقليدي نهائياً من الوجت المشتركة.
