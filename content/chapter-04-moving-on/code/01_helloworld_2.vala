
using Gtk;

class HelloWorld2 {
  
  private Gtk.Window window;
  private Gtk.Button button1;
  private Gtk.Button button2;
  private Gtk.Box box;
  
  /* Our new improved callback.  The data passed to this function
   * is printed to stdout. */
  void callback(string data) {
    stdout.printf("Hello! - %s was pressed\n", data);
  }

  /* another callback */
  static bool delete_event() {
    Gtk.main_quit();
    return false;
  }
  
  public HelloWorld2 () {
    

    /* Create a new window */
    this.window = new Gtk.Window();

    /* This is a new call, which just sets the title of our
     * new window to "Hello Buttons!" */
    this.window.set_title("Hello Buttons!");

    /* Here we just set a handler for delete_event that immediately
     * exits GTK. */
    this.window.delete_event.connect(this.delete_event);

    /* Sets the border width of the window. */
    this.window.set_border_width(10);

    /* We create a box to pack widgets into.  This is described 
     * in detail in the "packing" section. The box is not really 
     * visible, it is just used as a tool to arrange widgets. */
    box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);

    /* Put the box into the main window. */
    this.window.add(box);

    /* Creates a new button with the label "Button 1". */
    this.button1 = new Gtk.Button.with_label("Button 1");
    
    /* Now when the button is clicked, we call the "callback" function
     * with a pointer to "button 1" as its argument */
    this.button1.clicked.connect (() => { this.callback("Button 1"); });  

    /* Instead of gtk_container_add, we pack this button into the 
     * invisible box, which has been packed into the window. */
    box.pack_start(button1, true, true, 0);

    /* Always remember this step, this tells GTK that our preparation 
     * for this button is complete, and it can now be displayed. */
    button1.show();

    /* Do these same steps again to create a second button */
    this.button2 = new Gtk.Button.with_label("Button 2");

    /* Call the same callback function with a different argument,
       passing a pointer to "button 2" instead. */
    this.button2.clicked.connect (() => { this.callback("Button 2"); }); 

    box.pack_start(button2, true, true, 0);

    /* The order in which we show the buttons is not really important, 
     * but we recommend showing the window last, so it all pops up at 
     * once. */
    button2.show();

    box.show();

    window.show();
    
  }
  
  public static int main (string[] args) {
    /* This is called in all GTK applications. Arguments are parsed
     * from the command line and are returned to the application. */
    Gtk.init (ref args);
    
    var hello = new HelloWorld2();
    
    /* Rest in gtk_main and wait for the fun to begin! */
    Gtk.main();
    
    return 0;
  }  
}
