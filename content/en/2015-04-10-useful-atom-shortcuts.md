---
title:  Some useful keyboard shortcuts for Atom editor
date: '2015-04-10'
slug: useful-atom-shortcuts
---

I am trying to switch to Github's new editor [Atom](https://atom.io/). Here is a note about things I found useful for me.

### Packages

To see all packages installed, run `apm list` in your terminal. I used the following packages so far:

- `atom-material-syntax` # great syntax highlighting
- `atom-material-ui` # great user interface
- `autocomplete-bibtex` # autocomplete citations
- `autocomplete-paths` # autocomplete path of files
- `file-icons` # show file icons in the tree view
- `git-time-machine` # compare git files
- `ink` # for julia language
- `julia-client` #
- `language-julia` #
- `language-latex` #
- `language-markdown` #
- `markdown-preview-plus` # render math equations
- `markdown-writer` # make writing in markdown easier
- `minimap` # show minimap of your file
- `minimap-find-and-replace` # show finded items in minimap
- `pen-paper-coffee-syntax` #
- `project-manager` #
- `terminal-panel` # run terminal within Atom
- `typewriter` #
- `vim-mode` # I like the vim mode of moving cursor
- `wordcount` #
- `Zen` # distraction free

To install all of them: `apm install atom-material-syntax atom-material-ui autocomplete-bibtex autocomplete-paths file-icons git-time-machine ink julia-client language-julia language-latex language-markdown language-r markdown-preview-plus markdown-writer minimap minimap-find-and-replace pen-paper-coffee-syntax project-manager terminal-panel typewriter vim-mode wordcount Zen`

### Shortcuts

#### Multi-cursor

I also like the **multi-cursor** feature from *sublime text*, which I feel is a must for me. Shortcuts within Atom:

- `ctrl-D` if you select a world, then you hit `ctrl-D` and Atom will select next same word for you. Then you can either type directly (which will replace the old word) or use left or right arrow to append things.
- `ctrl-leftclick` you can use this to select locations for multi-cursor wherever you want.
- `shift-alt-down` or `shift-alt-up` to put multi-cursor at multiple lines. Or you can select multiple lines first, then `selection -- split into lines` (in Mac, you can use `cmd-shift-L`, sadly, for windows and linux so far, no similar shortcut for this [in sublime, we can use `ctrl-shift-L`].).

These pretty much cover most of usage of multi-cursor, but I still missing `shift-rightclick_and_drag` feature from *sublime text*.

#### Spell check

To enable spell check for Latex files, go to setting and find the spell-check package, add `text.tex.latex` in the grammer filed.

#### Common used

- `shift + f11`: full screen, distration free from the Zen package.
- `ctrl + \`: toggle tree view.
- `ctrl + /`: toggle comment.
- `ctrl + shift + up/down`: move line up/down.

 *update soon*
