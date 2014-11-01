
# Getting Started

## Installation

Before we can begin programming, we need to install GTK and Vala,
along with their dependencies.

### Installing GTK+

You may install GTK+ and its various dependencies from source by
downloading several archives, untarring them and running
`./configure`, `make` and `make install` to install them.

However, if you're using a Linux distribution with a package manager,
it is easier to install the precompiled packages from the distribution's
repositories. The packages would also receive security updates and any
other upgrades as they are rolled out by the distribution.

You need to install the `-dev` packages that contain
the header files and static libraries that are needed to compile GTK+
applications. Installing the GTK+ development package will also install
all its dependecies (the header files for **GLib**,
**gdk-pixbuf**, etc).

On Debian and its derivatives, the command to do this would be:

    # apt-get install libgtk-3-dev

On Fedora, it would be:


    # yum install libgtk-3-dev

You may also use your distribution's graphical software management
tools like the Ubuntu Software Centre, Synaptic, or PackageKit.


### Installing Vala

You can install Vala by building from source. First, one obtains
the vala source code by downloading a tarball from the vala releases page
([https://wiki.gnome.org/Projects/Vala/Release](https://wiki.gnome.org/Projects/Vala/Release))
and extracting it and running `./configure`, `make` and `make install`
in the source folder.

Alternatively, you may install vala from your distribution's repositories.

On Debian and its derivatives, you would run:

    # apt-get install valac

And on Fedora, one would run:

    # yum install valac

You may also use your distribution's graphical software management
tools like the Ubuntu Software Centre or Synaptic.



## References and Further Reading

* Compiling the GTK+ libraries. [Online] Available from:
  [https://developer.gnome.org/gtk3/stable/gtk-building.html](https://developer.gnome.org/gtk3/stable/gtk-building.html)
  [Accessed 16 September 2014]

* Vala Tools. [Online] Available from:
  [https://wiki.gnome.org/Projects/Vala/Tools](https://wiki.gnome.org/Projects/Vala/Tools)
  [Accessed 16 September 2014]