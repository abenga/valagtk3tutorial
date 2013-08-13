
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
