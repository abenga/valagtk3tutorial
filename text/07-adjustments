Adjustments

/* Code snippets here need quite some work. */

GTK has various widgets that can be visually adjusted by the user using the 
mouse or the keyboard, such as the range widgets, described in the 
[LINK]Range Widgets[/LINK] section. There are also a few widgets that display 
some adjustable portion of a larger area of data, such as the text widget and 
the viewport widget.

Obviously, an application needs to be able to react to changes the user makes 
in range widgets. One way to do this would be to have each widget emit its own 
type of signal when its adjustment changes, and either pass the new value to 
the signal handler, or require it to look inside the widget's data structure in 
order to ascertain the value. But you may also want to connect the adjustments 
of several widgets together, so that adjusting one adjusts the others. The most 
obvious example of this is connecting a scrollbar to a panning viewport or a 
scrolling text area. If each widget has its own way of setting or getting the 
adjustment value, then the programmer may have to write their own signal 
handlers to translate between the output of one widget's signal and the "input" 
of another's adjustment setting method.

GTK solves this problem using the Adjustment object, which is not a widget but 
a way for widgets to store and pass adjustment information in an abstract and 
flexible form. The most obvious use of Adjustment is to store the configuration 
parameters and values of range widgets, such as scrollbars and scale controls. 
However, since Adjustments are derived from Object, they have some special 
powers beyond those of normal data structures. Most importantly, they can emit 
signals, just like widgets, and these signals can be used not only to allow your 
program to react to user input on adjustable widgets, but also to propagate 
adjustment values transparently between adjustable widgets.

You will see how adjustments fit in when you see the other widgets that 
incorporate them: Progress Bars, Viewports, Scrolled Windows, and others.




Creating an Adjustment

Many of the widgets which use adjustment objects do so automatically, but some 
cases will be shown in later examples where you may need to create one yourself. 
You create an adjustment using:

[CODE]
  adjustment = new Gtk.Adjustment (double value, double lower, double upper, 
                                   double step_increment, double page_increment, 
                                   double page_size);
[/CODE]

The [CODE]value[/CODE] argument is the initial value you want to give to the 
adjustment, usually corresponding to the topmost or leftmost position of an 
adjustable widget. The [CODE]lower[/CODE] argument specifies the lowest value 
which the adjustment can hold. The [CODE]step_increment[/CODE] argument 
specifies the "smaller" of the two increments by which the user can change the 
value, while the [CODE]page_increment[/CODE] is the "larger" one. The 
[CODE]page_size[/CODE] argument usually corresponds somehow to the visible area 
of a panning widget. The upper argument is used to represent the bottom most or 
right most coordinate in a panning widget's child. Therefore it is not always 
the largest number that value can take, since the [CODE]page_size[/CODE] of such 
widgets is usually non-zero.




Using Adjustments the Easy Way

The adjustable widgets can be roughly divided into those which use and require 
specific units for these values, and those which treat them as arbitrary 
numbers. The group which treats the values as arbitrary numbers includes the 
range widgets (scrollbars and scales, the progress bar widget, and the spin 
button widget). These widgets are all the widgets which are typically "adjusted" 
directly by the user with the mouse or keyboard. They will treat the lower and 
upper values of an adjustment as a range within which the user can manipulate 
the adjustment's value. By default, they will only modify the value of an 
adjustment.

The other group includes the text widget, the viewport widget, the compound 
list widget, and the scrolled window widget. All of these widgets use pixel 
values for their adjustments. These are also all widgets which are typically 
"adjusted" indirectly using scrollbars. While all widgets which use adjustments 
can either create their own adjustments or use ones you supply, you'll generally 
want to let this particular category of widgets create its own adjustments. 
Usually, they will eventually override all the values except the value itself 
in whatever adjustments you give them, but the results are, in general, 
undefined (meaning, you'll have to read the source code to find out, and it may 
be different from widget to widget).

Now, you're probably thinking, since text widgets and viewports insist on 
setting everything except the value of their adjustments, while scrollbars will 
only touch the adjustment's value, if you share an adjustment object between a 
scrollbar and a text widget, manipulating the scrollbar will automagically 
adjust the text widget? Of course it will! Just like this:

[CODE]
  /* creates its own adjustments. */
  viewport = Gtk.Viewport();
  /* uses the newly-created adjustment for the scrollbar as well. */
  vscrollbar = Gtk.VScrollbar(viewport.get_vadjustment());
[/CODE]





Adjustment Internals

Ok, you say, that's nice, but what if I want to create my own handlers to 
respond when the user adjusts a range widget or a spin button, and how do I get 
at the value of the adjustment in these handlers? To answer these questions and 
more, let's start by taking a look at the attributes of a 
[CODE]Gtk.Adjustment[/CODE] itself:

[PRE]
  lower
  upper
  value
  step_increment
  page_increment
  page_size
[/PRE]

Given a [CODE]Gtk.Adjustment[/CODE] instance [CODE]adj[/CODE], each of the 
attributes are retrieved or set by adj.lower, adj.value, etc.

Since, when you set the value of an adjustment, you generally want the change 
to be reflected by every widget that uses this adjustment, GTK+ provides a 
method to do this:

[CODE]
  adjustment.set_value(double value)
[/CODE]

As mentioned earlier, [CODE]Adjustment[/CODE] is a subclass of [CODE]Object[/CODE] 
just like all the various widgets, and thus it is able to emit signals. This 
is, of course, why updates happen automagically when you share an adjustment 
object between a scrollbar and another adjustable widget; all adjustable widgets 
connect signal handlers to their adjustment's value_changed signal, as can your 
program. Here's the definition of this signal callback:

[CODE]
  virtual void adjustment.value_changed():
[/CODE]

The various widgets that use the [CODE]Adjustment[/CODE] object will emit this 
signal on an adjustment whenever they change its value. This happens both when 
user input causes the slider to move on a range widget, as well as when the 
program explicitly changes the value with the [CODE]set_value()[/CODE] method. 
So, for example, if you have a scale widget, and you want to change the rotation 
of a picture whenever its value changes, you would create a callback like this:

[CODE]
  void cb_rotate_picture(picture) {
    set_picture_rotation (picture, adj.value)
  }
[/CODE]

and connect it to the scale widget's adjustment like this:

[CODE]
  adj.value_changed.connect(()=>{ cb_rotate_picture(picture); });
[/CODE]

What about when a widget reconfigures the upper or lower fields of its 
adjustment, such as when a user adds more text to a text widget? In this case, 
it emits the [CODE]changed[/CODE] signal, which looks like this:

[CODE]
  void changed()
[/CODE]

Range widgets typically connect a handler to this signal, which changes their 
appearance to reflect the change - for example, the size of the slider in a 
scrollbar will grow or shrink in inverse proportion to the difference between 
the lower and upper values of its adjustment.

You probably won't ever need to attach a handler to this signal, unless you're 
writing a new type of range widget. However, if you change any of the values in 
an [CODE]Adjustment[/CODE] directly, you should emit this signal on it to 
reconfigure whatever widgets are using it, like this:

[CODE]
  adjustment.emit("changed")
[/CODE]

