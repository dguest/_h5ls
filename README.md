Tab-complete for h5ls
=====================

I like HDF5 and I like tab complete. This makes inspecting HDF5 files
much easier, you just have to run

```
h5ls file.h5/<tab>
```

and you'll get completion for stuff inside!


Installation
============

This is just a bash function, so installing it is simple. Go to some directory where you keep your tools, i.e. `~/tools/`, and run

```
git clone git@github.com:dguest/_h5ls.git
```

Then add this to your `.bashrc`

```
source ~/tools/_h5ls/_h5ls.sh
```
