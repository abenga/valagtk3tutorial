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

For your reference, here is the class hierarchy tree used to implement widgets.
(Deprecated widgets and auxiliary classes have been omitted.)

<pre>
GLib.Object
 |
 Gtk.Object
  +Gtk.Widget
  | +Gtk.Misc
  | | +Gtk.Label
  | | | `Gtk.AccelLabel
  | | +Gtk.Arrow
  | | `Gtk.Image
  | +Gtk.Container
  | | +Gtk.Bin
  | | | +Gtk.Alignment
  | | | +Gtk.Frame
  | | | | `Gtk.AspectFrame
  | | | +Gtk.Button
  | | | | +Gtk.ToggleButton
  | | | | | `Gtk.CheckButton
  | | | | |   `Gtk.RadioButton
  | | | | `Gtk.OptionMenu
  | | | +Gtk.Item
  | | | | +Gtk.MenuItem
  | | | |   +Gtk.CheckMenuItem
  | | | |   | `Gtk.RadioMenuItem
  | | | |   +Gtk.ImageMenuItem
  | | | |   +Gtk.SeparatorMenuItem
  | | | |   `Gtk.TearoffMenuItem
  | | | +Gtk.Window
  | | | | +Gtk.Dialog
  | | | | | +Gtk.ColorSelectionDialog
  | | | | | +Gtk.FileSelection
  | | | | | +Gtk.FontSelectionDialog
  | | | | | +Gtk.InputDialog
  | | | | | `Gtk.MessageDialog
  | | | | `Gtk.Plug
  | | | +Gtk.EventBox
  | | | +Gtk.HandleBox
  | | | +Gtk.ScrolledWindow
  | | | `Gtk.Viewport
  | | +Gtk.Box
  | | | +Gtk.ButtonBox
  | | | | +Gtk.HButtonBox
  | | | | `Gtk.VButtonBox
  | | | +Gtk.VBox
  | | | | +Gtk.ColorSelection
  | | | | +Gtk.FontSelection
  | | | | `Gtk.GammaCurve
  | | | `Gtk.HBox
  | | |   +Gtk.Combo
  | | |   `Gtk.Statusbar
  | | +Gtk.Fixed
  | | +Gtk.Paned
  | | | +Gtk.HPaned
  | | | `Gtk.VPaned
  | | +Gtk.Layout
  | | +Gtk.MenuShell
  | | | +Gtk.MenuBar
  | | | `Gtk.Menu
  | | +Gtk.Notebook
  | | +Gtk.Socket
  | | +Gtk.Table
  | | +Gtk.TextView
  | | +Gtk.Toolbar
  | | `Gtk.TreeView
  | +Gtk.Calendar
  | +Gtk.DrawingArea
  | | `Gtk.Curve
  | +Gtk.Editable
  | | +Gtk.Entry
  | |   `Gtk.SpinButton
  | +Gtk.Ruler
  | | +Gtk.HRuler
  | | `Gtk.VRuler
  | +Gtk.Range
  | | +Gtk.Scale
  | | | +Gtk.HScale
  | | | `Gtk.VScale
  | | `Gtk.Scrollbar
  | |   +Gtk.HScrollbar
  | |   `Gtk.VScrollbar
  | +Gtk.Separator
  | | +Gtk.HSeparator
  | | `Gtk.VSeparator
  | +Gtk.Invisible
  | +Gtk.Preview
  | `Gtk.ProgressBar
  +Gtk.Adjustment
  +Gtk.CellRenderer
  | +Gtk.CellRendererPixbuf
  | +Gtk.CellRendererText
  | +Gtk.CellRendererToggle
  +Gtk.ItemFactory
  +Gtk.Tooltips
  `Gtk.TreeViewColumn

</pre>




## Widgets Without Windows

The following widgets do not have an associated window. If you want to capture
events, you'll have to use the EventBox. See the section on the EventBox widget.

* `Gtk.Alignment`
* `Gtk.Arrow`
* `Gtk.Bin`
* `Gtk.Box`
* `Gtk.Button`
* `Gtk.CheckButton`
* `Gtk.Fixed`
* `Gtk.Image`
* `Gtk.Label`
* `Gtk.MenuItem`
* `Gtk.Notebook`
* `Gtk.Paned`
* `Gtk.RadioButton`
* `Gtk.Range`
* `Gtk.ScrolledWindow`
* `Gtk.Separator`
* `Gtk.Table`
* `Gtk.Toolbar`
* `Gtk.AspectFrame`
* `Gtk.Frame`
* `Gtk.VBox`
* `Gtk.HBox`
* `Gtk.VSeparator`
* `Gtk.HSeparator`

We'll further our exploration of GTK by examining each widget in turn, creating
a few simple functions to display them.
