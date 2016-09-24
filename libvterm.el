;;; libvterm.el --- Emacs bindings for libvterm         -*- lexical-binding: t -*-

;; Copyright (c) 2016 Johannes Goslar

;; Author: Johannes Goslar
;; URL: https://github.com/ksjogo/emacs-libvterm
;; Keywords: terminal tools
;; Version: 0.1
;; Package-Requires: ((emacs "25"))

;;; Commentary:

;;; Code:
(unless (require 'libvterm-core nil t)
  (message "could not load compiled libvterm-core module!"))

(defun libvterm-magic ()
  (interactive)
  (libvterm-core-magic))

(defun libvterm-new ()
  (interactive)
  (libvterm-core-new))


(provide 'libvterm)
;;; libvterm.el ends here
