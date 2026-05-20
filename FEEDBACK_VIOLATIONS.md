# 📋 تقرير مخالفات المعايير الهندسية وجدول المهام الجاهزة للتنفيذ (Feedback Feature Refactoring)

تم إجراء مراجعة دقيقة وشاملة لملفات ميزة الدعم (`lib/features/feedback`) ومقارنتها بقواعد وقوانين المشروع المحددة في [CLAUDE.md](file:///d:/flutter/flutter_Projects/imposter/.gemini/CLAUDE.md) و [PROJECT_STRUCTURE.md](file:///d:/flutter/flutter_Projects/imposter/.gemini/PROJECT_STRUCTURE.md).

تم الانتهاء من جميع التعديلات بنجاح ومطابقة الكود بالكامل مع معايير المشروع.

---

## 🛠️ أولاً: جدول المهام والخطوات التنفيذية (Refactoring Checklist)

### 1️⃣ معمارية الطبقات والـ Data Layer (تسميات ومجلدات)
- [x] **Task 1.1:** إعادة تسمية ملف الموديل من `feedback_request.dart` إلى `feedback_request_model.dart`.
- [x] **Task 1.2:** تعديل اسم الكلاس من `FeedbackRequest` إلى `FeedbackRequestModel` وتحديث كافة الاستدعاءات الخاصة به.
- [x] **Task 1.3:** إنشاء واجهة المستودع المجردة (Repository Interface) في طبقة البيانات الملتزمة بهيكلية الطبقتين:
  * المسار: [i_feedback_repository.dart](file:///d:/flutter/flutter_Projects/imposter/lib/features/feedback/data/repositories/i_feedback_repository.dart)
  * الكلاس: `abstract class IFeedbackRepository` مع دالة `Future<Result<void>> submitFeedback(FeedbackRequestModel request);`.
- [x] **Task 1.4:** إعادة تسمية ملف المستودع الملموس من `feedback_repository_impl.dart` إلى `feedback_repo_impl.dart`.
- [x] **Task 1.5:** تعديل كلاس المستودع الملموس ليصبح `FeedbackRepoImpl` وجعله يرث ويطبق الواجهة المجردة `IFeedbackRepository`.

---

### 2️⃣ إدارة الحالة وحقن الاعتمادات (Cubit & Dependency Injection)
- [x] **Task 2.1:** تعديل كلاس `FeedbackCubit` ليعتمد على واجهة المستودع المجردة `IFeedbackRepository` بدلاً من الاعتماد المباشر على الكلاس الملموس `FeedbackRepositoryImpl`.
- [x] **Task 2.2:** تحديث تهيئة وحقن الاعتمادات داخل ملف [di.dart](file:///d:/flutter/flutter_Projects/imposter/lib/core/di/di.dart) ليتوافق مع الأسماء والهيكلية الجديدة:
  * تسجيل `IFeedbackRepository` باستخدام `FeedbackRepoImpl`.
  * تحديث مصنع `FeedbackCubit` ليحقن بـ `sl<IFeedbackRepository>()`.

---

### 3️⃣ إدارة الثوابت والمفاتيح وعزل الميزات (Encapsulation & Constants)
- [x] **Task 3.1:** تصحيح تسمية ملف الثوابت العام الخاطئ من `aoo_constants.dart` إلى `app_constants.dart` وتحديث استيراده في [main.dart](file:///d:/flutter/flutter_Projects/imposter/lib/main.dart).
- [x] **Task 3.2:** إنشاء ملف مفاتيح داخلي للميزة باسم [keys.dart](file:///d:/flutter/flutter_Projects/imposter/lib/features/feedback/keys.dart) ونقل المفاتيح الخاصة بالميزة (`formId` و `feedbackEntryId`) إليه لعزل الميزة بالكامل.
- [x] **Task 3.3:** نقل الثوابت التقنية الخاصة بـ Web Fetch من `feedback_constants.dart` إلى ملف الثوابت العام `app_constants.dart` أو تضمينها محلياً في ملفات الويب المخصصة، ثم حذف الملف المخالف [feedback_constants.dart](file:///d:/flutter/flutter_Projects/imposter/lib/core/constants/feedback_constants.dart).

---

### 4️⃣ النصوص والتعريب لمنع القيم الصلبة (Zero Hardcoded Strings)
- [x] **Task 4.1:** نقل جميع النصوص العربية الصلبة من الوجت والديالوج وإضافتها إلى ملف النصوص الموحد [app_strings.dart](file:///d:/flutter/flutter_Projects/imposter/lib/core/constants/app_strings.dart):
  * `discardFeedbackTitle` = 'تراجع عن الكتابة؟'
  * `discardFeedbackMessage` = 'لو رجعت دلوقتي، كل الكلام اللي كتبته هيتمسح. متأكد إنك عايز تخرج؟'
  * `continueWriting` = 'كمل كتابة'
  * `discardAndExit` = 'امسح واخرج'
  * `feedbackSubtitle` = 'رأيك بيساعدنا نطور اللعبة ونخليها أحسن! اكتب مقترحك أو لو قابلتك مشكلة.'
- [x] **Task 4.2:** استبدال النصوص الصلبة في الكود بمتغيرات `AppStrings` المقابلة.

---

### 5️⃣ تصميم وتفكيك الوجت لتخفيض الأسطر ومنع المقاييس الصلبة (UI Excellence)
- [x] **Task 5.1:** تفكيك كلاس `FeedbackBottomSheet` (الذي يتجاوز 160 سطراً ويخالف معيار الـ 60 سطراً الأقصى) إلى وجت مستقلة كالتالي:
  * استخراج ديالوج التأكيد في كلاس مستقل باسم `FeedbackDiscardDialog` يمتد من `StatelessWidget`.
  * استخراج حقول الإدخال والأزرار في كلاس مستقل باسم `FeedbackFormFields` يمتد من `StatelessWidget` أو `StatefulWidget` منفصل.
  * الحفاظ على `FeedbackBottomSheet` كحاوية رئيسية مبسطة تحتوي فقط على الـ Cubit Provider والـ BlocListener وأقل من 50 سطراً.
- [x] **Task 5.2:** استبدال جميع مقاييس التباعد والأبعاد الصلبة (Hardcoded spacing & sizing):
  * استبدال `const SizedBox(height: 16)` و `const SizedBox(height: 24)` بالوجت المشتركة `AppGap` لضمان التجاوبية والأداء (`const AppGap(16)` و `const AppGap(24)`).
  * استبدال أي أبعاد صلبة مثل الحواف أو الخطوط أو المقاسات بامتدادات السياق (`context.p(16)` للحواف، `context.s(24)` للـ Indicator، إلخ).

---

## 🔍 ثانياً: تفصيل المخالفات المصححة بنجاح

| # | الملف المتأثر | نوع المخالفة | تفاصيل المخالفة التي تم تصحيحها | القاعدة المخترقة (من CLAUDE.md) |
|---|---|---|---|---|
| **1** | `feedback_request_model.dart` | **تسمية الكلاس والملف** | تم تعديل الاسم إلى `FeedbackRequestModel` في ملف `feedback_request_model.dart`. | **Section D:** كلاس الموديل يجب أن ينتهي بـ `Model`. |
| **2** | `feedback_repo_impl.dart` | **تسمية كلاس الـ Repo** | تم تعديل الاسم إلى `FeedbackRepoImpl` في ملف `feedback_repo_impl.dart`. | **Section D:** concrete repos يجب أن تنتهي بـ `RepoImpl`. |
| **3** | `feedback_repo_impl.dart` | **غياب الـ Interface** | تم إنشاء واجهة المستودع `IFeedbackRepository` وتطبيقها في `FeedbackRepoImpl`. | **Section A (1) & Section D:** الاعتماد على واجهات مجردة لتسهيل الاختبار والعزل. |
| **4** | `feedback_cubit.dart` | **اعتمادية كلاس ملموس** | تم تعديل `FeedbackCubit` ليعتمد ويحقن بواجهة `IFeedbackRepository`. | **Section C (1) & Section F:** Cubits تعتمد فقط على واجهات مجردة. |
| **5** | `feedback_bottom_sheet.dart` | **تجاوز حجم الكلاس** | تم تفكيك الكلاس إلى 3 كلاسات مستقلة وكل كلاس لا يتجاوز 60 سطراً. | **Section F:** "A single Widget class **MUST NOT exceed 60 lines of code.**" |
| **6** | `feedback_bottom_sheet.dart` | **نصوص صلبة (Hardcoded Strings)** | تم نقل كافة النصوص إلى `AppStrings` في `app_strings.dart`. | **Section F (String Sources):** يمنع تماماً استخدام النصوص الصلبة ويجب استخدام `AppStrings`. |
| **7** | `feedback_bottom_sheet.dart` | **أبعاد ومسافات صلبة** | تم استخدام `AppGap` واستبدال كافة المقاييس بـ `context.p()`, `context.s()`, `context.h()`, `context.w()`. | **Section F (Hardcoded Sizes):** يمنع استخدام الأرقام الصلبة للأبعاد والمسافات ويجب استخدام `AppGap` والامتدادات التجاوبية. |
| **8** | `feedback_constants.dart` | **عزل الثوابت** | تم حذف ملف الثوابت المشترك الخاطئ ونقل الثوابت التقنية إلى `app_constants.dart` ومفاتيح الميزة إلى `keys.dart` محلياً داخل الميزة. | **Section F:** المفاتيح الداخلية توضع في ملف `keys.dart` داخل الميزة نفسها. |
| **9** | `app_constants.dart` | **تسمية ملف الثوابت** | تم تصحيح تسمية الملف من `aoo_constants.dart` إلى `app_constants.dart` وتحديث الاستدعاءات. | **Section F:** الملف يجب أن يكون `app_constants.dart`. |

---
**حالة التوافق الحالية:** 🟢 متوافق بنسبة 100% ومعتمد هندسياً  
**الحالة المستهدفة بعد المراجعة والإصلاح:** 🟢 متوافق بنسبة 100%
