/*
 * Copyright (C) Horace Abenga
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 2 of the License, or (at your option) any later
 * version. See http://www.gnu.org/copyleft/gpl.html the full text of the
 * license.
 */

/* Create a new box with an image and a label packed into it
 * and return the box. */
static Gtk.Box xpm_label_box(string xpm_filename, 
                              string label_text ) {
  Gtk.Box box;
  Gtk.Label label;
  Gtk.Image image;

  /* Create box for image and label */
  box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
  box.set_border_width(2);

  /* Now on to the image stuff */
  image = new Gtk.Image.from_file(xpm_filename);

  /* Create a label for the button */
  label = new Gtk.Label(label_text);

  /* Pack the image and label into the box */
  box.pack_start(image, false, false, 3);
  box.pack_start(label, false, false, 3);

  image.show();
  label.show();

  return box;
}

class ButtonWindow : Gtk.Window {
  
  Gtk.Button button;
  Gtk.Box box;

  /* Our usual callback function */
  void callback (string data) {
    stdout.printf("Hello again - %s was pressed\n", data);
  }

  public ButtonWindow () {

    this.set_title("Pixmap'd Buttons!");

    /* It's a good idea to do this for all windows. */
    this.destroy.connect( ()=> { Gtk.main_quit(); } );

    this.delete_event.connect( ()=> { return false; } );

    /* Sets the border width of the window. */
    this.set_border_width(10);

    /* Create a new button. */
    this.button = new Gtk.Button();

    /* Connect the "clicked" signal of the button to our callback. */
    this.button.clicked.connect( ()=> { this.callback("cool button"); });

    /* This calls our box creating function. */
    this.box = xpm_label_box("img.png", "cool button");

    /* Pack and show all our widgets. */
    this.box.show();

    this.button.add(box);

    this.button.show();

    this.add(button);

  }
  
  public static int main (string[] args) {
    
    Gtk.init(ref args);

    var buttonwindow = new ButtonWindow();
    buttonwindow.show();
    
    Gtk.main();
    
    return 0;
  }

}
