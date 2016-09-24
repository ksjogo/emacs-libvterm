# emacs-libvterm
Emacs integration of the libvterm library - shall provide a fast terminal integration in the future.
Requires `emacs-25` compiled after configured with `--with-modules`.

[![Build Status](https://travis-ci.org/ksjogo/emacs-libvterm.svg?branch=master)](https://travis-ci.org/ksjogo/emacs-libvterm)
[![Coverage Status](https://coveralls.io/repos/github/ksjogo/emacs-libvterm/badge.svg?branch=master)](https://coveralls.io/github/ksjogo/emacs-libvterm?branch=master)

## Building

``` shell
git submodule update --init --recursive
cmake .
make
```
## Emacs
This directory needs to be placed inside a folder which is in emacs load-path. Then `(require 'libvterm)` as usual.
