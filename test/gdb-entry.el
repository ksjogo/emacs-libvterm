(add-to-list 'load-path default-directory)
(require 'libvterm)
(message (number-to-string (libvterm-magic)))
(ielm)
