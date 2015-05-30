
# Layout Widgets

When creating an application, you'll probably want to put more than one widget
inside a window. Our first helloworld example only used one widget so we could
simply use the `Gtk.Container.add()` method to "pack" the widget into the window.
But when you want to put more than one widget into a window, you will need to
control the widgets' sizes and where they are positioned in the window. This is
where *packing* comes in.

GTK+ comes with a variety of *layout containers* whose purpose it is to control
the layout of child widgets added to them, as well as how they behave when the
window is resized. An overview may be seen in the
[Layout Containers Overview](https://developer.gnome.org/gtk3/stable/LayoutContainers.html)
in the online GTK+ documentation.

In this chapter, we shall look at packing using Boxes and Grids in detail.

## Packing Using Boxes

You can do widget packing using boxes. These are invisible widget containers
that we can pack our widgets into (we will refer the widgets we pack into the
box as *children*). These boxes are instances of the `Gtk.Box` widget. The
`Gtk.Box` widget organizes its child widgets into a rectangular area.

The rectangular area of a `Gtk.Box` is organized into either a single row or a
single column of child widgets depending upon the orientation selected. In a
horizontal `Gtk.Box` all children are allocated the same height, and in a
vertical `Gtk.Box` all the children of the box have the same width.

`Gtk.Box` uses a notion of *packing*. Packing refers to adding widgets with
reference to a particular position in a `Gtk.Container` (`Gtk.Box` is a subclass
of `Gtk.Container`). For a `Gtk.Box`, there are two reference positions: the
start and the end of the box. For a vertical `Gtk.Box`, the start is defined as
the top of the box and the end is defined as the bottom. For a horizontal
`Gtk.Box` the start is defined as the left side and the end is defined as the
right side.

When packing widgets horizontally, the objects are inserted from left to right
or right to left depending on the packing method used. If they are inserted
vertically, child widgets are packed from top to bottom or vice versa. You may
use any combination of boxes inside or beside other boxes to create a desired
effect.

The constructor for `Gtk.Box` is

<pre><code class="vala">Gtk.Box(Gtk.Orientation orientation, int spacing);</code></pre>

`orientation` is an instance of the enumerated type `Gtk.Orientation`, which
takes one of two values: `Gtk.Orientation.HORIZONTAL` and
`Gtk.Orientation.VERTICAL`. If `HORIZONTAL` is passed to the constructor, the
children of the box are arranged in a single row, and if `VERTICAL` is passed,
the children will be arranged in a single column. `spacing` is the number of
pixels to place by default between children.

The instance methods `pack_start()` and `pack_end()` are used to place child
objects inside the `Gtk.Box` containers.

<pre><code class="vala">/* When we call box.pack_end(...) we add child to
   box, packed with reference to the end of box. */
public void pack_end (Gtk.Widget child, bool expand = true, bool fill = true, uint padding = 0);

/* When we call box.pack_start(...) it adds child to box,
   packed with reference to the beginning of box. */
public void pack_start (Gtk.Widget child, bool expand = true, bool fill = true, uint padding = 0);
</code></pre>

The `pack_start()` method will start at the top and work its way down in a
vertical box, and pack left to right in a horizontal box. The `pack_end()`
method will do the opposite, packing from bottom to top in a vertical box, and
right to left in a horizontal box. Using these methods allows us to right
justify or left justify our widgets and may be mixed in any way to achieve the
desired effect. We will use `pack_start()` in most of our examples. The child
object may be another container or a widget. In fact, many widgets are actually
containers themselves, including the button (though we usually only use a label
inside a button).

You may use the `set_homogeneous(bool homogeneous)` instance method to specify
whether or not all children of the `Gtk.Box` are forced to get the same amount
of space (if `homogeneous` is set to `true`, child widgets will be allocated
equal width in a horizontal box or equal height in a vertical box).

You can also use `box.set_spacing()` to determine how much space will be
minimally placed between all children in the `Gtk.Box`. Note that spacing is
added *between* the children, while the padding added by `pack_start` or
`pack_end` is added *on either side* of the widget it belongs to.

By using these calls, GTK+ knows where you want to place your widgets so it can
do automatic resizing and other nifty things. There are also a number of options
as to how your widgets should be packed. This method gives us a quite a bit of
flexibility when placing and creating widgets.


## Details of Boxes

Because of this flexibility, packing boxes in GTK can be confusing at first.
There are a lot of options, and it's not immediately obvious how they all fit
together. In the end, however, there are basically five different styles.

Below, we see how we may use some of the box packing methods to achieve certain
effects. It's obtained by compiling
`chapter-05-packing-widgets/code/01Packbox.vala` and running the executable with
the command-line argument `1`.

<figure>
  <img src="https://lh6.googleusercontent.com/-v6DfjOqopik/UiIlpYW_SWI/AAAAAAAAAFY/cpX4qpRwn6A/w667-h447-no/01Packbox_1.png" alt="Packing: Five Variations" title="Packing: Five Variations">
  <figcaption>Packing: Five Variations</figcaption>
</figure>

Each line contains one box with several buttons. The call to pack is shorthand
for the call to pack each of the buttons into the box. Each of the buttons is
packed into the box the same way (i.e., with the same arguments to the
`pack_start()` method).

The expand argument to `pack_start()` and `pack_end()` controls whether the
widgets are laid out in the box to fill in all the extra space in the box so the
box is expanded to fill the area allotted to it (`true`); or the box is shrunk
to just fit the widgets (`false`). Setting expand to `false` will allow you to
do right and left justification of your widgets. Otherwise, they will all expand
to fit into the box, and the same effect could be achieved by using only one of
`pack_start()` or `pack_end()`.

The `fill` argument to the pack methods control whether the extra space is
allocated to the objects themselves (`true`), or as extra padding in the box
around these objects (`false`). It's value affects the appearance of the box and
its widgets only if the `expand` argument is also set to `true`.

Vala allows a method or function to be defined with default argument values for
the last parameters of a method, so that you do not have to explicitly pass
values for them with every call. For example the `pack_start()` and `pack_end()`
method are defined as above, with default arguments for `expand`, `fill` and
`padding` as shown above. The `child` argument, however, must be specified. This
means that one may add a widget `child` to a box `box` using the call

<pre><code class="vala">box.pack_start(child);</code></pre>

and `child` will be added to `box` with `expand = true`, `fill = true`, and
`padding = 0`.

What's the difference between spacing (set when the box is created) and padding
(set when elements are packed)? Spacing is added between objects, and padding is
added on either side of an object.

The figure below, “Packing with Spacing and Padding” illustrates the difference.
You view see it by compiling `chapter-05-packing-widgets/code/01Packbox.vala`
and running the executable with the command-line argument `2`.

<figure>
  <img src="https://lh5.googleusercontent.com/-sgWP2rLslG4/UiInegxM5tI/AAAAAAAAAFs/V63V796aJkY/w520-h383-no/01Packbox_2.png" alt="Packing with Spacing and Padding" title="Packing with Spacing and Padding">
  <figcaption>Packing with Spacing and Padding</figcaption>
</figure>

The figure below, “Packing with `pack_end()`” illustrates the use of the
`pack_end()` method (pass an argument of 3 to the compiled executable). The
label "end" is packed with the `pack_end()` method. It will stick to the right
edge of the window when the window is resized.

<figure>
  <img src="https://lh6.googleusercontent.com/-cG7EtmGRNDM/UiIoabdRa0I/AAAAAAAAAF8/ubY8frReUlI/w596-h228-no/01Packbox_3.png" alt="Packing with pack_end()" title="Packing with pack_end()">
  <figcaption>Packing with <code>pack_end()</code></figcaption>
</figure>


The following code contains the code used to create the above images. Try to
play with it to see the effect of any changes.

<pre><code class="vala">/*
 * Helper function that makes a new hbox filled with button-labels.
 * Arguments for the variables we're interested are passed in to
 * this function.  We do not show the box, but do show everything
 * inside.
 */
static Gtk.Box make_box (bool homogeneous, int spacing, bool expand, bool fill, int padding) {

  Gtk.Box box;
  Gtk.Button button;
  string padstr;

  /* Create a new Gtk.Box with the appropriate orientation
   * and spacing settings */
  box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, spacing);
  /* Set whether all child widgets be the same size. */
  box.set_homogeneous(homogeneous);

  /* Create a series of buttons with the appropriate settings */
  button = new Gtk.Button.with_label("box.pack");
  box.pack_start(button, expand, fill, padding);
  button.show();

  /*button = new Gtk.Button.with_label ("(box,");
  box.pack_start(button, expand, fill, padding);
  button.show();*/

  button = new Gtk.Button.with_label("(button,");
  box.pack_start(button, expand, fill, padding);
  button.show();

  /* Create a button with the label depending on the value of
   * expand. */
  button = new Gtk.Button.with_label(@"$expand,");
  /*if (expand == true)
    button = new Gtk.Button.with_label("true,");
  else
    button = new Gtk.Button.with_label("false,");*/

  box.pack_start(button, expand, fill, padding);
  button.show();

  /* This is the same as the button creation for "expand"
   * above, but uses the shorthand form. */
  button = new Gtk.Button.with_label(@"$fill,");
  box.pack_start (button, expand, fill, padding);
  button.show();

  padstr = @"$padding);";

  button = new Gtk.Button.with_label(padstr);
  box.pack_start(button, expand, fill, padding);
  button.show();

  return box;
}

