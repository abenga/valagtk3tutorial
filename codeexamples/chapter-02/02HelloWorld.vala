
using Gtk;

class HelloWorld {
  
  /* This is a callback function. The data arguments are ignored
     in this example. More on callbacks below. */
  public void hello () {
    stdout.printf("Hello World\n");
  }
  
  
  public bool delete_event () {
    /* If you return FALSE in the "delete_event" signal handler,
       GTK will emit the "destroy" signal. Returning TRUE means
       you don’t want the window to be destroyed.
       This is useful for popping up ’are you sure you want to quit?’
       type dialogs. */
    stdout.printf("delete event occurred\n");
    /* Change true to false and the main window will be destroyed with
       a "delete_event". */
    return false;
  }
  
  /* Another callback. */
  public void destroy() {
   Gtk.main_quit();
  }
  
  
  public HelloWorld () {
    /* create a new window */
    Gtk.Window window = new Gtk.Window(); 
    
    /* When the window is given the "delete_event" signal (this is given 
       by the window manager, usually by the "close" option, or on the 
       titlebar), we ask it to call the delete_event () function as 
       defined above. The data passed to the callback function is NULL 
       and is ignored in the callback function. */
    window.delete_event.connect(this.delete_event);
    /* Here we connect the "destroy" event to a signal handler.
       This event occurs when we call gtk_widget_destroy() on the window,
       or if we return FALSE in the "delete_event" callback. */
    window.destroy.connect(this.destroy);
    /* Sets the border width of the window. */
    window.set_border_width(10);
    
    /* Creates a new button with the label "Hello World". */
    Gtk.Button button = new Gtk.Button.with_label("Hello World");
    /* When the button receives the "clicked" signal, it will call the
       function hello() passing it None as its argument.  The hello()
       function is defined above. */
    button.clicked.connect(this.hello);
    /* This packs the button into the window (a GTK container). */
    window.add(button);
    /* The final step is to display this newly created widget. */
    button.show();
    /* and the window */
    window.show();
  }
  
  public static int main(string[] args){
    Gtk.init(ref args);
    
    var helloWorld = new HelloWorld();
    /* All Vala GTK applications must have a Gtk.main(). Control ends here
       and waits for an event to occur (like a key press or mouse event). */
    Gtk.main();
    
    /* User leaves. */
    return 0;
  }
  
}
