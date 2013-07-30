
/* examples/chapter_02/01_simplewindow.vala */

int main(string[] args) {
  
  Gtk.init (ref args);
  
  Gtk.Window window = new Window();
  window.show_all();
  
  Gtk.main();
  
  return 0;
  
}
