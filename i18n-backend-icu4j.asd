(defsystem "i18n-backend-icu4j"
  :version "0.1.0"
  :description "i18n-protocol backend over cl-stack-icu4j (ICU4J / ABCL)"
  :author "egao1980"
  :license "MIT"
  :depends-on ("i18n-protocol" "cl-stack-icu4j")
  :serial t
  :pathname "src"
  :components ((:file "package")
               (:file "util")
               (:file "backend")
               (:file "locale")
               (:file "message")
               (:file "plural")
               (:file "catalog"))
  :in-order-to ((test-op (test-op "i18n-backend-icu4j/tests")))
  :properties
  (:cl-repo (:provides ("i18n-backend-icu4j"))))

(defsystem "i18n-backend-icu4j/tests"
  :depends-on ("i18n-backend-icu4j" "rove")
  :pathname "tests"
  :serial t
  :components ((:file "package")
               (:file "backend-test"))
  :perform (test-op (o c)
             (unless (symbol-call :rove :run c)
               (error "tests failed for ~A" (component-name c)))))
