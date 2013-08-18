/** Example chapter-04/01Packbox.vala */

using Gtk;

/*
 * Helper function that makes a new hbox filled with button-labels. Arguments
 * for the variables we're interested are passed in to this function.  We do
 * not show the box, but do show everything inside.
 */
static Gtk.HBox make_box (bool homogeneous, int spacing, bool expand, bool fill, int padding) {
  Gtk.HBox box;
  Gtk.Button button;
  string padstr;
    
  /* Create a new hbox with the appropriate homogeneous
   * and spacing settings */
  box = new Gtk.HBox(homogeneous, spacing);
  
  /* Create a series of buttons with the appropriate settings */
  button = new Gtk.Button.with_label("gtk_box_pack");
  box.pack_start(button, expand, fill, padding);
  button.show();
  
  button = new Gtk.Button.with_label ("(box,");
  box.pack_start(button, expand, fill, padding);
  button.show();
  
  button = new Gtk.Button.with_label("button,");
  box.pack_start(button, expand, fill, padding);
  button.show();
  
  /* Create a button with the label depending on the value of
   * expand. */
  if (expand == true)
	  button = new Gtk.Button.with_label("TRUE,");
  else
	  button = new Gtk.Button.with_label("FALSE,");
  
  box.pack_start(button, expand, fill, padding);
  button.show();
  
  /* This is the same as the button creation for "expand"
   * above, but uses the shorthand form. */
  button = new Gtk.Button.with_label(fill ? "TRUE," : "FALSE,");
  box.pack_start (button, expand, fill, padding);
  button.show();
  
  padstr = "$padding);";
  
  button = new Gtk.Button.with_label(padstr);
  box.pack_start(button, expand, fill, padding);
  button.show();
  
  return box;
}

class PackBox1 {
  
  public Gtk.Window window;
  
  public bool delete_event () {
    Gtk.main_quit();
    return false;
  }
  
  public PackBox1 (int which) {
    
    /* Create our window. */
    this.window = new Gtk.Window(Gtk.WindowType.TOPLEVEL);
    
    /* You should always remember to connect the delete_event signal
     * to the main window. This is very important for proper intuitive
     * behavior */
    
    this.window.delete_event.connect(this.delete_event);
    this.window.set_border_width(10);
    
    /* We create a vertical box (vbox) to pack the horizontal boxes into.
     * This allows us to stack the horizontal boxes filled with buttons one
     * on top of the other in this vbox. */
    var box1 = new Gtk.VBox(false, 0);
    
    /* Which example to show. These correspond to the pictures above. */
    switch (which) {
      case 1:
        /* create a new label. */
        var label = new Gtk.Label("HBox(false, 0)");
    
        /* Align the label to the left side.  We'll discuss this method
         * and others in the section on Widget Attributes. */
        label.set_alignment(0, 0);

        /* Pack the label into the vertical box (vbox box1).  Remember that 
         * widgets added to a vbox will be packed one on top of the other in
         *  order. */
        box1.pack_start(label, false, false, 0);
    
        /* Show the label. */ 
        label.show();
    
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
        var separator = new Gtk.HSeparator();
    
        /* Pack the separator into the vbox. Remember each of these
         * widgets is being packed into a vbox, so they'll be stacked
         * vertically. */
        box1.pack_start(separator, false, true, 5);
        separator.show();
    
        /* Create another new label, and show it. */
        label = new Gtk.Label("HBox(true, 0)");
        label.set_alignment(0, 0);
        box1.pack_start(label, false, false, 0);
        label.show();
    
        /* Args are: homogeneous, spacing, expand, fill, padding */
        box2 = make_box(true, 0, true, false, 0);
        box1.pack_start(box2, false, false, 0);
        box2.show();
    
        /* Args are: homogeneous, spacing, expand, fill, padding */
        box2 = make_box(true, 0, true, true, 0);
        box1.pack_start(box2, false, false, 0);
        box2.show();
    
        /* Another new separator. */
        separator = new Gtk.HSeparator();
        /* The last 3 arguments to pack_start are:
         * expand, fill, padding. */
        box1.pack_start(separator, false, true, 5);
        separator.show();
        break;
      case 2:
        /* Create a new label, remember box1 is a vbox as created 
         * near the beginning of the constructor. */
        var label = new Gtk.Label("HBox(false, 10)");
        label.set_alignment( 0, 0);
        box1.pack_start(label, false, false, 0);
        label.show();
    
        /* Args are: homogeneous, spacing, expand, fill, padding. */
        var box2 = make_box(false, 10, true, false, 0);
        box1.pack_start(box2, false, false, 0);
        box2.show();
    
        /* Args are: homogeneous, spacing, expand, fill, padding */
        box2 = make_box(false, 10, true, true, 0);
        box1.pack_start(box2, false, false, 0);
        box2.show();
    
        var separator = new Gtk.HSeparator();
        /* The last 3 arguments to pack_start are:
         * expand, fill, padding. */
        box1.pack_start(separator, false, true, 5);
        separator.show();
    
        label = new Gtk.Label("HBox(false, 0)");
        label.set_alignment(0, 0);
        box1.pack_start(label, false, false, 0);
        label.show();
    
        /* Args are: homogeneous, spacing, expand, fill, padding. */
        box2 = make_box(false, 0, true, false, 10);
        box1.pack_start(box2, false, false, 0);
        box2.show();
    
        /* Args are: homogeneous, spacing, expand, fill, padding. */
        box2 = make_box(false, 0, true, true, 10);
        box1.pack_start(box2, false, false, 0);
        box2.show();
    
        separator = new Gtk.HSeparator();
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
        var separator = new Gtk.HSeparator();
        
        /* This explicitly sets the separator to 400 pixels wide by 5
         * pixels high. This is so the hbox we created will also be 400
         * pixels wide, and the "end" label will be separated from the
         * other labels in the hbox. Otherwise, all the widgets in the
         * hbox would be packed as close together as possible.
         * separator.set_size_request(400, 5)
         * pack the separator into the vbox (box1) created near the start 
         * of the constructor. */ 
        box1.pack_start(separator, false, true, 5);
        separator.show();
        break;
    }
    
    /* Create another new hbox.. remember we can use as many as we need! */
    var quitbox = new Gtk.HBox(false, 0);
  
    /* Our quit button. */
    var button = new Gtk.Button.with_label("Quit");
  
    /* Setup the signal to terminate the program when the button is clicked */
    button.clicked.connect( () => { Gtk.main_quit(); } );
    /* Pack the button into the quitbox.
     * The last 3 arguments to pack_start are:
     * expand, fill, padding. */
    quitbox.pack_start(button, true, false, 0);
    /* pack the quitbox into the vbox (box1) */
    box1.pack_start(quitbox, false, false, 0);
  
    /* Pack the vbox (box1) which now contains all our widgets, into the
     * main window. */
    this.window.add(box1);
  
    /* And show everything left */
    button.show();
    quitbox.show();
    box1.show();
    
    /* Showing the window last so everything pops up at once. */
    this.window.show();
  }
  
  
  public static int main (string[] args) {
    
    if (args.length == 2) {
      
      Gtk.init(ref args);
      new PackBox1(int.parse(args[1]));
      
      /* And of course, our mainloop. */
      Gtk.main();
      
      /* Control returns here when Gtk.main_quit() is called. */
      return 0;
      
    } else {
      return 1;
    }
    
  }

}
