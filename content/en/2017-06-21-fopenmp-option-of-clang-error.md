---
title: fopenmp option of clang error
date: '2017-06-21'
slug: fopenmp-option-of-clang-error
---

When I try to source a Rcpp file, I got the following error under macOS:

```
clang: error: unsupported option '-fopenmp'
```

After a little bit Googling, I found [this post](http://thecoatlessprofessor.com/programming/openmp-in-r-on-os-x/), which at the end solved my problem. Briefly, I did the following steps:

1. Installed `xcode` from Apple Store (a simplified version may be enough) or in Terminal with`xcode-select --install`
2. Installed `llvm` via `brew install llvm`
3. Downloaded and installed the `gfortran` binary installer from [here](https://gcc.gnu.org/wiki/GFortranBinaries#MacOS). Note: You will need to download the OS X El Capitan **gfortran 6.1** binaries regardless of whether or not you are on macOS Sierra, which presently only offers gfortran 6.3.
4. Downloaded and extracted `clang` to `/usr/local/clang` (overwrite it if already exists, `sudo cp -r ~/Downloads/usr/local/clang4 /usr/local/clang4`). See [here](http://thecoatlessprofessor.com/programming/openmp-in-r-on-os-x/#gui-clang4) for more information.
5. In terminal

   ```bash
   cat <<- EOF > ~/.R/Makevars
   # The following statements are required to use the clang4 binary
   CC=/usr/local/clang4/bin/clang
   CXX=/usr/local/clang4/bin/clang++
   LDFLAGS=-L/usr/local/clang4/lib
   # End clang4 inclusion statements
   EOF
   ```
   
Then, the error is fixed (for now)!
