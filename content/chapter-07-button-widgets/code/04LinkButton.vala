
public class Application : Gtk.Window {
  
  public Application () {
    // Prepare Gtk.Window:
    this.title = "My Gtk.LinkButton";
    this.window_position = Gtk.WindowPosition.CENTER;
    this.destroy.connect (Gtk.main_quit);
    this.set_default_size (350, 70);

    // The button:
    Gtk.LinkButton button = new Gtk.LinkButton.with_label ("https://developer.gnome.org/gtk3/stable/index.html", "GTK+ 3 Reference Manual");
    this.add (button);
  }

  public static int main (string[] args) {
    Gtk.init (ref args);

    Application app = new Application ();
    app.show_all ();
    Gtk.main ();
    return 0;
  }
  
}