/*
 * Copyright (C) Horace Abenga
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 2 of the License, or (at your option) any later
 * version. See http://www.gnu.org/copyleft/gpl.html the full text of the
 * license.
 */

int main(string[] args) {
  
  Gtk.init (ref args);
  
  Gtk.Window window = new Window();
  window.show_all();
  
  Gtk.main ();
  
  return 0;
  
}
