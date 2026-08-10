(in-package #:i18n-backend-icu4j)

#+abcl
(progn
  (defmethod backend-load-catalog ((backend icu4j-backend) source &key locale)
    (declare (ignore backend))
    (let* ((package (cond
                      ((null source) nil)
                      ((pathnamep source) (uiop:native-namestring source))
                      ((stringp source) (if (string= source "") nil source))
                      (t (princ-to-string source))))
           (bundle (icu:open-catalog :package package :locale locale)))
      (make-instance 'message-catalog
                     :locale locale
                     :raw (list :bundle bundle :package package))))

  (defmethod backend-make-message-catalog ((backend icu4j-backend) &key locale)
    (backend-load-catalog backend nil :locale locale))

  (defmethod backend-catalog-get ((backend icu4j-backend) catalog key &key default)
    (declare (ignore backend))
    (let ((bundle (getf (catalog-raw catalog) :bundle)))
      (if bundle
          (icu:catalog-get bundle key :default default)
          default)))

  (defmethod backend-catalog-has-p ((backend icu4j-backend) catalog key)
    (declare (ignore backend))
    (let ((bundle (getf (catalog-raw catalog) :bundle)))
      (and bundle (icu:catalog-has-p bundle key))))

  (defmethod backend-catalog-locales ((backend icu4j-backend) catalog)
    (declare (ignore backend))
    (let ((bundle (getf (catalog-raw catalog) :bundle)))
      (remove nil
              (list (catalog-locale catalog)
                    (when bundle (icu:catalog-locale-tag bundle))))))
)
