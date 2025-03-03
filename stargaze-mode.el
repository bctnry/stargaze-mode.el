
;; stargaze-mode.el
;; Major mode for Stargaze
;; (c) 2025 Sebastian Zack Tin Lahm-Lee
;;
;; This file is not part of GNU Emacs.

(defvar stargaze-syntax-table nil "Syntax table for Stargaze.")
(setq stargaze-syntax-table
      (let ((synTable (make-syntax-table)))
	(modify-syntax-entry ?\; "<" synTable)
	(modify-syntax-entry ?\n ">" synTable)
	synTable))

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
	"strref" "substr" "strsym" "str?"
	"bool" "bool?"
	"and" "or" "not"
	"symstr" "sym?"
	"list" "nil?"
	"vec?" "vector" "listvec" "veclist" "vecref" "mkvec" "vecset!"
	"vec++" "veclen" "eof?" "openinput" "openoutput" "close"
	"readch" "writech"
	"length" "append" "list++" "reverse" "map" "filter" "member" "assoc"
	"bit~" "bit&" "bit^" "bit|" "bit<<" "bit>>"
	"mkstr" "strlen" "strlist" "strvec" "str++"))

(defun stargaze-completion ()
  "Completion function for Stargaze."
  (interactive)
  (let ((bds (bounds-of-thing-at-point 'symbol))
	start
	end)
    (setq start (car bds))
    (setq end (cdr bds))
    (list start end (append stargaze-keywords stargaze-functions) . nil)))

(defvar stargaze-syntax-coloring nil)
(setq stargaze-syntax-coloring
      (let (s-keywords-regex s-constants-regex s-functions-regex)
	(setq s-keywords-regex (regexp-opt stargaze-keywords 'words))
	(setq s-constants-regex (regexp-opt stargaze-constants 'words))
	(setq s-functions-regex (regexp-opt stargaze-functions 'words))

	(list (cons s-keywords-regex 'font-lock-keyword-face)
	      (cons s-constants-regex 'font-lock-constant-face)
	      (cons s-functions-regex 'font-lock-function-name-face)
	      (cons "#ch{[0-9a-fA-F]+}" 'font-lock-constant-face)
	      (cons "#\\\\\\w+" 'font-lock-constant-face))))

(define-derived-mode stargaze-mode fundamental-mode "Stargaze"
  "Major mode for Stargaze"
  (setq font-lock-defaults '((stargaze-syntax-coloring)))
  (set-syntax-table stargaze-syntax-table)
  (font-lock-default-fontify-syntactically (point-min) (point-max))
  (setq-local comment-start ";; ")
  (setq-local comment-end "")
  (add-hook 'completion-at-point-functions 'stargaze-completion nil 'local))

(add-to-list 'auto-mode-alist '("\\.sg\\'" . stargaze-mode))

(provide 'stargaze-mode)
