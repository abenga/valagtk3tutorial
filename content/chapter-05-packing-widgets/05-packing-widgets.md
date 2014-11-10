
# Packing Widgets

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

    Gtk.Box(Gtk.Orientation orientation, int spacing);

`orientation` is an instance of the enumerated type `Gtk.Orientation`, which
takes one of two values: `Gtk.Orientation.HORIZONTAL` and
`Gtk.Orientation.VERTICAL`. If `HORIZONTAL` is passed to the constructor, the
children of the box are arranged in a single row, and if `VERTICAL` is passed,
the children will be arranged in a single column. `spacing` is the number of
pixels to place by default between children.

The instance methods `pack_start()` and `pack_end()` are used to place child
objects inside the `Gtk.Box` containers.

    /* When we call box.pack_end(...) we add child to
       box, packed with reference to the end of box. */
    public void pack_end (Gtk.Widget child, bool expand = true, bool fill = true, uint padding = 0);

    /* When we call box.pack_start(...) it adds child to box,
       packed with reference to the beginning of box. */
    public void pack_start (Gtk.Widget child, bool expand = true, bool fill = true, uint padding = 0);

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

    box.pack_start(child);

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

<div class="accordion" id="PackingDemo">
  <div class="accordion-group">
    <div class="accordion-heading">
      <a class="accordion-toggle" data-toggle="collapse" data-parent="PackingDemo" href="#PackingGist">View Code</a>
    </div>
    <div id="PackingGist" class="accordion-body collapse">
      <div class="accordion-inner">
        <script src="https://gist.github.com/abenga/6391233.js"></script>
      </div>
    </div>
  </div>
</div>

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

    var grid = Gtk.Grid();

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

    public void attach(Gtk.Widget child, int left, int top, int width, int height);

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

    public void attach_next_to (Widget child, Widget? sibling, PositionType side, int width, int height)

adds the widget `child` next to the widget `sibling`, on the side defined by
`side`, which is an instance of `Gtk.PositionType`, which an enumeration that \
takes one of the values: `Gtk.PositionType.LEFT` (adds `child` on the left edge
of `sibling`), `Gtk.PositionType.RIGHT`, `Gtk.PositionType.TOP`, and
`Gtk.PositionType.BOTTOM`.

We can set spacing between the rows and columns of the grid (in pixels) using
the following methods:

    grid.set_row_spacing (int spacing)

    grid.set_col_spacing (uint spacing)

Note that for columns, the space goes to the right of the column, and for rows,
the space goes below the row.

## Example

In the example below, we will make a window with seven buttons in a grid, showing
the various ways you can position child elements in a grid.

    class GridExample : Gtk.Window {

      /** private Gtk.Window window;*/

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

When compiled and run, it looks something like this:

<figure>
  <img src="https://lh6.googleusercontent.com/-HFq2_JMwuyM/UiIzA7LGNUI/AAAAAAAAAGU/I-qy2nsolvw/w354-h294-no/02Grid.png" alt="Grid Packing Example Image" title="Grid Packing Example">
  <figcaption>Grid Packing Example</figcaption>
</figure>


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
