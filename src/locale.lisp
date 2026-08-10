(in-package #:i18n-backend-icu4j)

#+abcl
(progn
  (defmethod backend-make-locale ((backend icu4j-backend) &key language script region variants
                                extensions tag)
    (declare (ignore backend extensions))
    (make-instance 'locale
                   :language language
                   :script script
                   :region region
                   :variants variants
                   :tag (or tag
                            (with-output-to-string (out)
                              (when language (write-string language out))
                              (when script (format out "-~A" script))
                              (when region (format out "-~A" region))))))

  (defmethod backend-parse-locale ((backend icu4j-backend) string)
    (declare (ignore backend))
    (multiple-value-bind (lang script region tag)
        (icu:parse-locale-tag string)
      (make-instance 'locale
                     :language lang
                     :script script
                     :region region
                     :tag tag)))

  (defmethod backend-available-locales ((backend icu4j-backend))
    (declare (ignore backend))
    (icu:available-locale-tags))

  (defmethod backend-accept-language ((backend icu4j-backend) header &key available)
    (declare (ignore available))
    (let* ((raw (string-trim '(#\Space #\Tab) (or header "")))
           (semi (or (position #\; raw) (position #\, raw) (length raw)))
           (tag (string-trim '(#\Space) (subseq raw 0 semi))))
      (backend-parse-locale backend (if (plusp (length tag)) tag "en"))))
)