class PackBox : Gtk.Window {

  public bool on_delete_event () {
    Gtk.main_quit();
    return false;
  }

  public PackBox (int which) {

    /* You should always remember to connect the delete_event signal
     * to the main window. This is very important for proper intuitive
     * behavior */

    this.delete_event.connect(this.on_delete_event);
    this.set_border_width(10);

    /* We create a vertical box (vbox) to pack the horizontal boxes
     * into. This allows us to stack the horizontal boxes filled with
     * buttons one on top of the other in this vbox. */
    var box1 = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

    /* Which example to show. These correspond to the pictures above. */
    switch (which) {
      case 1:
        /* create two new labels. */
        var label = new Gtk.Label("Gtk.Box(HORIZONTAL, 0)");
        var label2 = new Gtk.Label("box.set_homogeneous(false)");

        /* Align the labels to the left side.  We'll discuss this method
         * and others in the section on Widget Attributes. */
        label.set_alignment(0, 0);
        label2.set_alignment(0, 0);

        /* Pack the labels into the vertical box (box box1).  Remember
         * that widgets added to a vertically oriented box will be
         * packed one on top of the other in order. */
        box1.pack_start(label, false, false, 0);
        box1.pack_start(label2, false, false, 0);

        /* Show the labels. */
        label.show();
        label2.show();

        /* Call our make box function - homogeneous = false, spacing = 0,
         * expand = false, fill = false, padding = 0 */
        var box2 = make_box(false, 0, false, false, 0);
        box1.pack_start(box2, false, false, 0);
        box2.show();

        /* Call our make box function - homogeneous = false, spacing = 0,
         * expand = true, fill = false, padding = 0 */
        box2 = make_box(false, 0, true, false, 0);
        box1.pack_start(box2, false, false, 0);
        box2.show();

        /* Args are: homogeneous, spacing, expand, fill, padding */
        box2 = make_box(false, 0, true, true, 0);
        box1.pack_start(box2, false, false, 0);
        box2.show();

        /* Creates a separator, we'll learn more about these later,
         * but they are quite simple. */
        var separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);

        /* Pack the separator into the vbox. Remember each of these
         * widgets is being packed into a vertically oriented box, so
         * they'll be stacked vertically. */
        box1.pack_start(separator, false, true, 5);
        separator.show();

        /* Create another new label, and show it. */
        label = new Gtk.Label("Gtk.Box(Gtk.Orientation.HORIZONTAL, 0)");

        label.set_alignment(0, 0);
        box1.pack_start(label, false, false, 0);
        label.show();

        label2 = new Gtk.Label("box.set_homogeneous(true)");
        label2.set_alignment(0, 0);
        box1.pack_start(label2, false, false, 0);
        label2.show();


        /* Args are: homogeneous, spacing, expand, fill, padding */
        box2 = make_box(true, 0, true, false, 0);
        box1.pack_start(box2, false, false, 0);
        box2.show();

        /* Args are: homogeneous, spacing, expand, fill, padding */
        box2 = make_box(true, 0, true, true, 0);
        box1.pack_start(box2, false, false, 0);
        box2.show();

        /* Another new separator. */
        separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        /* The last 3 arguments to pack_start are:
         * expand, fill, padding. */
        box1.pack_start(separator, false, true, 5);
        separator.show();
        break;
      case 2:
        /* Create a new label, remember box1 is a vbox as created
         * near the beginning of the constructor. */
        var label = new Gtk.Label("Gtk.Box(HORIZONTAL, 10)");
        label.set_alignment( 0, 0);
        box1.pack_start(label, false, false, 0);
        label.show();

        var label2 = new Gtk.Label("box.set_homogeneous(false)");
        label2.set_alignment( 0, 0);
        box1.pack_start(label2, false, false, 0);
        label2.show();

        /* Args are: homogeneous, spacing, expand, fill, padding. */
        var box2 = make_box(false, 10, true, false, 0);
        box1.pack_start(box2, false, false, 0);
        box2.show();

        /* Args are: homogeneous, spacing, expand, fill, padding */
        box2 = make_box(false, 10, true, true, 0);
        box1.pack_start(box2, false, false, 0);
        box2.show();

        var separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        /* The last 3 arguments to pack_start are:
         * expand, fill, padding. */
        box1.pack_start(separator, false, true, 5);
        separator.show();

        label = new Gtk.Label("Gtk.Box(HORIZONTAL, 0)");
        label.set_alignment(0, 0);
        box1.pack_start(label, false, false, 0);
        label.show();

        label2 = new Gtk.Label("box.set_homogeneous(false)");
        label2.set_alignment( 0, 0);
        box1.pack_start(label2, false, false, 0);
        label2.show();

        /* Args are: homogeneous, spacing, expand, fill, padding. */
        box2 = make_box(false, 0, true, false, 10);
        box1.pack_start(box2, false, false, 0);
        box2.show();

        /* Args are: homogeneous, spacing, expand, fill, padding. */
        box2 = make_box(false, 0, true, true, 10);
        box1.pack_start(box2, false, false, 0);
        box2.show();

        separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);
        /* The last 3 arguments to pack_start are:
         * expand, fill, padding. */
        box1.pack_start(separator, false, true, 5);
        separator.show();
      break;
      case 3:
        /* This demonstrates the ability to use pack_end() to
         * right justify widgets. First, we create a new box as before. */
        var box2 = make_box(false, 0, false, false, 0);

