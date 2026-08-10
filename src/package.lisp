(defpackage #:i18n-backend-icu4j
  (:use #:cl #:i18n-protocol)
  (:local-nicknames (#:icu #:cl-stack-icu4j))
  (:export #:icu4j-backend #:use-icu4j-backend #:*icu4j-backend*))

(in-package #:i18n-backend-icu4j)
