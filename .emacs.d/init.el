;;; package --- Summary
;;; Commentary:

;;; Code:
;; Cask setting

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(add-to-list 'load-path "~/.emacs.d/elisp")

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; 文字コードの設定
(set-language-environment "Japanese")
(prefer-coding-system           'utf-8)
(setq buffer-file-coding-system 'utf-8)
(setq coding-system-for-write   'utf-8)
(set-buffer-file-coding-system  'utf-8)
(set-terminal-coding-system     'utf-8)
(set-keyboard-coding-system     'utf-8)
(set-clipboard-coding-system    'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)

(global-font-lock-mode t)
(setq font-lock-maximum-size 100)

;; macのcommand key をmeta keyとする
(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta)))

;; オリジナルのキーバインドを設定
(global-set-key "\C-h" 'delete-backward-char)

;; 改行やタブ、スペースを色付けで表示する。
(global-whitespace-mode 1)

;; 背景を透過に設定
(set-frame-parameter nil 'alpha 80)

;; 行番号/ カラム番号を表示する
(line-number-mode t)

;; ファイルサイズを表示しない
(size-indication-mode 0)

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")
;; 時計を表示（好みに応じてフォーマットを変更可能）
(setq display-time-day-and-date t); 曜日・月・日を表示
(display-time-mode t)

;; PAREN-MODE : 対応する括弧を強調して表示する
(show-paren-mode t) ; 有効化

;; タブのデファルト値を設定
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; バックアップファイルを作らないように設定
(setq make-backup-files nil)
(setq auto-save-default nil)

;; サイドバーに行番号を表示する
(global-linum-mode 1)

;; ツールバーを非表示にする
(tool-bar-mode 0)

;; PATH環境変数をEmacsに引き継ぐための設定
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(setq ring-bell-function 'ignore)
;; フォント設定

(global-hl-line-mode t) ;;現在行をハイライト


;;  tmux ,emacs , osx で クリップボードを共有する
 (defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))
(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))
(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;; windmove

;; auto-complete の設定
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default)
  (setq ac-delay 0.05)
  (setq ac-auto-show-menu 0.1))

;; ;; rubyの設定
;; (autoload 'ruby-mode "ruby-mode"
;;   "Mode for editing ruby source files" t)
;; (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.jbuilder$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
;; (setq ruby-block-highlight-toggle t)
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
            (inf-ruby-keys)))
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
(setq ruby-indent-level 2)
(setq ruby-indent-tabs-mode nil)



;; ;; setting for markdown-mode
(add-to-list 'auto-mode-alist '("\\.md$" . gfm-mode))
`
;; ;; Cask use lisp-mode
(add-to-list 'auto-mode-alist '("Cask$" . lisp-mode))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;  fro go-mode
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ((envs '("PATH" "GOPATH")))
  (exec-path-from-shell-copy-envs envs))

;; ;; Setting for Helm
(require 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(helm-autoresize-mode t)
;; ;; Flycheck
;; ;;(add-hook 'after-init-hook #'global-flycheck-mode)

;; ;; Setting CoffeeScript
;; (add-to-list 'ac-modes 'coffee-mode)
;; (add-hook 'coffee-mode-hook
;;   `(lambda ()
;;      (add-to-list 'ac-dictionary-files "~/.emacs.d/ac-dict/javascript-mode")))

;; ;; Setting for Cider
(add-hook 'cider-mode-hook #'eldoc-mode)


;; ;; Setting for sass(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))

;; ;; Setting for web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

;; ;; editorconfigを使用する
(setq edconf-exec-path "/usr/local/bin/editorconfig")
(editorconfig-mode 1)

;; ;; emacsでrbenvでインストールしたrubyを扱うため
(require 'rbenv)
(setq rbenv-installation-dir "/usr/local/Cellar/rbenv")
(global-rbenv-mode)

(load-theme 'zenburn t)

;; helmバッファでの選択行の色を設定
(set-face-attribute 'helm-selection nil
                    :background "cyan"
                    :foreground "black")

;; ;; magitの設定
(require 'magit)
;; 自動でrevertするのをoffにする
(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")
(global-set-key (kbd "C-x g") 'magit-status)

;; ;; clojureの設定
;; Place the function call requiring `clojure-mode` after the call to `package-initialize`
;; if you are using Emacs version 24.1.1
(require 'clojure-mode)
(define-clojure-indent
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (Head 2)
  (ANY 2)
  (context 2))

(defun my-clojurescript-mode-common-init ()
  "ClojureScript mode set up function."
  (setq tab-width 2))

(defun my-clojure-mode-commoon-init ()
  "Clojure mode set up function."
  (setq tab-width 2))
(add-hook 'clojure-mode-hook 'my-clojure-mode-commoon-init)

(add-hook 'clojurescript-mode-hook 'my-clojurescript-mode-common-init)

;; ;; ;; cider install
;; ;; (unless (package-installed-p 'cider)
;; ;;   (package-install 'cider))

(require 'helm-git-grep)
(global-set-key (kbd "C-c g") 'helm-git-grep)
(setq helm-git-grep-base-directory 'current)

;; ;; emacsclientの設定
(require 'server)

(unless (server-running-p) ;; 複数サーバ起動
  (server-start))

;; ;; js2-modeの設定
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; ;; find-file-in-projectの設定
(global-set-key (kbd "C-c f") 'find-file-in-project)

;; ;; smartparensの設定
(add-hook 'clojure-mode-hook #'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
(add-hook 'c-mode-hook #'smartparens-mode)

;; ;; figwheelの設定
(defun figwheel-repl ()
  (interactive)
  (run-clojure "lein figwheel"))
;; (add-hook 'clojure-mode-hook #'inf-clojure-minor-mode)

;; ;; inf-clojureの設定
;; ;; (setq inf-clojure-program "boot -C repl"

(add-hook 'flychack-mode-hook #'flycheck-ruct-setup)

;; php-modeの設定
(require 'php-mode)
(add-hook 'php-mode-hook
      (lambda ()
        (require 'php-completion)
        (php-completion-mode t)
        (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
        (make-local-variable 'ac-sources)
        (setq ac-sources '(
                   ac-source-words-in-same-mode-buffers
                   ac-source-php-completion
                   ac-source-filename
                   ))))

;; dash-to-pointの設定
;; dashで検索する
(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)

;; dockerfile-modeの設定

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (moccur-edit less-css-mode php-completion php-mode zenburn yasnippet yaml-mode wisp-mode web-mode use-package typing twittering-mode toml-mode smex smartparens slime slim-mode slamhound scala-mode sass-mode rust-mode ruby-block rbenv rainbow-delimiters projectile prodigy popwin pallet nyan-mode mustache-mode multiple-cursors multi-term mocker markdown-mode magit js2-mode jedi jade-mode inf-clojure idle-highlight-mode htmlize helm-git-grep go-errcheck go-eldoc go-direx go-autocomplete flycheck-rust flycheck-cask find-file-in-project expand-region exec-path-from-shell emmet-mode elixir-mode editorconfig e2wm drag-stuff dash-at-point color-theme coffee-mode clojure-cheatsheet bundler ac-nrepl)))
 '(safe-local-variable-values
   (quote
    ((cider-cljs-lein-repl . "(do (dev) (go) (cljs-repl))")
     (cider-refresh-after-fn . "reloaded.repl/resume")
     (cider-refresh-before-fn . "reloaded.repl/suspend")
     (ruby-compilation-executable . "ruby")
     (ruby-compilation-executable . "ruby1.8")
     (ruby-compilation-executable . "ruby1.9")
     (ruby-compilation-executable . "rbx")
     (ruby-compilation-executable . "jruby")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
