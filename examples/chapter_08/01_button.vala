
/* Create a new hbox with an image and a label packed into it
 * and return the box. */
static Gtk.Box xpm_label_box(string xpm_filename, 
                              string label_text ) {
  
  /* Create box for image and label */
  var box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
  box.set_homogeneous(false);
  box.set_border_width(2);

  /* Now on to the image stuff */
  var image = new Gtk.Image.from_file(xpm_filename);

  /* Create a label for the button */
  var label = new Gtk.Label(label_text);

  /* Pack the image and label into the box */
  box.pack_start(image, false, false, 3);
  box.pack_start(label, false, false, 3);

  image.show();
  label.show();

  return box;
}

class ButtonWindow {
  
  Gtk.Window window;
  Gtk.Button button;
  Gtk.Box box;

  /* Our usual callback function */
  void callback (string data) {
    stdout.printf("Hello again - %s was pressed\n", data);
  }

  public ButtonWindow () {

    /* Create a new window. */
    this.window = new Gtk.Window(Gtk.WindowType.TOPLEVEL);

    this.window.set_title("Pixmap'd Buttons!");

    /* It's a good idea to do this for all windows. */
    this.window.destroy.connect( ()=> { Gtk.main_quit(); } );

    this.window.delete_event.connect( ()=> { return false; } );

    /* Sets the border width of the window. */
    this.window.set_border_width(10);

    /* Create a new button. */
    this.button = new Gtk.Button();

    /* Connect the "clicked" signal of the button to our callback. */
    this.button.clicked.connect( ()=> { this.callback("cool button"); });

    /* This calls our box creating function. */
    this.box = xpm_label_box("icon.png", "cool button");

    /* Pack and show all our widgets. */
    this.box.show();

    this.button.add(box);

    this.button.show();

    this.window.add(button);

    this.window.show();
    
  }
  
  public static int main (string[] args) {
    
    Gtk.init(ref args);
    new ButtonWindow();
    
    /* Rest in gtk_main and wait for the fun to begin! */
    Gtk.main ();
    
    return 0;
  }

}
