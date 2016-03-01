# Background

## About GTK

[GTK+](http://www.gtk.org) (acronym for the *GIMP Toolkit*) is a
library for creating graphical user interfaces. It works on many
UNIX-like platforms, Windows, and OS X.

It's called the GIMP toolkit because it was originally written for
developing the [GNU Image Manipulation Program](http://www.gimp.org) (a popular
free cross platform photo editor), but GTK+ has now been used in a large number
of software projects, including [GNOME](http://www.gnome.org) (a popular desktop
environment for Linux).

GTK+ is released under the
[GNU Library General Public License](http://www.gnu.org/licenses/lgpl.html)
(GNU LGPL), which allows for flexible licensing of client applications. You can
develop open software, free software, or even commercial non-free software using
GTK+ without having to spend anything for licenses or royalties. GTK+ has a
C-based object-oriented architecture that allows for maximum flexibility.

Bindings for many other languages have been written, including
[C++](http://www.gtkmm.org/), [Objective-C](https://code.google.com/p/obgtk/),
[Guile/Scheme](http://www.gnu.org/software/guile-gtk/),
[Perl](https://metacpan.org/module/Gtk3), [Python](http://www.pygtk.org/),
TOM, Ada95, Free Pascal, Eiffel and [Vala](https://live.gnome.org/Vala/). This
tutorial describes the Vala interface to GTK.

GTK+ depends on the following libraries:

* **GLib**

    [GLib](https://developer.gnome.org/glib/) is a general-purpose
    utility library, not specific to graphical user interfaces. GLib
    provides many useful data types, macros, type conversions, string
    utilities, file utilities, a main loop abstraction, and so on.

* **GObject**

    [GObject](https://developer.gnome.org/gobject/stable/‎) is library that
    provides a type system, a collection of fundamental types
    including an object type, a signal system.GObject, and its lower-level
    type system, GType, are used by GTK+ and most GNOME libraries to
    provide Object-oriented C-based APIs and automatic transparent API
    bindings to other compiled or interpreted languages.

* **GIO**

    [GIO](https://developer.gnome.org/gio/) is a modern, easy-to-use
    Virtual File System API including abstractions for files, drives,
    volumes, stream IO, as well as network programming and DBus
    communication.

    A virtual file system (VFS) or virtual filesystem switch is an
    abstraction layer on top of a more concrete file system. The purpose of
    a VFS is to allow client applications to access different types of
    concrete file systems (Ext3, FAT, NTFS, etc) in a uniform way.

* **Cairo**

    [Cairo](http://www.cairographics.org/‎) is a 2D graphics library with
    support for multiple output devices.

* **Pango**

    [Pango](http://pango.org) is a library for internationalized text
    handling. It centers around the `PangoLayout` object, representing a
    paragraph of text. Pango provides the engine for `Gtk.TextView`,
    `Gtk.Label`, `Gtk.Entry`, and other widgets that display text.

* **ATK**

    [ATK](https://developer.gnome.org/atk/) is the Accessibility Toolkit.
    It provides a set of generic interfaces allowing accessibility
    technologies (technologies that allow people with physical disabilities,
    e.g. blindness to use computers) to interact with a graphical user
    interface. For example, a screen reader uses ATK to discover the text
    in an interface and read it to blind users. GTK+ widgets have built-in
    support for accessibility using the ATK framework.

* **GdkPixbuf**

    [GdkPixbuf](https://developer.gnome.org/gdk-pixbuf/) is a small library
    which allows you to create GdkPixbuf ("pixel buffer") objects from
    image data or image files. Use a GdkPixbuf in combination with
    `Gtk.Image` to display images.

* **GDK**

    [GDK](https://developer.gnome.org/gdk/) is the abstraction layer that
    allows GTK+ to support multiple windowing systems. GDK provides window
    system facilities on X11, Windows, and OS X.

GTK+ is essentially an object oriented application programming interface
(API). Although written completely in C, it is implemented using the
idea of classes and callback functions.

## About Vala

[Vala](https://live.gnome.org/Vala/) is a new programming language that aims
to bring modern programming language features to GNOME developers without
imposing any additional runtime requirements and without using a different
ABI compared to applications and libraries written in C.

According to the [Vala tutorial](https://wiki.gnome.org/Vala/Tutorial):

> Vala is a new programming language that allows modern programming techniques
> to be used to write applications that run on the GNOME runtime libraries,
> particularly GLib and GObject. This platform has long provided a very complete
> programming environment, with such features as a dynamic type system and
> assisted memory management. Before Vala, the only ways to program for the
> platform were with the machine native C API, which exposes a lot of often
> unwanted detail, with a high level language that has an attendant virtual
> machine, such as Python or the Mono C# language, or alternatively, with C++
> through a wrapper library.
>
> Vala is different from all these other techniques, as it outputs C code which
> can be compiled to run with no extra library support beyond the GNOME platform.
> This has several consequences, but most importantly:
>
> * Programs written in Vala should have broadly similar performance to those
>   written directly in C, whilst being easier and faster to write and maintain.
>
> * A Vala application can do nothing that a C equivalent cannot. Whilst Vala
>   introduces a lot of language features that are not available in C, these are
>   all mapped to C constructs, although they are often ones that are difficult
>   or too time consuming to write directly.
>
> As such, whilst Vala is a modern language with all of the features you would
> expect, it gains its power from an existing platform, and must in some ways
> comply with the rules set down by it.


## References

* The GTK+ 2.0 Tutorial: Introduction. [Online] Available from:
  [https://developer.gnome.org/gtk-tutorial/2.90/c24.html](https://developer.gnome.org/gtk-tutorial/2.90/c24.html)
  [Accessed 16&nbsp;September&nbsp;2014]

* The Vala Tutorial. [Online] Available from:
  [https://wiki.gnome.org/Projects/Vala/Tutorial](https://wiki.gnome.org/Projects/Vala/Tutorial)
  [Accessed: 16&nbsp;September&nbsp;2014]
