
# Packing Widgets

When creating an application, you'll want to put more than one widget inside a
window. Our first helloworld example only used one widget so we could simply use
the `Gtk.Container.add()` method to "pack" the widget into the window. But when
you want to put more than one widget into a window, how do you control where
that widget is positioned? This is where packing comes in.


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
or right to left depending on the call used. If they are inserted vertically,
widgets are packed from top to bottom or vice versa. You may use any combination
of boxes inside or beside other boxes to create a desired effect.

The constructor for `Gtk.Box` is

    var box = Gtk.Box(Gtk.Orientation orientation, int spacing);

`orientation` is an instance of the enumerated type `Gtk.Orientation`, which
takes one of two values: `Gtk.Orientation.HORIZONTAL` and
`Gtk.Orientation.VERTICAL`. If `HORIZONTAL` is passed to the constructor, the
children of the box are arranged in a single row, and if `VERTICAL` is passed,
the children will be arranged in a single column. `spacing` is the number of
pixels to place by default between children.

The instance methods `pack_start()` and `pack_end()` are used to place child
objects inside the `Gtk.Box` containers.

    /* When called as box.pack_end(...) it adds child to
       box, packed with reference to the end of box. */
    public void pack_end (Gtk.Widget child, bool expand = true,
                          bool fill = true, uint padding = 0);

    /* When called as box.pack_start(...) it adds child to box,
       packed with reference to the beginning of box. */
    public void pack_start (Gtk.Widget child, bool expand = true,
                            bool fill = true, uint padding = 0);

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


##Details of Boxes

Because of this flexibility, packing boxes in GTK can be confusing at first.
There are a lot of options, and it's not immediately obvious how they all fit
together. In the end, however, there are basically five different styles.

Below, we see how we may use some of the box packing methods to achieve certain
effects.

<figure>
  <img src="https://lh5.googleusercontent.com/-w8j_zbc97ZU/Uf-1hNyi6TI/AAAAAAAAAEQ/s0h9kqDvbyI/w597-h351-no/01_packbox_1.png" alt="Packing: Five Variations" title="Packing: Five Variations">
  <figcaption>Packing: Five Variations</figcaption>
</figure>

Each line contains one box with several buttons. The call to pack is shorthand
for the call to pack each of the buttons into the box. Each of the buttons is
packed into the box the same way (i.e., with the same arguments to the
`pack_start()` method).

This is an example of the `pack_start()` method.

    box.pack_start(child, expand, fill, padding)

`box` is the box you are packing the object into; the first argument is the
child widget to be packed. The objects will all be buttons for now, so we'll be
packing buttons into boxes.

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

Vala allows a method or function to be defined with default argument values. For
example the `pack_start()` and `pack_start()` method are defined as:

    public void pack_start (Widget child, bool expand = true, bool fill = true, uint padding = 0)

    public void pack_end (Widget child, bool expand = true, bool fill = true, uint padding = 0)


child, expand, fill and padding are keywords. The expand, fill and padding
arguments have the defaults shown. The child argument must be specified.

What's the difference between spacing (set when the box is created) and padding
(set when elements are packed)? Spacing is added between objects, and padding is
added on either side of an object. Figure 4.2, “Packing with Spacing and Padding”
illustrates the difference; pass an argument of 2 to packbox.py:

<figure>
  <img src="https://lh6.googleusercontent.com/-M1g3qLtFXpI/Uf-1hD9NYMI/AAAAAAAAAEg/IQ2dH_EMaog/w482-h338-no/02_packbox_2.png" alt="Packing with Spacing and Padding" title="Packing with Spacing and Padding">
  <figcaption>Packing with Spacing and Padding</figcaption>
</figure>

The figure below, “Packing with `pack_end()`” illustrates the use of the
`pack_end()` method (pass an argument of 3 to `packbox`). The label "end" is
packed with the `pack_end()` method. It will stick to the right edge of the
window when the window is resized.

