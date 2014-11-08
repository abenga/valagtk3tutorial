/** chapter-05-packing-widgets/code/02Grid.vala */

class GridExample : Gtk.Window {

  /** private Gtk.Window window;*/

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

  public GridExample () {
    /* Create a new window. */
    this.window = new Gtk.Window(Gtk.WindowType.TOPLEVEL);

    /* Set the window title. */
    this.window.set_title("Grid Packing Example");

    /* Set a handler for delete_event that immediately
     *exits Gtk. */
    this.window.delete_event.connect(this.delete_event);

    /* Sets the border width of the window. */
    this.window.set_border_width(20);

    /* Create a 2x2 table. */
    var grid = new Gtk.Grid();

    /* Put the table in the main window. */
    this.window.add(grid);

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
    this.window.show();
  }

  public static int main(string[] args) {

    Gtk.init(ref args);

    new GridExample();

    Gtk.main();

    return 0;
  }

}
