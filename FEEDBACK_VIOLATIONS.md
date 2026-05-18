# 📋 تقرير مراجعة الكود ومخالفات المعايير الهندسية لميزة الدعم (Feedback Feature Auditing)

تم إجراء مراجعة دقيقة وشاملة لجميع الملفات التابعة لميزة الدعم (`lib/features/feedback`) ومقارنتها بقواعد وقوانين المشروع المحددة في [CLAUDE.md](file:///d:/flutter/flutter_Projects/imposter/.gemini/CLAUDE.md) و [PROJECT_STRUCTURE.md](file:///d:/flutter/flutter_Projects/imposter/.gemini/PROJECT_STRUCTURE.md).

أدناه تفصيل لجميع المخالفات المرصودة مقسمة حسب الفئة، متبوعة بخطة تصحيحية متكاملة لجعل الكود مطابقاً بنسبة 100% لمعايير المشروع.

---

## 🔍 أولاً: جدول رصد المخالفات بالتفصيل

| # | الملف المتأثر | نوع المخالفة | القاعدة المخترقة (من CLAUDE.md) | تفاصيل المخالفة الرصودة |
|---|---|---|---|---|
| **1** | `lib/features/feedback/data/models/feedback_request.dart` | **تسمية الملف والكلاس** | **Section D (Naming Conventions):**<br>أسم الكلاس للموديل يجب أن ينتهي بـ `Model`. | كلاس الموديل يسمى `FeedbackRequest` بدلاً من `FeedbackRequestModel` والملف يسمى `feedback_request.dart` بدلاً من `feedback_request_model.dart`. |
| **2** | `lib/features/feedback/data/repositories/feedback_repository_impl.dart` | **تسمية كلاس الـ Repo** | **Section D (Naming Conventions):**<br>concrete repos يجب أن تنتهي بـ `RepoImpl`. | الكلاس يسمى `FeedbackRepositoryImpl` بدلاً من `FeedbackRepoImpl`. |
| **3** | `lib/features/feedback/data/repositories/feedback_repository_impl.dart` | **معمارية الـ Repository** | **Section A (1) & Section D:**<br>الاعتماد على واجهات مجردة (Repository Interface) مبدوءة بحرف `I`. | الكلاس المسمى `Impl` لا يرث ولا يطبق أي واجهة مجردة (لا يوجد `IFeedbackRepository`) وهو ما يخالف هيكلية الطبقات المنفصلة. |
| **4** | `lib/features/feedback/presentation/cubit/feedback_cubit.dart` | **مبدأ كسر الـ Abstraction (DI)** | **Section C (1) & Section F (DO):**<br>الاعتماد على الواجهات المجردة للحقن. | الـ Cubit يعتمد مباشرة على الكلاس الملموس `FeedbackRepositoryImpl` بدلاً من الواجهة المجردة `IFeedbackRepository`. |
| **5** | `lib/features/feedback/presentation/widgets/feedback_bottom_sheet.dart` | **تجاوز الحجم الأقصى للوجت** | **Section F (❌ DON'T):**<br>"A single Widget class **MUST NOT exceed 60 lines of code.**" | كلاس الـ `FeedbackBottomSheet` الممتد من السطر 14 إلى السطر 87 يحتوي على **74 سطراً**، وهو ما يتجاوز الحد الأقصى الصارم (60 سطراً). |
| **6** | `lib/features/feedback/presentation/widgets/feedback_bottom_sheet.dart` | **أبعاد وقيم ثابتة (Hardcoded Spacing)** | **Section F (❌ DON'T):**<br>"Hardcoded numbers for height, width, padding, spacing, sizes, or font sizes are **STRICTLY FORBIDDEN.**" | في السطر 63 تم استخدام مسافة ثابتة: `const SizedBox(height: 24)` وهو أمر محظور تماماً. يجب استخدام `AppGap` أو `context.p(24)`. |
| **7** | `lib/core/constants/feedback_constants.dart` | **مكان الثوابت وعزل الميزات** | **Section F (String Sources & Shared Code):**<br>المفاتيح الداخلية توضع في ملف `keys.dart` داخل الميزة نفسها لمنع كسر عزل الميزات. | وجود ملف ثوابت عام خارجي `feedback_constants.dart` في الـ `core` يحتوي على مفاتيح داخلية مثل `formId` و `feedbackEntryId` الخاصة بميزة الـ feedback فقط، مما يكسر مبدأ العزل الميكروي للميزات (Encapsulation). |

---

## 🏗️ ثانياً: تفصيل المخالفات في الكود (Code Snippets)

### 1. مخالفة حجم كلاس الـ Widget (تتجاوز 60 سطراً)
في ملف [feedback_bottom_sheet.dart](file:///d:/flutter/flutter_Projects/imposter/lib/features/feedback/presentation/widgets/feedback_bottom_sheet.dart#L14-L87):
```dart
// من السطر 14 إلى 87 (74 سطراً) - مخالفة لقاعدة أقصى حجم كلاس 60 سطراً
class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({super.key});
  ...
}
```

### 2. مخالفة استخدام أرقام ثابتة للمسافات (Hardcoded Spacing)
في ملف [feedback_bottom_sheet.dart](file:///d:/flutter/flutter_Projects/imposter/lib/features/feedback/presentation/widgets/feedback_bottom_sheet.dart#L63):
```dart
AppTextField(
  controller: _feedbackController,
  hintText: AppStrings.feedbackPlaceholder,
  maxLines: 7,
),
const SizedBox(height: 24), // ❌ مخالفة صارخة: استخدام الرقم 24 كمسافة ثابتة
AppButton(
...
```

### 3. مخالفة غياب الواجهة المجردة والاعتماد على الكلاس الملموس
في ملف [feedback_repository_impl.dart](file:///d:/flutter/flutter_Projects/imposter/lib/features/feedback/data/repositories/feedback_repository_impl.dart#L10):
```dart
class FeedbackRepositoryImpl { // ❌ يسمى Impl ولكنه لا يطبق أي Interface
  FeedbackRepositoryImpl(this._remoteDataSource);
  ...
}
```
وفي الـ Cubit [feedback_cubit.dart](file:///d:/flutter/flutter_Projects/imposter/lib/features/feedback/presentation/cubit/feedback_cubit.dart#L10):
```dart
class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit(this._feedbackRepository) : super(FeedbackInitial());
  final FeedbackRepositoryImpl _feedbackRepository; // ❌ الاعتماد على Implementation مباشرة
  ...
}
```

---

## 🚀 ثالثاً: الخطة التصحيحية المتكاملة للوصول للتوافق التام (Refactoring Plan)

لتصحيح هذه المخالفات بالكامل، يجب تنفيذ الخطوات التالية:

### الخطوة 1: عزل وإعادة هيكلة ملفات الـ Data
1. إنشاء ملف الواجهة المجردة للـ Repository في الميزة (أو تطبيق هيكلية الطبقتين بشكل سليم بدون لاحقة `Impl` إذا كانت ميزة ممررة "Pass-through"، ولكن لضمان إمكانية الاختبار يُفضل إنشاء `IFeedbackRepository`).
2. إعادة تسمية ملف الكود:
   * من `feedback_request.dart` إلى `feedback_request_model.dart`
   * وتحديث الكلاس داخله إلى `FeedbackRequestModel`.
3. إعادة تسمية ملف المستودع:
   * من `feedback_repository_impl.dart` إلى `feedback_repo_impl.dart`.
   * وتحديث الكلاس ليصبح `FeedbackRepoImpl` يرث من `IFeedbackRepository`.

### الخطوة 2: تحديث الـ Cubit وحقن الاعتمادية
1. تحديث `FeedbackCubit` ليعمنت على `IFeedbackRepository` بدلاً من الكلاس المباشر.
2. تحديث حقن الاعتمادية (Dependency Injection) في `core/di/` ليتوافق مع الأسماء الجديدة.

### الخطوة 3: تصحيح وتجزئة الـ Widget (تخفيض الأسطر ومنع الأرقام الثابتة)
1. استبدال `const SizedBox(height: 24)` بـ `AppGap(context.p(24))` أو `SizedBox(height: context.p(24))` للامتثال لشرط التجاوبية الكامل والأداء.
2. تجزئة كلاس `FeedbackBottomSheet` عن طريق استخراج الأجزاء الفرعية (مثل حقل الإدخال وزر الإرسال) إلى كلاسات مستقلة في نفس الملف أو ملفات منفصلة للتأكد من أن كلاس الـ Widget الرئيسي لا يتجاوز 60 سطراً.

### الخطوة 4: تنظيف الثوابت ونقل المفاتيح
1. إنشاء ملف مفاتيح داخلي للميزة باسم `lib/features/feedback/keys.dart` ونقل `formId` و `feedbackEntryId` إليه.
2. نقل الثوابت التقنية البحتة (مثل الرؤوس والمتغيرات النصية الثابتة للويب) إلى `lib/core/constants/app_constants.dart` أو دمجها، وحذف الملف غير الممتثل `feedback_constants.dart`.

---
**حالة المطابقة الحالية:** 🔴 غير متوافق (يحتوي على 7 مخالفات)
**الحالة المستهدفة بعد الإصلاح:** 🟢 متوافق بنسبة 100%
