
public class Application : Gtk.Window {

  public Application () {
    // Prepare Gtk.Window:
    this.title = "Spin Button";
    this.window_position = Gtk.WindowPosition.CENTER;
    this.destroy.connect (Gtk.main_quit);
    this.set_default_size (350, 70);
    this.set_border_width(10);

    // Create the Adjustment and SpinButton.
    Gtk.Adjustment adj = new Gtk.Adjustment(0, 0, 16, 1, 1, 1);
    Gtk.SpinButton button = new Gtk.SpinButton(adj, 1, 0);
    button.set_range(0, 16);
    this.add(button);

    button.value_changed.connect (() => {
      int val = button.get_value_as_int ();
      stdout.printf ("%d\n", val);
    });
    
  }

  public static int main (string[] args) {
    Gtk.init(ref args);

    Application app = new Application();
    app.show_all();
    Gtk.main();
    return 0;
  }

}