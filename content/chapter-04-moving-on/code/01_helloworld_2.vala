/*
 * Copyright (C) Horace Abenga
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 2 of the License, or (at your option) any later
 * version. See http://www.gnu.org/copyleft/gpl.html the full text of the
 * license.
 */

class HelloWorld : Gtk.Window {
  
  private Gtk.Button button1;
  private Gtk.Button button2;
  private Gtk.Box box;
  
  /* Our new improved callback.  The data passed to this function
   * is printed to stdout. */
  void callback(string data) {
    stdout.printf("Hello! - %s was pressed\n", data);
  }

  /* another callback */
  static bool on_delete_event() {
    Gtk.main_quit();
    return false;
  }
  
  public HelloWorld () {
    

    /* This is a new call, which just sets the title of our
     * new window to "Hello Buttons!" */
    this.set_title("Hello Buttons!");

    /* Here we just set a handler for delete_event that immediately
     * exits GTK. */
    this.delete_event.connect(this.delete_event);

    /* Sets the border width of the window. */
    this.set_border_width(10);

    /* We create a box to pack widgets into.  This is described 
     * in detail in the "packing" section. The box is not really 
     * visible, it is just used as a tool to arrange widgets. */
    box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);

    /* Put the box into the main window. */
    this.add(box);

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
    
    var hello = new HelloWorld();
    
    /* Rest in gtk_main and wait for the fun to begin! */
    Gtk.main();
    
    return 0;
  }  
}