        /* Create the label that will be put at the end. */
        var label = new Gtk.Label("end");
        /* Pack it using pack_end(), so it is put on the right
         * side of the hbox created in the make_box() call. */
        box2.pack_end(label, false, false, 0);
        /* Show the label. */
        label.show();

        /* Pack box2 into box1 */
        box1.pack_start(box2, false, false, 0);
        box2.show();

        /* A separator for the bottom. */
        var separator = new Gtk.Separator(Gtk.Orientation.HORIZONTAL);

        /* This explicitly sets the separator to 400 pixels wide by 5
         * pixels high. This is so the hbox we created will also be 400
         * pixels wide, and the "end" label will be separated from the
         * other labels in the hbox. Otherwise, all the widgets in the
         * hbox would be packed as close together as possible.
         * separator.set_size_request(400, 5)
         * pack the separator into the vbox (box1) created near the
         * start of the constructor. */
        box1.pack_start(separator, false, true, 5);
        separator.show();
      break;
    }

    /* Create another new hbox. Remember we can use as many as we need! */
    var quitbox = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
    quitbox.set_homogeneous(false);

    /* Our quit button. */
    var button = new Gtk.Button.with_label("Quit");

    /* Setup the signal to terminate the program when the button is
     * clicked */
    button.clicked.connect( () => { Gtk.main_quit(); } );
    /* Pack the button into the quitbox.
     * The last 3 arguments to pack_start are:
     * expand, fill, padding. */
    quitbox.pack_start(button, true, false, 0);
    /* pack the quitbox into the vbox (box1) */
    box1.pack_start(quitbox, false, false, 0);

    /* Pack the vbox (box1) which now contains all our widgets, into the
     * main window. */
    this.add(box1);

    /* And show everything left */
    button.show();
    quitbox.show();
    box1.show();

    /* Showing the window last so everything pops up at once. */
    this.show();
  }

  public static int main (string[] args) {

    if (args.length == 2) {

      Gtk.init(ref args);

      var window = new PackBox(int.parse(args[1]));
      window.show();

      /* And of course, our mainloop. */
      Gtk.main();

      /* Control returns here when Gtk.main_quit() is called. */
      return 0;

    } else {
      stderr.printf("usage: packbox num, where num is 1, 2, or 3.\n");
      /* This just does cleanup in GTK and exits with an exit status
       * of 1. */
      Process.exit (1);
    }

  }
}
</code></pre>

