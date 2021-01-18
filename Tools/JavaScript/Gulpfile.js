const gulp = require("gulp");
const browserSync = require("browser-sync");

const styleWatch = "./source/assets/**/*.css";
const jsWatch = "./source/assets/**/*.js";
const markup = "./source/index.html";

function watch() {
  browserSync.init({
    server: {
      baseDir: "./source",
    },
  });

  gulp.watch(jsWatch).on("change", browserSync.reload);
  gulp.watch(styleWatch).on("change", browserSync.reload);
  gulp.watch(markup).on("change", browserSync.reload);
}

exports.watch = watch;
exports.default = watch;
