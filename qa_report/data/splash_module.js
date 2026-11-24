/**
 * QA Bug Tracker Data - Module: Splash & Onboarding
 */
window.MODULE_SPLASH = {
  moduleId: "splash",
  moduleName: "📦 Splash & Onboarding - شاشة البداية والتعريف بالتطبيق",
  tasks: [
    {
      id: "SPL-01",
      title: "تعطل زر الرجوع بالنظام (System Back) ومنع الخروج من التطبيق في الصفحة الأولى من الـ Onboarding",
      types: ["bug", "ux"],
      severity: "High",
      file: "lib/modules/splash/views/onboarding/onbearding_screen.dart:60",
      culprit: "Mobile",
      requiresBackend: false,
      status: "pending",
      testScenario: "1. افتح التطبيق لأول مرة للوصول إلى شاشة التعريف (Onboarding) وتأكد أنك في الصفحة الأولى.\n2. اضغط على زر الرجوع في الهاتف أو اسحب إيماءة الرجوع للخروج من التطبيق.\n\nالنتيجة الفعلية: لا يستجيب التطبيق لزر الرجوع مطلقاً ويظل المستخدم عالقاً داخل الشاشة.\nالنتيجة المتوقعة: في الصفحة الأولى يسمح زر الرجوع بالخروج الطبيعي من التطبيق، وفي الصفحات التالية يعيد المستخدم للصفحة السابقة.",
      technicalAnalysis: "1. تم ضبط `PopScope(canPop: false)` بشكل دائم مهما كانت الصفحة الحالية.\n2. عند استدعاء `_onBack()` في الصفحة الأولى (`_currentPage == 0`) لا يتحقق الشرط `if (_currentPage > 0)` فلا يحدث أي إجراء ويُبتلع حدث الرجوع تماماً.",
      solution: "ربط `canPop` بكون المستخدم في الصفحة الأولى فقط:\n```dart\nPopScope(\n  canPop: _currentPage == 0,\n  onPopInvokedWithResult: (didPop, _) {\n    if (didPop) return;\n    _onBack();\n  },\n  child: Scaffold(...),\n)\n```"
    },
    {
      id: "SPL-02",
      title: "طفح بصري (RenderFlex Overflow) في محتوى صفحات الـ Onboarding على الشاشات الصغيرة أو عند تكبير الخط",
      types: ["ui", "bug"],
      severity: "High",
      file: "lib/modules/splash/views/onboarding/onbearding_screen.dart:140",
      culprit: "Mobile",
      requiresBackend: false,
      status: "pending",
      testScenario: "1. افتح شاشة الـ Onboarding على هاتف بشاشة صغيرة أو في الوضع الأفقي (Landscape) أو بعد تكبير حجم الخط من إعدادات النظام.\n2. استعرض صفحات التعريف الثلاث.\n\nالنتيجة الفعلية: يظهر شريط خطأ الطفح الأصفر والأسود (RenderFlex overflowed) أسفل النص ولا يظهر كامل الوصف.\nالنتيجة المتوقعة: يتكيف المحتوى مع ارتفاع الشاشة أو يقبل التمرير العمودي بسلاسة دون أي طفح بصري.",
      technicalAnalysis: "1. الودجت `OnboardingPageContent` تضع صورة بارتفاع ثابت `250` مع مسافات `SizedBox(height: 40)` و `SizedBox(height: 20)` ونص عنوان بحجم كبير جداً `AppTextStyle.displayLarge` داخل `Column` غير قابل للتمرير.\n2. نصوص العنوان والوصف تفتقر إلى `maxLines` و `overflow: TextOverflow.ellipsis` أو `SingleChildScrollView`.",
      solution: "إحاطة محتوى الصفحة بـ `SingleChildScrollView` مع `Flexible` للصورة وتحديد `maxLines` للنصوص:\n```dart\nreturn SingleChildScrollView(\n  padding: const EdgeInsets.all(20.0),\n  child: Column(\n    mainAxisAlignment: MainAxisAlignment.center,\n    children: [\n      ImageAssetWidget(imagePath, height: 250),\n      const SizedBox(height: 32),\n      Text(title, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyle.headlineMedium.copyWith(color: AppColors.primary)),\n      const SizedBox(height: 16),\n      Text(description, textAlign: TextAlign.center, maxLines: 4, overflow: TextOverflow.ellipsis, style: AppTextStyle.bodyLarge.copyWith(color: AppColors.onSurfaceVariant)),\n    ],\n  ),\n);\n```"
    },
    {
      id: "SPL-03",
      title: "نصوص عربية وإنجليزية ثابتة (Hardcoded Strings) في شاشة الـ Onboarding لا تتغير بتغير لغة التطبيق",
      types: ["ui", "bug"],
      severity: "High",
      file: "lib/modules/splash/views/onboarding/onbearding_screen.dart:26",
      culprit: "Mobile",
      requiresBackend: false,
      status: "pending",
      testScenario: "1. افتح التطبيق على جهاز مضبوط على اللغة الإنجليزية.\n2. انتقل إلى شاشة الـ Onboarding.\n\nالنتيجة الفعلية: تظهر جميع العناوين والأوصاف وأزرار (تخطي، التالي، السابق، إنهاء) باللغة العربية الثابتة، بينما تظهر رسالة خطأ الصورة باللغة الإنجليزية الثابتة.\nالنتيجة المتوقعة: تُعرض جميع النصوص مترجمة وفق لغة التطبيق الحالية عبر نظام الترجمة `.tx()`.",
      technicalAnalysis: "1. مصفوفة `_onboardingData` وأزرار الشاشة (`\"تخطي\"`, `\"السابق\"`, `\"التالي\"`, `\"إنهاء\"`, `\"Image not found\"`) مكتوبة كنصوص ثابتة مباشرة بدلاً من استخدام `AppStrings` والامتداد `.tx()`.",
      solution: "استبدال النصوص الثابتة بمفاتيح ترجمة مع `.tx()`:\n```dart\nTextButton(onPressed: _onSkip, child: Text(AppStrings.skip.tx())),\nOutlinedButton(onPressed: _onBack, child: Text(AppStrings.previous.tx())),\nElevatedButton(\n  onPressed: _onNext,\n  child: Text((_isLastPage ? AppStrings.finish : AppStrings.next).tx()),\n),\n```"
    },
    {
      id: "SPL-04",
      title: "عدم انتظار حفظ حالة تخطي الـ Onboarding في الذاكرة المحلية وغياب حماية النقر المزدوج",
      types: ["bug"],
      severity: "Medium",
      file: "lib/modules/splash/views/onboarding/onbearding_screen.dart:38",
      culprit: "Mobile",
      requiresBackend: false,
      status: "pending",
      testScenario: "1. في شاشة الـ Onboarding، اضغط مرتين بسرعة على زر 'تخطي' أو زر 'إنهاء' في الصفحة الأخيرة.\n2. أغلق التطبيق فوراً وأعد فتحه.\n\nالنتيجة الفعلية: يتم استدعاء التوجيه لشاشة تسجيل الدخول أكثر من مرة بالتوازي، وقد يفشل حفظ `skipOnBoarding` قبل إغلاق التطبيق فتظهر شاشة الـ Onboarding مجدداً.\nالنتيجة المتوقعة: يتم قفل الزر عند أول نقرة وانتظار اكتمال حفظ `skipOnBoarding` قبل الانتقال مرة واحدة فقط.",
      technicalAnalysis: "1. الدالة `_onSkip()` تستدعي `AppCache.saveData(key: CacheKey.skipOnBoarding, value: true)` بدون `await`.\n2. لا يوجد متغير حارس (`_isNavigating`) لمنع تكرار استدعاء `NavigationManager.navigateToLogin()` عند النقر السريع المتتالي.",
      solution: "تحويل `_onSkip` إلى دالة غير متزامنة مع حارس يمنع التكرار:\n```dart\nbool _isCompletingOnboarding = false;\n\nFuture<void> _onSkip() async {\n  if (_isCompletingOnboarding) return;\n  _isCompletingOnboarding = true;\n  await AppCache.saveData(key: CacheKey.skipOnBoarding, value: true);\n  if (!mounted) return;\n  NavigationManager.navigateToLogin();\n}\n```"
    },
    {
      id: "SPL-05",
      title: "تداخل أزرار التنقل السفلية في الـ Onboarding مع شريط إيماءات النظام لغياب SafeArea",
      types: ["ui", "ux"],
      severity: "Medium",
      file: "lib/modules/splash/views/onboarding/onbearding_screen.dart:94",
      culprit: "Mobile",
      requiresBackend: false,
      status: "pending",
      testScenario: "1. افتح شاشة الـ Onboarding على هاتف حديث يعمل بنظام الإيماءات (Gesture Navigation Bar).\n2. لاحظ موضع زري 'التالي' و 'السابق' في أسفل الشاشة.\n\nالنتيجة الفعلية: تقع الأزرار قريبة جداً من حافة الشاشة السفلية وتتداخل مع منطقة شريط الإيماءات الخاص بالنظام.\nالنتيجة المتوقعة: تُحاط منطقة الأزرار السفلية بـ `SafeArea` لضمان ابتعادها عن حواف النظام السفلية.",
      technicalAnalysis: "1. العمود الرئيسي في `Scaffold.body` داخل `OnboardingScreen` غير محاط بـ `SafeArea`، مما يجعل الـ `Padding` السفلي (20px) يدخل ضمن منطقة الـ System Bottom Inset.",
      solution: "إحاطة محتوى الشاشة أو الشريط السفلي بـ `SafeArea`:\n```dart\nSafeArea(\n  child: Column(\n    children: [...],\n  ),\n)\n```"
    },
    {
      id: "SPL-06",
      title: "استخدام اتجاه أفقي ثابت غير متوافق مع RTL في نقاط مؤشر الصفحات (`EdgeInsets.only(right: 5)`)",
      types: ["ui"],
      severity: "Medium",
      file: "lib/modules/splash/views/onboarding/onbearding_screen.dart:120",
      culprit: "Mobile",
      requiresBackend: false,
      status: "pending",
      testScenario: "1. افتح شاشة الـ Onboarding باللغتين العربية والإنجليزية.\n2. دقق في تمركز نقاط مؤشر الصفحات (Dots Indicator) تحت المحتوى.\n\nالنتيجة الفعلية: تستخدم النقاط هامشاً ثابتاً لليمين فقط `EdgeInsets.only(right: 5)` مما يخالف معايير RTL ويزيح المركز البصري بمقدار 2.5px.\nالنتيجة المتوقعة: استخدام `EdgeInsetsDirectional` أو هامش أفقي متماثل `EdgeInsets.symmetric(horizontal: 3)` لتوسيط المؤشر بدقة في جميع اللغات.",
      technicalAnalysis: "1. الدالة `buildDot` تستخدم `EdgeInsets.only(right: 5)` بدلاً من `EdgeInsetsDirectional.only(end: 5)` أو `EdgeInsets.symmetric(horizontal: 3)`.",
      solution: "استخدام هامش أفقي متماثل أو اتجاهي:\n```dart\nmargin: const EdgeInsetsDirectional.symmetric(horizontal: 3),\n```"
    },
    {
      id: "SPL-07",
      title: "انتهاك معمارية ViewModel واستخدام Force Unwrap (`!`) على خريطة بيانات غيرمهيكلة وخطأ إملائي باسم الملف",
      types: ["refactor"],
      severity: "Medium",
      file: "lib/modules/splash/views/onboarding/onbearding_screen.dart:26",
      culprit: "Mobile",
      requiresBackend: false,
      status: "pending",
      testScenario: "1. راجع هيكلة ملف `onbearding_screen.dart` وطريقة تمرير بيانات الصفحات.\n2. لاحظ اسم الملف واعتماد الواجهة على `Map<String, String>` مع علامة `!`.\n\nالنتيجة الفعلية: اسم الملف يحتوي على خطأ إملائي (`onbearding_screen.dart`)، والمنطق وحفظ الكاش مدمجان داخل الـ Widget مع استخدام `!` على مفاتيح نصية واستخدام `Image.asset` و `TextStyle` مباشر بدلاً من `ImageAssetWidget` و `AppTextStyle`.\nالنتيجة المتوقعة: فصل منطق شاشة الـ Onboarding في `OnboardingViewModel` مع نموذج بيانات مهيكل (`OnboardingItemModel`) وتصحيح اسم الملف والالتزام بمكونات النظام.",
      technicalAnalysis: "1. استخدام `_onboardingData[index]['title']!` يعرض الكود لخطر `Null check operator used on a null value` عند أي تعديل في المفاتيح.\n2. غياب `OnboardingViewModel` يخرق قاعدة فصل منطق العرض عن الواجهة، كما أن `errorBuilder` في السطر 155 ينشئ `TextStyle(color: AppColors.error)` مباشرة بدلاً من `AppTextStyle`.",
      solution: "إنشاء كلاس `OnboardingItemModel` و `OnboardingViewModel` واستخدام `ImageAssetWidget`:\n```dart\nclass OnboardingItemModel {\n  const OnboardingItemModel({required this.titleKey, required this.descriptionKey, required this.imagePath});\n  final String titleKey;\n  final String descriptionKey;\n  final String imagePath;\n}\n```"
    },
    {
      id: "SPL-08",
      title: "غياب `RepaintBoundary` ودعم تقليل الحركة (Reduce Motion) والوصول (Accessibility Semantics) في أنيميشن البداية",
      types: ["perf", "ux"],
      severity: "Low",
      file: "lib/modules/splash/widgets/animated_book_splash_widget.dart:61",
      culprit: "Mobile",
      requiresBackend: false,
      status: "pending",
      testScenario: "1. فعّل خيار 'تقليل الحركة' (Reduce Motion) أو قارئ الشاشة (TalkBack/VoiceOver) من إعدادات الجهاز ثم افتح التطبيق.\n2. راقب أداء إعادة الرسم في شاشة الـ Splash.\n\nالنتيجة الفعلية: يعمل الأنيميشن اللانهائي بـ 60 إطار/ثانية دون `RepaintBoundary` لعزل الرسم، ولا يحترم إعداد تقليل الحركة، كما لا يعلن قارئ الشاشة عن إمكانية النقر لتخطي شاشة البداية.\nالنتيجة المتوقعة: عزل الرسم داخل `RepaintBoundary`، وإيقاف التكرار عند تفعيل `disableAnimations`، وإضافة وصف `Semantics` واضح لشاشة البداية.",
      technicalAnalysis: "1. `AnimatedBookSplashWidget` يعيد رسم `CustomPaint` وحلقتي التوهج في كل إطار دون `RepaintBoundary`.\n2. الدالة `shouldRepaint` في `_LottieStyleBookPainter` (السطر 394) تفحص 3 خصائص فقط وتتجاهل 6 ألوان أخرى (`spineColor`, `pageBorderColor`, `pageLinesColor`, `bookmarkColor`, `sparkleColor`, `shadowColor`).\n3. غياب فحص `!mounted` في `SplashScreen._navigateToNextScreen` قبل استدعاء التوجيه.",
      solution: "إحاطة المشهد بـ `RepaintBoundary` وفحص `mounted` قبل التوجيه:\n```dart\nvoid _navigateToNextScreen() {\n  if (_hasNavigated || !mounted) return;\n  _hasNavigated = true;\n  _timer?.cancel();\n  NavigationManager.navigateFromSplash();\n}\n```"
    }
  ]
};
