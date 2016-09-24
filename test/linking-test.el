(ert-deftest libvterm/there-is-magic ()
  :tags '(general)
  (should (eq 42 (libvterm-magic))))
