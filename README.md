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

## Use Example

Some datasets are large. For example, the dataset used in "Pythia Generated Jet Images for Location Aware Generative Adversarial Network Training" [![DOI](https://zenodo.org/badge/DOI/10.17632/4r4v785rgx.1.svg)](https://zenodo.org/record/268592#.XG8TQ7pKhhF) is over 2 GB in size. So it can be advantageous to quickly look inside without having to open the full file.

After downloading the dataset from [Zenodo](https://zenodo.org/)

```
wget -O jet-images.h5 https://zenodo.org/record/269622/files/jet-images_Mass60-100_pT250-300_R1.25_Pix25.hdf5
```

and checking the file integrity with MD5 checksum

```
md5sum --check <<<"f9b11c46b6a0ff928bec2eccf865ecf0 jet-images.h5"
jet-images.h5: OK
```

use `h5ls` to check the structure

```
$ h5ls jet-images.h5/ #tab to see options
image        jet_delta_R  jet_eta      jet_mass     jet_phi      jet_pt       signal       tau_1        tau_2        tau_21       tau_3        tau_32
$ h5ls jet-images.h5/im #tab to get "image" completed
$ h5ls jet-images.h5/image
image                    Dataset {872666, 25, 25}
h5ls jet-images.h5/
image                    Dataset {872666, 25, 25}
jet_delta_R              Dataset {872666}
jet_eta                  Dataset {872666}
jet_mass                 Dataset {872666}
jet_phi                  Dataset {872666}
jet_pt                   Dataset {872666}
signal                   Dataset {872666}
tau_1                    Dataset {872666}
tau_2                    Dataset {872666}
tau_21                   Dataset {872666}
tau_3                    Dataset {872666}
tau_32                   Dataset {872666}
```
