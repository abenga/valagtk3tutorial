# Widget Overview

The general steps to using a widget in GTK are:

* We use the constructor `Gtk.Widget()` to create a new `Gtk.Widget()`.

* Connect all signals and events we wish to use to the appropriate handlers.

* Set the attributes of the widget.

* Pack the widget into a container using the appropriate call such as
  `Gtk.Container.add()` or `Gtk.Box.pack_start()`.

* `Gtk.Widget.show()` the widget.

`show()` lets GTK know that we are done setting the attributes of the widget,
and it is ready to be displayed. You may also use `Gtk.Widget.hide()` to make it
disappear again. The order in which you show the widgets is not important, but I
suggest showing the window last so the whole window pops up at once rather than
seeing the individual widgets come up on the screen as they're formed. The
children of a widget (a window is a widget too) will not be displayed until the
window itself is shown using the `show()` method.



## Widget Hierarchy

For reference, a comprehensive hierarchy tree used to implement widgets may be 
found in the GTK online documetation at 
[https://developer.gnome.org/gtk3/stable/ch02.html](https://developer.gnome.org/gtk3/stable/ch02.html).

This documentation lists the C API objects, but it is straightforward to infer 
the Vala API class names, especially with the help of the Valadoc documentation 
at [http://valadoc.org/#!api=gtk+-3.0/Gtk](http://valadoc.org/#!api=gtk+-3.0/Gtk).



## References and Further Reading

* The GTK 3 Reference Manual : Object Hierarchy. [Online] Available from:
  [https://developer.gnome.org/gtk3/stable/ch02.html](https://developer.gnome.org/gtk3/stable/ch02.html)
  [Accessed 10&nbsp;November&nbsp;2014]

* Vala Documentation: Gtk. [Online] Available from:
  [http://valadoc.org/#!api=gtk+-3.0/Gtk](http://valadoc.org/#!api=gtk+-3.0/Gtk)
  [Accessed 16&nbsp;September&nbsp;2014]