A brief tour of the `01_packingboxes.vala` code starts with lines 10-60 which
define a helper function `make_box()` that creates a horizontal box and
populates it with buttons according to the specified parameters. A reference to
the horizontal box is returned.

Lines 71-283 define the `PackBox1` class initialization method `PackBox1()` that
creates a window and a child vertical box that is populated with a different
widget arrangement depending on the argument passed to it. If a `1` is passed,
lines 90-166 create a window displaying the five unique packing arrangements
that are available when varying the homogeneous, expand and fill parameters.
If a `2` is passed, lines 167-221 create a window displaying the various
combinations of fill with spacing and padding. Finally, if a `3` is passed,
lines 222-252 create a window displaying the use of the `pack_start()` method to
left justify the buttons and `pack_end()` method to right justify a label. Lines
255-270 create a horizontal box containing a button that is packed into the
vertical box. The button "clicked" signal is connected to the `Gtk.main_quit()`
function to terminate the program.

Lines 287-304 check the command line arguments and exit the program by returning
`1` from the `main()` function if there isn't exactly one argument. Line 291
creates a `PackBox1` instance. Line 294 invokes the `Gtk.main()` function to
start the GTK event processing loop.

In this example program, the references to the various widgets (except the
window) are not saved in the object instance attributes because they are not
needed later.

