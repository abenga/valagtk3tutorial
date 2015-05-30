# Numeric and Text Data Entry


## Gtk.Entry

The `Gtk.Entry` widget is a widget that allows the user to enter text.  If the 
entered text is longer than the allocation of the widget, the widget will scroll 
so that the cursor position is visible. 

When a `Gtk.Entry` is used for passwords or other sensitive information, the 
characters typed may be hidden from third  parties by calling 
`Gtk.Entry.set_visibility(false)`. 

`Gtk.Entry.set_invisible_char(unichar ch)` sets the character (supplied as the
argument `ch`) to use in place of the actual text typed by the user after 
calling `Gtk.Entry.set_visibility(false)` as above. This is the character used 
in "password mode" to show the user how many characters have been typed. By 
default, GTK+ picks the best invisible char available in the current font. If 
you set the invisible char to `0`, then the user will get no feedback at all; 
there will be no text on the screen as they type.

You can set the contents using the `Gtk.Entry.set_text(string text)` method, 
replacing the current contents with the string `text` supplied as the argument 
to the method. You can also read the current contents with the `Gtk.Entry.get_text()` 
method. 

The number of characters the entry can take may be limited by calling 
`Gtk.Entry.set_max_length(int max)`. If contents of the entry upon calling this 
method are longer than `max`, they will be truncated to fit.

You can also set the alignment for the contents of the entry, controlling the 
horizontal positioning of the contents when the displayed text is shorter than 
the width of the entry. This is done by calling `Gtk.Entry.set_alignment(float xalign)`.
The alignment parameter takes one of a range of values from `0` (left) to `1` 
(right).

Placeholder text (text displayed in the entry when it is empty and unfocused) 
may be set using `Gtk.Entry.set_placeholder_text()`. This can be used to give a 
visual hint of the expected contents of the entry. Note that since this 
placeholder text gets removed when the entry receives focus, using this feature 
is a bit problematic if the entry is given the initial focus in a window. 
Sometimes this can be worked around by delaying the initial focus setting until 
the first key event arrives.

Additionally, a `Gtk.Entry` can show icons at either side of the entry. These 
icons can be activatable by clicking, can be set up as drag source and can have 
tooltips. To add an icon, use `Gtk.Entry.set_icon_from_stock()` or one of the
various other functions that set an icon from an icon name, or a pixbuf. To set 
a tooltip on an icon, use `Gtk.Entry.set_icon_tooltip_text()`.

The following example demonstrates some of these concepts in action:
    
<pre><code class="vala">public class Application : Gtk.Window {

  public Application () {
    // Prepare Gtk.Window:
    this.title = "Text Entry";
    this.window_position = Gtk.WindowPosition.CENTER;
    this.destroy.connect (Gtk.main_quit);
    this.set_default_size (350, 70);
    this.set_border_width(10);

    // The Entry:
    Gtk.Entry entry = new Gtk.Entry ();
    this.add (entry);

    // Add a default-text:
    entry.set_text ("Hello, world!");

    // Add a delete-button:
    entry.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear");
    entry.icon_press.connect ((pos, event) => {
      if (pos == Gtk.EntryIconPosition.SECONDARY) {
        entry.set_text ("");
      }
    });

    // Print text to stdout on enter:
    entry.activate.connect (() => {
      unowned string str = entry.get_text ();
      stdout.printf ("%s\n", str);
    });
  }

  public static int main (string[] args) {
    Gtk.init (ref args);

    Application app = new Application ();
    app.show_all ();
    Gtk.main ();
    return 0;
  }
}
</code></pre>

The code creates a window with a single text entry, as in the image below:

<figure>
  <img src="https://lh3.googleusercontent.com/7k8_GhR0RdwlTONdK8FruIp0f6K91tTr8Px30eQxpHg=w477-h220-no" alt="Text Entry" title="Text Entry">
  <figcaption>Text Entry</figcaption>
</figure>


## SpinButton

