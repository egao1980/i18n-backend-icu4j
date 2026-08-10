(in-package #:i18n-backend-icu4j)

(defun %locale-tag (locale)
  (cond ((null locale) "en")
        ((stringp locale) locale)
        ((typep locale 'locale) (or (locale-string locale) "en"))
        (t (princ-to-string locale))))
