(require 'ess-site)
(require 'julia-mode)
(require 'lsp-mode)

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

(lsp-define-stdio-client 'ess-julia-mode "julia" 'stdio #'lsp-julia--get-root
                         "Julia Language Server" nil :command-fn #'lsp-julia--rls-command)

(lsp-client-on-notification 'ess-julia-mode "window/setStatusReady"
                            #'(lambda (_w _p)))
(lsp-client-on-notification 'ess-julia-mode "window/setStatusBusy"
                            #'(lambda (_w _p)))

(provide 'lsp-julia)
