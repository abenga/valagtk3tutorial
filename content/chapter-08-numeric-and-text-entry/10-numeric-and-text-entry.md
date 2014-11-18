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



The code creates a window with a single text entry, as in the image below:



<figure>
  <img src="https://lh3.googleusercontent.com/7k8_GhR0RdwlTONdK8FruIp0f6K91tTr8Px30eQxpHg=w477-h220-no" alt="Text Entry" title="Text Entry">
  <figcaption>Text Entry</figcaption>
</figure>

## Sources and Further Reading

https://developer.gnome.org/gtk3/stable/GtkEntry.html

