(require 'ess-site)
(require 'julia-mode)
(require 'lsp-mode)

(defcustom lsp-julia-timeout 30
  "Time before lsp-mode should assume julia just ain't gonna start."
  :group 'lsp-julia)

(defun lsp-julia--get-root ()
  "Try to find the package directory by searching for a .gitignore file.
If no .gitignore file can be found use the default directory "
  (let ((dir (locate-dominating-file default-directory ".gitignore")))
    (if dir
        (expand-file-name dir)
      default-directory)))

(defun lsp-julia--rls-command ()
  `("julia" "--startup-file=no" "--history-file=no" "-e"
    "using LanguageServer; server = LanguageServer.LanguageServerInstance(STDIN, STDOUT, false); server.runlinter = true; run(server);"))


(defconst lsp-julia--handlers
  '(("window/setStatusBusy" .
     (lambda (w _p)))
    ("window/setStatusReady" .
     (lambda(w _p)))))

(defun lsp-julia--initialize-client(client)
  (mapcar #'(lambda (p) (lsp-client-on-notification client (car p) (cdr p))) lsp-julia--handlers)
  (setq-local lsp-response-timeout lsp-julia-timeout))

(lsp-define-stdio-client lsp-julia "julia" #'lsp-julia--get-root nil
                         :command-fn #'lsp-julia--rls-command
                         :initialize #'lsp-julia--initialize-client)

(provide 'lsp-julia)
