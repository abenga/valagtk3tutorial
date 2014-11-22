
class StackExample : Gtk.Window {

  public StackExample () {    
    
    this.set_title("Stack and StackSwitcher Demo");
    this.window_position = Gtk.WindowPosition.CENTER;
    this.set_default_size(350, 70);
    this.set_border_width(10);
    this.destroy.connect(Gtk.main_quit);

    var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 5);
    this.add(box);

    var stack = new Gtk.Stack();
    stack.set_transition_type(Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
    stack.set_transition_duration(1000);
    
    var label1 = new Gtk.Label("Page 1 Content.");
    stack.add_titled(label1, "page-1", "Page 1");
    
    var label2 = new Gtk.Label("Page 2 Content.");
    stack.add_titled(label2, "page-2", "Page 2");

    var label3 = new Gtk.Label("Page 3 Content.");
    stack.add_titled(label3, "page-3", "Page 3");


    var switcher = new Gtk.StackSwitcher();
    switcher.set_stack(stack);
    box.pack_start(switcher, true, true, 0);
    box.pack_start(stack, true, true, 0);
 
  }

  public static int main (string[] args) {
    
    Gtk.init(ref args);
    
    var win = new StackExample();
    win.show_all();

    Gtk.main();
    
    return 0;
  }

}