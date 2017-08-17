(require 'ess-site)
(require 'julia-mode)
(require 'lsp-mode)

(defun lsp-julia--get-root ()
  "Try to find the package directory by searching for a .gitignore file.
If no .gitignore file can be found use the default directory "
  (or (expand-file-name (locate-dominating-file default-directory ".gitignore"))
      default-directory))


(defun lsp-julia--rls-command ()
  `("julia" "--startup-file=no" "--history-file=no" "-e"
    "using LanguageServer; server = LanguageServer.LanguageServerInstance(STDIN, STDOUT, false); server.runlinter = true; run(server);"))

(lsp-define-stdio-client 'ess-julia-mode "julia" 'stdio #'lsp-julia--get-root
                         "Julia Language Server"
                         (lsp-julia--rls-command))

(provide 'lsp-julia)