A `Gtk.SpinButton` is an ideal way to allow the user to set the numeric value of 
some attribute. Rather than having to directly type a number into a `Gtk.Entry`, 
the `Gtk.SpinButton` allows the user to click on one of two arrows to increment 
or decrement the displayed value. A value can still be manually typed in, in 
which case it can be checked to ensure it is in a given range. The main 
properties of a `Gtk.SpinButton` are achieved through an associated *adjustment*.

The basic constructor for a SpinButton is

<pre><code class="vala">Gtk.SpinButton (Gtk.Adjustment adjustment, double climb_rate, uint digits);</code></pre>

The `adjustment` argument is an instance of `Gtk.Adjustment` object, which 
represents a value which has an associated lower and upper bound, together with 
step and page increments, and a page size. The `Gtk.Adjustment` object does not 
update the value itself. Instead it is left up to the owner of the `Adjustment` 
to control the value.

The constructor for a `Gtk.Adjustment` is

<pre><code class="vala">Gtk.Adjustment (double value,           // The initial value of the adjustment
                double lower,           // The minimum value of the adjustment
                double upper,           // The maximum value of the adjustment
                double step_increment,  // The step increment
                double page_increment,  // The page increment
                double page_size        // The page size. Irrelevant, and should be set to 0
                                        // if the adjustment is used for a simple scalar
                                        // value, e.g. in a SpinButton.
                );
</code></pre>

The owner of the `Gtk.Adjustment` typically calls the `value_changed` function 
after changing the value of the adjustment, causing the `value_changed` signal 
to be emitted. The owner may also call the `changed` function after changing one
or more of the `Adjustment`'s properties other than the value. This results in 
the emission of the `changed` signal.

The following example creates a `Gtk.SpinButton`, along with the associated
`Gtk.Adjustment`, and outputs the values as they are changed to stdout.

<pre><code class="vala">public class Application : Gtk.Window {

  public Application () {
    // Prepare Gtk.Window:
    this.title = "Text Entry";
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
</code></pre>

It should yield a window similar to the following:

<figure>
  <img src="https://lh4.googleusercontent.com/-fO5WqeBhR-Y/VGzJhhVMidI/AAAAAAAAALg/2Eu-WANCR9s/w453-h190-no/02SpinButton.png" alt="Spin Button" title="Spin Button">
  <figcaption>Spin Button</figcaption>
</figure>

It is not necessary to manually create the associated `Adjustment`. for the 
spin button. The alternative constructor

<pre><code class="vala">SpinButton.with_range (double min, double max, double step)</code></pre>

allows creation of a numeric `Gtk.SpinButton` without manually creating an 
adjustment. The value is initially set to the `minimum` value and a page 
increment of `10 * step` is the default.

In the example above, we'd replace the lines creating the adjustment and button
with the lines

<pre><code class="vala">Gtk.SpinButton button = new Gtk.SpinButton.with_range(0, 16, 1);
this.add(button);
</code></pre>

to the same effect.


## Sources and Further Reading

* The `GtkEntry` Section of the GTK 3 Reference Manual. [Online] Available from:
  [https://developer.gnome.org/gtk3/stable/GtkEntry.html](https://developer.gnome.org/gtk3/stable/GtkEntry.html)
  [Accessed 19&nbsp;November&nbsp;2014]

* The `GtkSpinButton` Section of the GTK 3 Reference Manual. [Online] Available from:
  [https://developer.gnome.org/gtk3/stable/GtkSpinButton.html](https://developer.gnome.org/gtk3/stable/GtkSpinButton.html)
  [Accessed 19&nbsp;November&nbsp;2014]

* Documentation on Gtk.Entry in Valadoc [Online] Available from:
  [http://valadoc.org/#!api=gtk+-3.0/Gtk.Entry](http://valadoc.org/#!api=gtk+-3.0/Gtk.Entry)
  [Accessed 19&nbsp;September&nbsp;2014]