<figure>
  <img src="https://lh5.googleusercontent.com/-w8j_zbc97ZU/Uf-1hNyi6TI/AAAAAAAAAEQ/s0h9kqDvbyI/w597-h351-no/01_packbox_1.png" alt="Packing with pack_end()" title="Packing with pack_end()">
  <figcaption>Packing with `pack_end()`</figcaption>
</figure>

The following section contains the code used to create the above images. Compile
it and play with it.

## Packing Demonstration Program


<script src="https://gist.github.com/abenga/6391233.js"></script>

A brief tour of the `01_packingboxes.vala` code starts with lines 10-60 which
define a helper function `make_box()` that creates a horizontal box and
populates it with buttons according to the specified parameters. A reference to
the horizontal box is returned.

Lines 71-283 define the `PackBox1` class initialization method `PackBox1()` that
creates a window and a child vertical box that is populated with a different
widget arrangement depending on the argument passed to it. If a 1 is passed,
lines 90-166 create a window displaying the five unique packing arrangements
that are available when varying the homogeneous, expand and fill parameters.
If a 2 is passed, lines 167-221 create a window displaying the various
combinations of fill with spacing and padding. Finally, if a 3 is passed,
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

To learn about the `Gtk.Box` widget, read the C API documentation at
[https://developer.gnome.org/gtk3/stable/GtkBox.html](https://developer.gnome.org/gtk3/stable/GtkBox.html),
and the Vala API documentation at [http://valadoc.org/#!api=gtk+-3.0/Gtk.Box](http://valadoc.org/#!api=gtk+-3.0/Gtk.Box).

## Packing Using Tables

Let's take a look at another way of packing - Tables. These can be extremely
useful in certain situations.

Using tables, we create a grid that we can place widgets in. The widgets may
take up as many spaces as we specify.

The first thing to look at, of course, is the `Gtk.Table()` constructor:

    var table = Gtk.Table (uint rows, uint columns, bool homogeneous)

The first argument is the number of rows to make in the table, while the second,
obviously, is the number of columns. These two define the size of the new table,
and must be given.

The `homogeneous` argument has to do with how the table's boxes are sized. If
homogeneous is `true`, the table boxes are resized to the size of the largest
widget in the table. If homogeneous is `false`, the size of a table's  boxes is
dictated by the tallest widget in its same row, and the widest widget in its
column.

The rows and columns are laid out from 0 to n, where n was the number specified
in the call to `Gtk.Table()`. So, if you specify `rows = 2` and `columns = 2`,
the layout would look something like this:

<pre>
   0          1          2
  0+----------+----------+
   |          |          |
  1+----------+----------+
   |          |          |
  2+----------+----------+
</pre>

Note that the coordinate system starts in the upper left hand corner. To place a
widget into a box, use the following method:

Note also that `rows` and `` has to be between 1 and 65535.

    table.attach (Widget child, uint left_attach, uint right_attach,
                  uint top_attach, uint bottom_attach, AttachOptions xoptions,
                   AttachOptions yoptions, uint xpadding, uint ypadding)

The `table` instance is the table you created with `Gtk.Table()`. The first
parameter (`child`) is the widget you wish to place in the table.

The `left_attach`, `right_attach`, `top_attach` and `bottom_attach` arguments
specify where to place the widget, and how many boxes to use. If you want a
button in the lower right table entry of our 2x2 table, and want it to fill that
entry ONLY, you would have `left_attach= 1`, `right_attach = 2`, `top_attach = 1`,
`bottom_attach = 2`.

Now, if you wanted a widget to take up the whole top row of our 2x2 table, you'd
use `left_attach = 0`, `right_attach = 2`, `top_attach = 0`, `bottom_attach = 1`.

The `xoptions` and `yoptions` are used to specify packing options and may be
bitwise OR'ed together to allow multiple options. The `xoptions` and `yoptions`
are instances of the `Gtk.AttachOptions`. They are used to specify packing
options and may be bitwise OR'ed together to allow multiple options. They denote
the expansion properties that the child elements will have when they (or the
parent table) are resized.

These options are:

* `FILL`
  If the table cell is larger than the widget, and `FILL`   is specified, the
  widget will expand to use all the room available in the cell.

* `SHRINK`
  If the table widget was allocated less space then was requested (usually by
  the user resizing the window), then the widgets would normally just be pushed
  off the bottom of the window and disappear. If `SHRINK` is specified, the
  widgets will shrink with the table.
* `EXPAND`
  This will cause the table cell to expand to use up any remaining space
  allocated to the table.


Padding is just like in boxes, creating a clear area around the widget specified
in pixels.

We also have `set_row_spacing()` and `set_col_spacing()` methods. These add
spacing between the rows at the specified row or column.

<programlisting language="vala">
  table.set_row_spacing (uint row, uint spacing)
</programlisting>

and

    table.set_col_spacing (uint column, uint spacing)

Note that for columns, the space goes to the right of the column, and for rows,
the space goes below the row.

You can also set a consistent spacing of all rows and/or columns with:

    table.set_row_spacings (uint spacing)

and,

    table.set_col_spacings (uint spacing)

Note that with these calls, the last row and last column do not get any spacing.

## Table Packing Example

Here we make a window with three buttons in a 2x2 table. The first two buttons
will be placed in the upper row. A third, quit button, is placed in the lower
row, spanning both columns. Which means it should look something like this:

<figure>
  <img src="https://lh6.googleusercontent.com/-x5UEqXhVsKo/Uf-1h1pBtbI/AAAAAAAAAEY/XHUO4d9o0GY/w288-h195-no/04_table.png" alt="Table Packing Example" title="Table Packing Example">
  <figcaption>Table Packing Example</figcaption>
</figure>

    using Gtk;

    class TableExample {

      private Gtk.Window window;

      /* Our callback.
       * The data passed to this method is printed to stdout */
      void callback(string data) {
        stdout.printf("Hello again - %s was pressed\n", data);
      }

      /* This callback quits the program. */
      public bool delete_event() {
        Gtk.main_quit();
        return false;
      }

      public TableExample () {
        /* Create a new window. */
        this.window = new Gtk.Window(Gtk.WindowType.TOPLEVEL);

        /* Set the window title. */
        this.window.set_title("Table");

        /* Set a handler for delete_event that immediately
         *exits Gtk. */
        this.window.delete_event.connect(this.delete_event);

        /* Sets the border width of the window. */
        this.window.set_border_width(20);

        /* Create a 2x2 table. */
        var table = new Gtk.Table(2, 2, true);

        /* Put the table in the main window. */
        this.window.add(table);

        /* Create first button. */
        var button = new Gtk.Button.with_label("button 1");

        /* When the button is clicked, we call the "callback" method
         * with a pointer to "button 1" as its argument. */
        button.clicked.connect( ()=>{ this.callback("button 1"); });
        /* Insert button 1 into the upper left quadrant of the table. */
        table.attach_defaults(button, 0, 1, 0, 1);
        button.show();

        /* Create second button. */
        button = new Gtk.Button.with_label("button 2");
        /* When the button is clicked, we call the "callback" method
         * with a pointer to "button 2" as its argument */
        button.clicked.connect( () => { this.callback("button 2"); } );
        /* Insert button 2 into the upper right quadrant of the table. */
        table.attach_defaults(button, 1, 2, 0, 1);

        button.show();

        /* Create "Quit" button */
        button = new Gtk.Button.with_label("Quit");

        /* When the button is clicked, we call the main_quit function
         * and the program exits. */
        button.clicked.connect( ()=> { Gtk.main_quit(); });

        /* Insert the quit button into the both lower quadrants of the table */
        table.attach_defaults(button, 0, 2, 1, 2);

        button.show();

        table.show();
        this.window.show();
      }

      public static int main(string[] args) {

        Gtk.init(ref args);

        new TableExample();

        Gtk.main();

        return 0;
      }

    }
