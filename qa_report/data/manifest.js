/**
 * QA Dashboard - Modules Manifest
 * قائمة استدعاء موديولات الفحص المعتمدة
 */
[
  "data/splash_module.js"
].forEach(function (file) {
  document.write('<script src="' + file + '"><\/script>');
});
