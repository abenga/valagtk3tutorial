
using Gtk;

class HelloWorld {
  
  private Gtk.Window window;
  private Gtk.Button button;

  /* This is a callback function. It takes no arguments in 
   * this example. We will learn more about callbacks later. */
  public void hello () {
    stdout.printf("Hello World\n");
  }
  
  /* If you return FALSE in the "delete_event" signal handler, GTK will 
   * emit the "destroy" signal. Returning TRUE means you don’t want the 
   * window to be destroyed. This is useful for popping up ’are you sure 
   * you want to quit?’ type dialogs. 
   * 
   * If you change "return true;" to "return false" the main window will 
   * be destroyed with a "delete_event".*/
  public bool delete_event () {
    stdout.printf("delete event occurred\n");
    return true;
  }
  
  /* Another callback. */
  public void destroy() {
    Gtk.main_quit();
  }  
  
  public HelloWorld () {
    
    /* Create a new window */    
    this.window = new Gtk.Window(); 
    
    /* When the window is given the "delete_event" signal (this is given 
     * by the window manager, usually by the "close" option, or on the 
     * titlebar), we ask it to call the delete_event () function as 
     * defined above. The data passed to the callback function is NULL 
     * and is ignored in the callback function. */    
    this.window.delete_event.connect(this.delete_event);

    /* Here we connect the "destroy" event to a signal handler.
     * This event occurs when we call gtk_widget_destroy() on the window,
     * or if we return false in the "delete_event" callback. */    
    this.window.destroy.connect(this.destroy);
    
    /* Sets the border width of the window. */    
    this.window.set_border_width(10);
    
    /* Creates a new button with the label "Hello World". */    
    this.button = new Gtk.Button.with_label("Hello World");
    
    /* When the button receives the "clicked" signal, it will call the
     * function hello() passing it None as its argument.  The hello()
     * function is defined above. */    
    this.button.clicked.connect(this.hello);
    
    /* This will cause the window to be destroyed by calling
     * Gtk.Widget.destroy(window) when "clicked".  Again, the destroy
     * signal could come from here, or the window manager. */    
    GLib.Signal.connect_swapped(this.button, "clicked", 
                                (GLib.Callback) destroy, this.window);
    
    /* This packs the button into the window (a GTK container). */    
    this.window.add(this.button);
    
    /* The final step is to display this newly created widget. */    
    this.button.show();
    
    /* and the window */    
    this.window.show();
  }
  
  public static int main(string[] args){
    Gtk.init(ref args);
    
    var hello = new HelloWorld();
    
    /* All Vala GTK applications must have a Gtk.main(). Control 
     * ends here and waits for an event to occur (like a key press 
     * or mouse event). */
    Gtk.main();
    
    return 0;
  }
  
}
