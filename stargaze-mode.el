
;; stargaze-mode.el
;; Major mode for Stargaze
;; (c) 2025 Sebastian Zack Tin Lahm-Lee
;;
;; This file is not part of GNU Emacs.

(defvar stargaze-keywords nil "Stargaze keywords")
(setq stargaze-keywords
      '("def" "fn" "if" "cond" "let" "letrec" "quote" "qquote" "unquote"
	"set!" "begin" "include" "import" "export" "while"))

(defvar stargaze-constants nil "Stargaze constants")
(setq stargaze-constants
      '("#f" "#t" "stdin" "stdout"))

(defvar stargaze-functions nil "Stargaze functions")
(setq stargaze-functions
      '("atom?" "closure?" "primitive?" "procedure?"
	"int?" "float?" "float"
	"add" "sub" "mul" "div" "mod" "leq" "lt" "geq" "gt"
	"addf" "subf" "mulf" "divf" "floor" "ceil" "round" "trunc"
	"leqf" "ltf" "geqf" "gtf" "eqnum"
	"cons" "car" "cdr" "set-car!" "set-cdr!" "w/car" "w/cdr"
	"chr" "ord" "char?"
	"strref" "substr" "strappend" "strsym" "str?"
	"and" "or" "not"
	"symstr" "sym?"
	"list" "nil?"
	"vec?" "vector" "listvec" "veclist" "vecref" "mkvec" "vecset!"
	"vec++" "veclen" "eof?" "openinput" "openoutput" "close"
	"readch" "writech"
	"length" "append" "list++" "reverse" "map" "filter" "member" "assoc"
	"bit~" "bit&" "bit^" "bit|" "bit<<" "bit>>"
	"mkstr" "strlen" "strlist" "strvec" "str++"))

(defvar stargaze-syntax-coloring nil)
(setq stargaze-syntax-coloring
      (let (s-keywords-regex s-constants-regex s-functions-regex)
	(setq s-keywords-regex (regexp-opt stargaze-keywords 'words))
	(setq s-constants-regex (regexp-opt stargaze-constants 'words))
	(setq s-functions-regex (regexp-opt stargaze-functions 'words))

	(list (cons ";[^\n\r]*$" 'font-lock-comment-face)
	      (cons s-keywords-regex 'font-lock-keyword-face)
	      (cons s-constants-regex 'font-lock-constant-face)
	      (cons s-functions-regex 'font-lock-function-name-face)
	      (cons "#ch{[0-9a-fA-F]+}" 'font-lock-constant-face)
	      (cons "#\\\\\\w+" 'font-lock-constant-face))))

(define-derived-mode stargaze-mode fundamental-mode "Stargaze"
  "Major mode for Stargaze"
  (setq font-lock-defaults '((stargaze-syntax-coloring))))

(add-to-list 'auto-mode-alist '("\\.sg\\'" . stargaze-mode))

(provide 'stargaze-mode)
