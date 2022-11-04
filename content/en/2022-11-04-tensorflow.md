---
title: Tensorflow and R set up on server
date: '2022-11-04'
slug: tensorflow-r
---

I am trying to set up Tensorflow and Keras on a Ubuntu server. And I want to interact with them through R. I came across some errors such as 

```
Error: Valid installation of TensorFlow not found.

ModuleNotFounderror: No Module named '_ctypes'
```

After gooling, here is the code I used to solve this issue, following the instructuin [here](https://github.com/pyenv/pyenv/wiki#suggested-build-environment).

```bash
sudo apt update

sudo apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
libffi-dev liblzma-dev

# you may need to use apt-get
```

Then, in R:

```r
library(reticulate)
path_to_python <- install_python(force = T)
virtualenv_create("r-reticulate", python = path_to_python)
install.packages("keras")
install_keras(envname = "r-reticulate")
tensorflow::tf_config()
```

It seems to work now.