To learn more about using the `Gtk.Box` widget, read the C API documentation at
[https://developer.gnome.org/gtk3/stable/GtkBox.html](https://developer.gnome.org/gtk3/stable/GtkBox.html),
and the Vala API documentation at [http://valadoc.org/#!api=gtk+-3.0/Gtk.Box](http://valadoc.org/#!api=gtk+-3.0/Gtk.Box).

## Packing Using Grids

Let's look at another way of packing widgets, the `Gtk.Grid`. `Gtk.Grid` is a
container which arranges its child widgets in rows and columns.

The first thing to look at, of course, is the `Gtk.Grid()` constructor:

<pre><code class="vala">var grid = Gtk.Grid();</code></pre>

which creates a new instance of `Gtk.Grid` and returns a reference to it.

A `Gtk.Grid` has a boolean "`column_homogeneous`" property, if its value is
`true` the grid's columns will all the same width (the width of the widest
child widget in the grid). Its default value is `false`, where the width of a
grid's column is dictated by the widest widget in the column. An analogous
`row_homogeneous` property does the same for the height of rows.

Note that the coordinate system starts from 0 in the upper left hand corner.

Children are added using `Gtk.Grid.attach()`. They can span as many rows or
columns as we specify.

To place a widget into a grid, we use the following method:

<pre><code class="vala">public void attach(Gtk.Widget child, int left, int top, int width, int height);</code></pre>

The first parameter (`child`) is the widget you wish to place in the table. The
`left` and `top` arguments specify where to place the widget (counting from 0
at the left and top respectively), and the `width` and `height` specify how many
boxes to use (integers specifying how many columns and rows the widget will
occupy respectively).

If you want to add a button in the upper left corder of a grid, and want it to
fill one row and one column, you would have  `left = 0`, `top = 0`, `width = 1`,
and `height = 1`.

If you wanted a child widget in the upper left corner that will take up two
rows, you'd use `left = 0`, `top = 0`, `width = 2`, and `height=1`.

We can also use the `Gtk.Grid.attach_next_to` method to add new widgets next to
sibling elements already in the grid.

<pre><code class="vala">public void attach_next_to (Widget child, Widget? sibling, PositionType side, int width, int height)</code></pre>

adds the widget `child` next to the widget `sibling`, on the side defined by
`side`, which is an instance of `Gtk.PositionType`, which an enumeration that \
takes one of the values: `Gtk.PositionType.LEFT` (adds `child` on the left edge
of `sibling`), `Gtk.PositionType.RIGHT`, `Gtk.PositionType.TOP`, and
`Gtk.PositionType.BOTTOM`.

We can set spacing between the rows and columns of the grid (in pixels) using
the following methods:

<pre><code class="vala">grid.set_row_spacing (int spacing)

grid.set_col_spacing (uint spacing)
</code></pre>

Note that for columns, the space goes to the right of the column, and for rows,
the space goes below the row.

## Example

In the example below, we will make a window with seven buttons in a grid, showing
the various ways you can position child elements in a grid.

<pre><code class="vala">class GridExample : Gtk.Window {

  /* Our callback.
   * The data passed to this method is printed to stdout */
  void callback(string data) {
    stdout.printf("Hello again - %s was pressed\n", data);
  }

  /* This callback quits the program. */
  public bool on_delete_event() {
    Gtk.main_quit();
    return false;
  }

  public GridExample () {

    /* Set the window title. */
    this.set_title("Grid Packing Example");

    /* Set a handler for delete_event that immediately
     *exits Gtk. */
    this.delete_event.connect(this.on_delete_event);

    /* Sets the border width of the window. */
    this.set_border_width(20);

    /* Create a 2x2 table. */
    var grid = new Gtk.Grid();

    /* Put the table in the main window. */
    this.add(grid);

    /* Create first button. */
    var button = new Gtk.Button.with_label("button 1");
    /* When the button is clicked, we call the "callback" method. */
  button.clicked.connect( ()=>{ this.callback("button 1"); });
  grid.attach (button, 0, 0, 1, 1);
  button.show();

  /* Create second button. */
    button = new Gtk.Button.with_label("button 2");
    /* When the button is clicked, we call the "callback" method, this
     * time with a different button name. */
    button.clicked.connect( () => { this.callback("button 2"); } );
    /* Insert button 2 into the second column of the first row. */
    grid.attach(button, 1, 0, 1, 1);
    button.show();

    /* Create Third button. */
    button = new Gtk.Button.with_label("button 3");
    button.clicked.connect( () => { this.callback("button 3"); } );
    /* Insert button 3 to the right of button 2. */
    grid.attach_next_to(button, grid.get_child_at(0, 1), Gtk.PositionType.RIGHT, 1, 1);
    button.show();

    /* Create Fourth button. */
    button = new Gtk.Button.with_label("button 4");
    button.clicked.connect( () => { this.callback("button 4"); } );
    /* Insert button 4 into the 2nd row of the grid (below button 1). */
    grid.attach_next_to(button, grid.get_child_at(0, 0), Gtk.PositionType.BOTTOM, 1, 2);
    button.show();

    button = new Gtk.Button.with_label("button 5");
    button.clicked.connect( () => { this.callback("button 5"); } );
    /* Insert button 5 into the second row of the grid, to occupy 2
     * columns. */
    grid.attach(button, 1, 1, 2, 1);
    button.show();

    button = new Gtk.Button.with_label("button 6");
    button.clicked.connect( () => { this.callback("button 6"); } );
    /* Insert button 6 into the third row of the grid. */
    grid.attach(button, 1, 2, 1, 1);
    button.show();

    button = new Gtk.Button.with_label("button 7");
    button.clicked.connect( () => { this.callback("button 7"); } );
    /* Insert button 7 into the third row of the grid. */
    grid.attach(button, 2, 2, 1, 1);
    button.show();

    /* Create "Quit" button */
    button = new Gtk.Button.with_label("Quit");
    /* When the button is clicked, we call the main_quit function
     * and the program exits. */
    button.clicked.connect( ()=> { Gtk.main_quit(); });
    /* Insert the quit button into the fourth row of the grid. */
    grid.attach(button, 0, 3, 3, 1);
    button.show();

    grid.show();

  }

  public static int main(string[] args) {

    Gtk.init(ref args);

    var gridexample = new GridExample();

    gridexample.show();

    Gtk.main();

    return 0;
  }
}
</code></pre>

When compiled and run, it looks something like this:

<figure>
  <img src="https://lh6.googleusercontent.com/-HFq2_JMwuyM/UiIzA7LGNUI/AAAAAAAAAGU/I-qy2nsolvw/w354-h294-no/02Grid.png" alt="Grid Packing Example Image" title="Grid Packing Example">
  <figcaption>Grid Packing Example</figcaption>
</figure>


## Stacks and StackSwitchers

The `Gtk.Stack` widget is a container which only shows one of its children at a
time. A `Gtk.StackSwitcher` widget can be used with a `Gtk.Stack` to provide 
this functionality. The `StackSwitcher` widget shows a row of buttons to switch
between the various pages of the associated `Gtk.Stack`.

Transitions between pages can be animated as slides or fades. This can be
controlled with `Gtk.Stack.set_transition_type()`. These animations respect the
“`gtk-enable-animations`” setting.

The window below

<figure>
  <img src="https://lh4.googleusercontent.com/-XkUhAmxFRUc/VHB91MI6WjI/AAAAAAAAAL0/Dw6NvojajxU/w457-h181-no/03Stack.png" alt="Stack &amp; StackSwitcher Example" title="Stack &amp; StackSwitcher Example">
  <figcaption>Stack &amp; StackSwitcher Example</figcaption>
</figure>

is obtained when you compile and run the code:

<pre><code class="vala">class StackExample : Gtk.Window {

  public StackExample () {    
    
    this.set_title("Stack and StackSwitcher Demo");
    this.window_position = Gtk.WindowPosition.CENTER;
    this.set_default_size(350, 70);
    this.set_border_width(10);
    this.destroy.connect(Gtk.main_quit);

    var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 5);
    this.add(box);

    var stack = new Gtk.Stack();
    stack.set_transition_type(Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
    stack.set_transition_duration(1000);
    
    var label1 = new Gtk.Label("Page 1 Content.");
    stack.add_titled(label1, "page-1", "Page 1");
    
    var label2 = new Gtk.Label("Page 2 Content.");
    stack.add_titled(label2, "page-2", "Page 2");

    var label3 = new Gtk.Label("Page 3 Content.");
    stack.add_titled(label3, "page-3", "Page 3");


    var switcher = new Gtk.StackSwitcher();
    switcher.set_stack(stack);
    box.pack_start(switcher, true, true, 0);
    box.pack_start(stack, true, true, 0);
 
  }

  public static int main (string[] args) {
    
    Gtk.init(ref args);
    
    var win = new StackExample();
    win.show_all();

    Gtk.main();
    
    return 0;
  }

}
</code></pre>


## References and Further Reading

* The GTK+ Tutorial: Packing Widgets. [Online] Available from:
  [https://developer.gnome.org/gtk-tutorial/2.90/c354.html](https://developer.gnome.org/gtk-tutorial/2.90/c354.html)
  [Accessed 10&nbsp;November&nbsp;2014]

* The GtkGrid Section of the GTK 3 Reference Manual. [Online] Available from:
  [https://developer.gnome.org/gtk3/stable/GtkGrid.html](https://developer.gnome.org/gtk3/stable/GtkGrid.html)
  [Accessed 10&nbsp;November&nbsp;2014]

* Documentation on Gtk.Box in Valadoc [Online] Available from:
  [http://valadoc.org/#!api=gtk+-3.0/Gtk.Box](http://valadoc.org/#!api=gtk+-3.0/Gtk.Box)
  [Accessed 16&nbsp;September&nbsp;2014]

* Documentation on Gtk.Grid in Valadoc [Online] Available from:
  [http://valadoc.org/#!api=gtk+-3.0/Gtk.Grid](http://valadoc.org/#!api=gtk+-3.0/Gtk.Grid)
  [Accessed 16&nbsp;September&nbsp;2014]

* The Python GTK+3 Tutorial [Online] Available from:
  [http://python-gtk-3-tutorial.readthedocs.org/en/latest/layout.html](http://python-gtk-3-tutorial.readthedocs.org/en/latest/layout.html)
  [Accessed 22&nbsp;November&nbsp;2014]
