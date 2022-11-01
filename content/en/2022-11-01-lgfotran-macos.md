---
title: Library not found for `-lgfortran`
date: '2022-11-01'
slug: lgfortran
---

After updating to macOS 13.0 (Ventura), somehow I got the following error when compile an R package with C++ code:

    ld: warning: directory not found for option '-L/usr/local/gfortran/lib'    
    ld: library not found for -lgfortran macos ventura

Probably it is because the homebrew installed `gfortran` cannot be found by the system after the upgrading. I was in rush and did not have the time to figure out this. Instead, just went to [this webpage](https://github.com/fxcoudert/gfortran-for-macOS/releases) and downloaded the latest gfortran package and installed it manually. After installation, I was able to compile the package again. Problem solved for now.
 
