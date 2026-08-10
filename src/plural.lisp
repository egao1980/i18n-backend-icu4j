(in-package #:i18n-backend-icu4j)

#+abcl
(progn
  (defmethod backend-make-plural-rules ((backend icu4j-backend) locale &key type)
    (declare (ignore backend))
    (make-instance 'plural-rules
                   :locale locale
                   :type (or type :cardinal)
                   :raw (list :locale (%locale-tag locale) :type (or type :cardinal))))

  (defmethod backend-plural-category ((backend icu4j-backend) rules number)
    (declare (ignore backend))
    (let ((raw (plural-rules-raw rules)))
      (icu:plural-select (getf raw :locale) number :type (getf raw :type))))
)
