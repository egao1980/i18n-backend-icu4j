(defpackage #:i18n-backend-icu4j/tests
  (:use #:cl #:rove #:i18n-protocol #:i18n-backend-icu4j))

(in-package #:i18n-backend-icu4j/tests)

#+abcl
(deftest smoke
  (use-icu4j-backend)
  (ok (typep *i18n-backend* 'icu4j-backend))
  (ok (eq :one (plural-category 1 :locale "en")))
  (ok (string= "Hello Ada!"
               (format-message "Hello {$name}!" '(("name" . "Ada")) :locale "en")))
  (let ((loc (parse-locale "en-US")))
    (ok (string-equal "en" (locale-language loc)))))

#-abcl
(deftest skip (ok t))
