
public class Application : Gtk.Window {

  private void toggled (Gtk.ToggleButton button) {
    stdout.printf("%s: %s\n", button.label, button.active ? "true" : "false");
  }

  public Application () {
    
    // Set Window Attributes
    this.title = "Toggle Buttons";
    this.window_position = Gtk.WindowPosition.CENTER;
    this.destroy.connect(Gtk.main_quit);
    this.set_default_size(350, 70);
    this.set_border_width(10);

    // Create a VBox to pack the radio buttons in.
    Gtk.Box box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
    this.add (box);

    // The buttons:
    Gtk.ToggleButton button1 = new Gtk.ToggleButton.with_label("Button 1");
    box.pack_start (button1, false, false, 0);
    button1.toggled.connect(toggled);

    Gtk.ToggleButton button2 = new Gtk.ToggleButton.with_label("Button 2");
    box.pack_start (button2, false, false, 0);
    button2.toggled.connect(toggled);

  }

  public static int main (string[] args) {
    Gtk.init(ref args);

    Application app = new Application();
    app.show_all();
    Gtk.main();
    return 0;
  }

}