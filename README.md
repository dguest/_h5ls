# Tab-complete for h5ls

I like HDF5 and I like tab complete. This makes inspecting HDF5 files
much easier, you just have to run

```
h5ls file.h5/<tab>
```

and you'll get completion for stuff inside!


## Installation

### With root access

This is just a bash function, so installing it is simple.
It is perhaps recommended to install non-OS distributed software under `/opt`, so if you have `root` access then

```
git clone git@github.com:dguest/_h5ls.git /opt/_h5ls
```

and add the following to your `$HOME/.bashrc`

```
# Enable h5ls tab completion
if [ -f /opt/_h5ls/_h5ls.sh ]; then
    . /opt/_h5ls/_h5ls.sh
fi
```

### Without root access

Go to some directory where you keep your tools, e.g. `~/tools/`, and run

```
git clone git@github.com:dguest/_h5ls.git
```

and add the following to your `$HOME/.bashrc`

```
# Enable h5ls tab completion
if [ -f $HOME/tools/_h5ls/_h5ls.sh ]; then
    . $HOME/tools/_h5ls/_h5ls.sh
fi
```
