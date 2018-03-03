# lsp-julia

Julia support for the [`lsp-mode`](https://github.com/emacs-lsp/lsp-mode) package using the [LanguageServer.jl](https://github.com/JuliaEditorSupport/LanguageServer.jl) package. For information on the features `lsp-mode` provides see their [website](https://github.com/emacs-lsp/lsp-mode).

It's recommended to use this package with the Emacs Speaks Statistics ([ESS](https://github.com/emacs-ess/ESS)) package.

*A julia version >= 0.6 has to be in your path*

_This package is still under development._

## Installation
### Installing the Julia Language Server
Open a Julia REPL and install LanguageServer.jl.

```julia
julia> Pkg.add("LanguageServer")
```

### Installing `lsp-julia`

Clone this repository to a suitable path. Add the following lines to your `.emacs` file:

```emacs-lisp
(add-to-list 'load-path "<path to lsp-mode>")
(add-to-list 'load-path "<path to lsp-julia>")
(with-eval-after-load 'lsp-mode
    (require 'lsp-flycheck))
(require 'lsp-julia)
(require 'lsp-mode)
```

### Using `lsp-julia` with ESS

First, make sure that the ESS package is installed by following the instruction presented on their [website](https://github.com/emacs-ess/ESS/wiki/Julia). Then in addition to the above, add the following to your `.emacs` file.

```emacs-lisp
(add-hook 'ess-julia-mode-hook #'lsp-mode)
```

Please don't hesitate to open an issue in case of problems or create a PR. 
