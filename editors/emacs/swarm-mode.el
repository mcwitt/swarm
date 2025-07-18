;;; swarm-mode.el --- Swarm Lang mode -*- lexical-binding: t -*-
;;
;; Author: swarm contributors
;; URL: https://github.com/swarm-game/swarm
;; Version: 0.1
;; Package-Requires: ((eglot))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;; This package provides major mode for the Swarm programming language.
;;
;;
;;; Code:

(require 'eglot)

(defvar swarm-mode-syntax-table
  (let ((synTable (make-syntax-table)))
    ;; C++ style comments ("// ..." and "/* ... */")
    (modify-syntax-entry ?\/ ". 124b" synTable)
    (modify-syntax-entry ?* ". 23" synTable)
    (modify-syntax-entry ?\n "> b" synTable)
    synTable)
  "Syntax table for `swarm-mode'.")

(defvar swarm-mode-operators-regexp
  (regexp-opt
   '(
     "-"
     "=="
     "!="
     "<"
     ">"
     "<="
     ">="
     "||"
     "&&"
     "+"
     "-"
     "*"
     "/"
     "^"
     "++"
     "$"
     ":"
     )
   t)
  "Regexp that recognizes operators for swarm language.")

(defvar swarm-mode-commands-regexp
  (concat
   "\\b"
   (regexp-opt
    '(
      "noop"
      "wait"
      "selfdestruct"
      "move"
      "backup"
      "volume"
      "path"
      "push"
      "stride"
      "turn"
      "grab"
      "harvest"
      "sow"
      "ignite"
      "place"
      "ping"
      "give"
      "equip"
      "unequip"
      "make"
      "has"
      "equipped"
      "count"
      "drill"
      "use"
      "build"
      "salvage"
      "reprogram"
      "say"
      "listen"
      "log"
      "view"
      "appear"
      "create"
      "halt"
      "time"
      "scout"
      "whereami"
      "locateme"
      "structures"
      "floorplan"
      "detect"
      "resonate"
      "density"
      "sniff"
      "chirp"
      "watch"
      "surveil"
      "heading"
      "blocked"
      "scan"
      "upload"
      "ishere"
      "isempty"
      "meet"
      "meetall"
      "whoami"
      "setname"
      "random"
      "run"
      "pure"
      "try"
      "print"
      "erase"
      "swap"
      "atomic"
      "instant"
      "installkeyhandler"
      "teleport"
      "warp"
      "as"
      "robotnamed"
      "robotnumbered"
      "knows"
      "east"
      "north"
      "west"
      "south"
      "down"
      "forward"
      "left"
      "back"
      "right"
      )
    t)
   "\\b")
  "Regexp that recognizes commands for swarm.")

(defvar swarm-mode-builtins-regexp
  (concat
   "\\b"
   (regexp-opt
    '(
      "waypoint"
      "waypoints"
      "hastag"
      "tagmembers"
      "self"
      "parent"
      "base"
      "if"
      "inl"
      "inr"
      "case"
      "match"
      "force"
      "undefined"
      "fail"
      "not"
      "format"
      "read"
      "chars"
      "split"
      "charat"
      "tochar"
      "key"
      )
    t)
   "\\b" )
  "Regexp that recognizes builtin for swarm language.")

(defvar swarm-mode-types-regexp
  "\\b[A-Z][a-zA-Z_]*\\b"
  "Regexp that recognizes types (all uppercase strings are supposed to be types) in swarm language.")

(defvar swarm-mode-keywords-regexp
  (concat "\\b" (regexp-opt '("def" "tydef" "rec" "end" "let" "in" "require" "stock") t) "\\b")
  "Regexp that recognizes keywords in swarm language.")

(defvar swarm-font-lock-keywords
  `((,swarm-mode-types-regexp . 'font-lock-type-face)
    (,swarm-mode-keywords-regexp . 'font-lock-keyword-face)
    (,swarm-mode-builtins-regexp . 'font-lock-builtin-face)
    (,swarm-mode-commands-regexp . 'font-lock-constant-face)
    (,swarm-mode-operators-regexp . 'font-lock-variable-name-face)))

;;;###autoload
(define-derived-mode swarm-mode prog-mode "Swarm Lang Mode"
  "Major mode for editing Swarm language files."
  (setq font-lock-defaults '((swarm-font-lock-keywords)))
  (set-syntax-table swarm-mode-syntax-table)
  (when (featurep 'eglot)
    (eglot-ensure)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.sw\\'" . swarm-mode))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(swarm-mode . ("swarm" "lsp"))))

(provide 'swarm-mode)
;;; swarm-mode.el ends here
