# GTK Programming Using Vala: First Programs

## A First Program

We will start with the simplest program possible: a program that will create a
200px by 200px window and has no way of exiting except to be killed using the
shell.

<pre><code class="vala">/* examples/chapter_03/01_simplewindow.vala */

int main(string[] args) {
  Gtk.init (ref args);

  Gtk.Window window = new Window();
  window.show_all();

  Gtk.main();

  return 0;
}
</code></pre>

Vala code is written in files with `.vala`   extensions. The source files for
the program are supplied as command line parameters to the Vala compiler `valac`,
along with compiler flags.

This code can also be found as a vala file in the
[example code](https://github.com/abenga/valagtk3tutorial/tree/master/examples),
in the file `examples/chapter_03/01_simplewindow.vala`. You can compile the
program above by using

<pre><code class="bash">$ valac --pkg gtk+-3.0 01_simplewindow.vala -o simplewindow</code></pre>

`valac` is the name of the vala compiler. `--pkg gtk+3.0` tells the vala
compiler to include the Gtk+ header files in the compilation. The `-o` flag
tells the compiler what to call the compiled executable, in this case
`simplewindow`. If this is omitted, the binary will have the same base name
as the vala source file (`01_simplewindow`, in this case). The final argument
is the name of the vala source file we are compiling.

When compilation succeeds, one may execute the program by typing

<pre><code class="bash">$ ./simplewindow</code></pre>

into the console.

A window similar the figure below should pop up on your display:

<figure>
  <img src="https://lh5.googleusercontent.com/-poqQuugi43E/Uf-1kO-O1qI/AAAAAAAAAEw/4i1HNtKqbLs/w289-h311-no/01_simplewindow.png" alt="Simple Window" title="A Simple Window">
  <figcaption>Simple Window</figcaption>
</figure>

Just closing this window does not kill the program, however (the window will be
closed, but the program will keep on running). To stop execution of the program,
you have to press `CTR+C` in the console from which you launched the program.

The line:

<pre><code class="vala">Gtk.init(ref args)</code></pre>

calls `Gtk.init()`, the initialization function for GTK. This function will set
up GTK, the type system, the connection to the windowing environment, etc.
`Gtk.init()` takes as arguments a reference to the command line arguments  that
were passed to the program. They are passed as a reference so that `Gtk.init()`
is able to modify them.

`Gtk.init()` sets up things such as the default visual and color map and calls
`Gdk.init()`.It initializes the library for use, sets up default signal handlers,
and checks the arguments passed to the application, looking for specific command
line arguments that control the behavious of GTK itself, i.e.:

* `--gtk-module`

* `--g-fatal-warnings`

* `--gtk-debug`

* `--gtk-no-debug`

* `--gdk-debug`

* `--gdk-no-debug`

* `--display`

* `--sync`

* `--name`

* `--class`

It removes these from the argument list, leaving anything it does not recognize
for your application to parse or ignore.

The next two lines:

<pre><code class="vala">Gtk.Window window = new Window();
window.show_all();</code></pre>

create and display a window. The window constructor `Window()` takes a window
type (one of `Gtk.WindowType.TOPLEVEL` and `Gtk.WindowType.POPUP`) as an
argument that defines how the window will be drawn. The default value is
`Gtk.WindowType.TOPLEVEL` which specifies that we want the window to undergo
window manager decoration and placement. Rather than create a window of 0x0
size, a window without children is set to 200x200 by default so you can still
manipulate it.

The line

<pre><code class="vala">Gtk.main();</code></pre>

enters the GTK main processing loop. This is a  call you will see in every GTK
application. When control reaches this point, GTK will sleep waiting for the
user to interact with the application through events such as button or key
presses, etc or for timeouts, or file input and output notifications to occur.
In our simple example, however, these events are ignored.


## Hello World

Here we will create a program with a widget (a button). It is the classic
Hello World program. It will print out *"Hello World"* when the button is
pressed and exit the program.

<figure>
  <img src="https://lh5.googleusercontent.com/-z1WZFmrUOg4/Uf-1kNxLHSI/AAAAAAAAAE0/JVIOvZlkapI/w403-h189-no/02_helloworld.png" alt="GTK Hello World" title="GTK Hello World">
  <figcaption>Hello World a la GTK</figcaption>
</figure>

<pre><code class="vala">/** examples/chapter_03/02_helloworld.vala */

/* We define a HelloWorld class as a subclass Gtk.Window. */
class HelloWorld : Gtk.Window {

  private Gtk.Button button;

  /* This is a callback function. The data arguments are ignored
     in this example. More on callbacks below. */
  public void hello () {
    stdout.printf("Hello World\n");
  }

  public bool on_delete_event () {
    /* If you return FALSE in the "delete_event" signal handler,
       GTK will emit the "destroy" signal. Returning TRUE means
       you don’t want the window to be destroyed.
       This is useful for popping up ’are you sure you want to quit?’
       type dialogs. */
    stdout.printf("delete event occurred\n");
    /* Change true to false and the main window will be destroyed with
       a "delete_event". */
    return false;
  }

  /* Another callback. */
  public void on_destroy() {
   Gtk.main_quit();
  }

  public HelloWorld () {

    /* When the window is given the "delete_event" signal (this is given
       by the window manager, usually by the "close" option, or on the
       titlebar), we ask it to call the on_delete_event() function as
       defined above. The data passed to the callback function is NULL
       and is ignored in the callback function. */
    this.delete_event.connect(this.on_delete_event);

    /* Here we connect the "destroy" event to a signal handler.
       This event occurs when we call gtk_widget_destroy() on the window,
       or if we return FALSE in the "on_delete_event" callback. */
    this.destroy.connect(this.on_destroy);

    /* Sets the border width of the window. */
    this.set_border_width(10);

    /* Creates a new button with the label "Hello World". */
    this.button = new Gtk.Button.with_label("Hello World");

    /* When the button receives the "clicked" signal, it will call the
       function hello() passing it None as its argument.  The hello()
       function is defined above. */
    this.button.clicked.connect(this.hello);

    /* This will cause the window to be destroyed by calling
       Gtk.Widget.destroy(window) when "clicked".  Again, the destroy
       signal could come from here, or the window manager. */
    GLib.Signal.connect_swapped(this.button, "clicked", (GLib.Callback)this.on_destroy, this);

    /* This packs the button into the window (a GTK container). */
    this.add(this.button);

  }

  public static int main(string[] args){
    Gtk.init(ref args);

    var hello = new HelloWorld();

    /* Show all the window and all the widgets contained therein. */
    hello.show_all();
    /* All Vala GTK applications must have a Gtk.main(). Control ends here
       and waits for an event (like a key press or mouse event) to occur. */
    Gtk.main();

    return 0;
  }
}
</code></pre>


## Compiling Hello World

To compile *Hello World* above, you invoke `valac` using the command:

<pre><code class="vala">$ valac --pkg gtk+-3.0 -o helloworld 02_helloworld.vala</code></pre>

If you did this instead:

<pre><code class="bash">$ valac --pkg gtk+-3.0 -C 02_helloworld.vala</code></pre>

i.e. if you give `valac` the `-C` switch, it won't compile your program into a
binary file. Instead it will output the intermediate C code for each of your
Vala source files into a corresponding C source file, in this case
`02_helloworld.c`. If you look at the content of these files you can see that
programming a class in Vala is equivalent to the same task in C, but a whole lot
more succinct.


## Theory of Signals and Callbacks

Before we look in detail at *Hello World*, we'll discuss signals and callbacks.
GTK is an event driven toolkit, which means it will sleep in `Gtk.main()` until
an event occurs and control is passed to the appropriate function.

This passing of control is done using the idea of *"signals"*. Signals are a
system allowing a objects to emit events which can be received by arbitrary
listeners. They form a convenient way for objects to inform each other about
events.

In Vala, only instances of classes  descended from `GLib.Object` can emit
signals. These signals are not the same as the Unix system signals, and are not
implemented using them, although the terminology is almost identical. Through
these signals, we can connect arbitrary application-specific events with any
number of listeners.

### Signals and Callbacks in Vala

Signals are usually defined in a class and interested parties register their
callback functions to these signals of an instance of this class. The instance
can emit the signal in the style of a method call and each callback function
(referred to as a *handler*) connected to the signal will get called.

For example,

<pre><code class="vala">class Foo : Glib.Object {
  public signal void some_event ();// definition of the signal

  public void method () {
    some_event(); // emitting the signal (callbacks get invoked)
  }
}

void callback_a () {
  stdout.printf("Callback A\n");
}

void callback_b () {
  stdout.printf("Callback B\n");
}

void main () {
  var foo = new Foo ();
  foo.some_event.connect(callback_a);  // connecting the callback functions
  foo.some_event.connect(callback_b);
  foo.method();
}
</code></pre>
You may disconnect signal callbacks in one of two ways. The first (and simplest)
is by calling `myobject.mysignal.disconnect(callback)`. In our example above,
`callback_a` may be disconnected by calling

<pre><code class="vala">foo.some_event.disconnect(callback_a);</code></pre>

The second way is to store the return value of the `connect()` callback (it
usually returns a `ulong` handler id) and then pass this signal id to
`my_object.disconnect()`. Note that you have to invoke `disconnect()` on the
object, not the signal. This is particularly useful when you connect closures
(anonymous functions, also known as *lambda expressions*) as callbacks, for
example:

<pre><code class="vala">ulong handlerId = foo.some_event.connect (() => { /* Closure code here. */ });
foo.disconnect(handlerId);</code></pre>

You can also temporarily disable and reenable signal handlers with the
`GLib.SignalHandler.block()` and `GLib.SignalHandler.unblock()` family of
functions.

<pre><code class="vala">void GLib.SignalHandler.block(void* instance,
                              ulong handler_id);

void GLib.SignalHandler.block_by_func (void* instance,
                                       void* func,
                                       void* data);

void GLib.SignalHandler.unblock(void* object,
                                ulong id );

void GLib.SignalHandler.unblock_by_func(void* object,
                                        void* func,
                                        void* data );
</code></pre>

### GTK Signals

In GTK, every user event (keystroke or mouse move) is received from the
[X](http://en.wikipedia.org/wiki/X_Window_System) server and generates a GTK
event. When an event occurs, such as the press of a mouse button, the
appropriate signal will be emitted by the widget that was pressed. This is how
GTK does most of its useful work. There are signals that all widgets inherit,
such as *"destroy"*, and there are signals that are widget specific, such as
*"toggled"* on a toggle button.

To make a button perform an action, we set up a signal handler to catch these
signals and call the functions connected to this signal.

<pre><code class="vala">handlerID = object.signal.connect(func)</code></pre>

where `object` is the `Gtk.Widget` instance which will be emitting the signal,
and the argument `func` is the "callback function" you wish to be called when it
is caught. The method returns a handler id that can be used to disconnect or
block the handler. `func` is called a "callback function" and is ordinarily a
member function of a class that subclasses `Gtk.Widget`.


## Events

In addition to the signal mechanism described above, there is a set of *events*
that reflect the X event mechanism. Callbacks may also be attached to these
events.

These events are not the same as the signals that GTK widgets emit. Although
many of these events result in corresponding signals being emitted, the events
are often transformed or filtered along the way.

* `event`

* `button_press_event`

* `button_release_event`

* `scroll_event`

* `motion_notify_event`

* `delete_event`

* `destroy_event`

* `expose_event`

* `key_press_event`

* `key_release_event`

* `enter_notify_event`

* `leave_notify_event`

* `configure_event`

* `focus_in_event`

* `focus_out_event`

* `map_event`

* `unmap_event`

* `property_notify_event`

* `selection_clear_event`

* `selection_request_event`

* `selection_notify_event`

* `proximity_in_event`

* `proximity_out_event`

* `visibility_notify_event`

* `client_event`

* `no_expose_event`

* `window_state_event`

In order to connect a callback function to one of these events you use the
method `object.signal.connect()`, as described above, where signal is one of the
above events.

`Gdk.Event` is a class whose type depends upon which of the above events has
occurred. Possible values for the `Gdk.EventType` are:

* `NOTHING`: a special code to indicate a null event.

* `DELETE`: the window manager has requested that the toplevel window be
  hidden or destroyed, usually when the user clicks on a special icon in the
  title bar.

* `DESTROY`: the window has been destroyed.

* `EXPOSE`: all or part of the window has become visible and needs to be redrawn.

* `MOTION_NOTIFY`: the pointer (usually a mouse) has moved.

* `BUTTON_PRESS`: a mouse button has been pressed.

* `2BUTTON_PRESS`: a mouse button has been double-clicked (clicked twice within
  a short period of time). Note that each click also generates a `BUTTON_PRESS`
  event.

* `3BUTTON_PRESS`: a mouse button has been clicked 3 times in a short period of
  time. Note that each click also generates a `BUTTON_PRESS` event.

* `BUTTON_RELEASE`: a mouse button has been released.

* `KEY_PRESS`: a key has been pressed.

* `KEY_RELEASE`: a key has been released.

* `ENTER_NOTIFY`: the pointer has entered the window.

* `LEAVE_NOTIFY`: the pointer has left the window.

* `FOCUS_CHANGE`: the keyboard focus has entered or left the window.

* `CONFIGURE`: the size, position or stacking order of the window has changed.
  Note that GTK discards these events for `WINDOW_CHILD` windows.

* `MAP`: the window has been mapped.

* `UNMAP`: the window has been unmapped.

* `PROPERTY_NOTIFY`: a property on the window has been changed or deleted.

* `SELECTION_CLEAR`: the application has lost ownership of a selection.

* `SELECTION_REQUEST`: another application has requested a selection.

* `SELECTION_NOTIFY`: a selection has been received.

* `PROXIMITY_IN`: an input device has moved into contact with a sensing surface
  (e.g. a touchscreen or graphics tablet).

* `PROXIMITY_OUT`: an input device has moved out of contact with a sensing
  surface.

* `DRAG_ENTER`: the mouse has entered the window while a drag is in progress.

* `DRAG_LEAVE`: the mouse has left the window while a drag is in progress.

* `DRAG_MOTION`: the mouse has moved in the window while a drag is in progress.

* `DRAG_STATUS`: the status of the drag operation initiated by the window has
  changed.

* `DROP_START`: a drop operation onto the window has started.

* `DROP_FINISHED`: the drop operation initiated by the window has completed.

* `CLIENT_EVENT`: a message has been received from another application.

* `VISIBILITY_NOTIFY`: the window visibility status has changed.

* `SCROLL`: the scroll wheel was turned

* `WINDOW_STATE`: the state of a window has changed. See
  [`Gdk.WindowState`](http://valadoc.org/#!api=gdk-3.0/Gdk.WindowState) for
  the possible window states

* `SETTING`: a setting has been modified.

* `OWNER_CHANGE`: the owner of a selection has changed.

* `GRAB_BROKEN`: a pointer or keyboard grab was broken.

* `DAMAGE`: the content of the window has been changed.

* `EVENT_LAST`: marks the end of the GdkEventType enumeration.


In order to connect a callback function to one of these events you use the
function `object.signal.connect`, for example

<pre><code class="vala">button.button_press_event.connect(func)</code></pre>


## Stepping Through Hello World

Now that we know the theory behind this, let's clarify by walking through the
example `02_helloworld.vala` program.

The code

<pre><code class="vala">class HelloWorld : Gtk.Window {
  ...
}</code></pre>

defines a class called `HelloWorld` that is a subclass of `Gtk.Window`, which 
means that it inherits all the public attributes and methods of the `Gtk.Window` 
class. While in the class, reference to the `HelloWorld` instance can be 
obtained using the keyword `this`.

The `HelloWorld` class contains a single member: `button`, an instance of 
`Gtk.Button`.

<pre><code class="vala">private Gtk.Button button;</code></pre>

Now let's examine the callback methods.

The following lines define the `hello()` callback method that will be called
when `button` is "clicked".

<pre><code class="vala">public void hello () {
  stdout.printf("Hello World\n");
}</code></pre>

When called the method prints *"Hello World"* to the console. In this case the
data parameter is left out since the `hello()` method will never called with
user data. An example in the next chapter will use the data argument to tell us
which button was pressed.

The next callback is a bit special. It will be called when the *"delete_event"* 
occurs and the window manager sends this event to the application. This happens, 
for example, when the user clicks the close button on the window. We have a 
choice here as to what to do about these events. We can ignore them, ask the 
user for additional confirmation, or simply quit the application.

The value you return in this callback lets GTK know what action to take. By
returning `true`, we let it know that we don't want to have the *"destroy"*
signal emitted, keeping our application running. By returning `false`, we ask
that *"destroy"* be emitted, which in turn will call our *"destroy"* signal
handler (`on_destroy`). Note the comments have been removed for clarity.

<pre><code class="vala">public bool on_delete_event () {
  stdout.printf("delete event occurred\n");
  return true;
}</code></pre>

The `on_destroy()` callback method causes the program to quit by calling
`Gtk.main_quit()`. This function tells GTK that it is to exit from `Gtk.main()`
when control is returned to it.

<pre><code class="vala">public void on_destroy() {
  Gtk.main_quit();
}</code></pre>

The `HelloWorld` constructor `HelloWorld()` creates the window and widgets used
by the program. The window (and its contents) is not displayed until we direct 
GTK to show the window near the end of our program. 

The next two lines illustrate two examples of connecting a signal handler to an
object, in this case, the window. Here, the *"delete_event"* and *"destroy"*
signals are caught. The first is emitted when we use the window manager to close
the window, or when we use the `GtkWidget` `destroy()` method call. The second
is emitted when, in the `on_delete_event` handler, we return `false`.

<pre><code class="vala">this.delete_event.connect(this.on_delete_event);

this.destroy.connect(this.on_destroy);</code></pre>

The next line sets an attribute of a container object (in this case the window)
to have a blank area along the inside of it 10 pixels wide where no widgets will
be placed. There are other similar methods that we will look at in a later
tutorial chapter.

<pre><code class="vala">this.set_border_width(10);</code></pre>

The next line

<pre><code class="vala">this.button = new Gtk.Button.with_label("Hello World");</code></pre>

creates a new button and saves a reference to it in `this.button`. The button
will have the label *"Hello World"* when displayed.

The line

<pre><code class="vala">this.button.clicked.connect(this.hello);</code></pre>

we attach a signal handler to the button so when it emits the *"clicked"*
signal, our `hello()` callback method is called. We are not passing any data to
`hello()` so we don't pass any arguments. The "clicked" signal is emitted when
we click the button with our mouse pointer.

We are also going to use this button to exit our program. This will illustrate
how the *"destroy"* signal may come from either the window manager, or our
program.  When the button is *"clicked"*, same as above, it calls the first
`hello()`  callback function, and then causes *"destroy"* signal to be emitted.
(It does these two in the order they are set up). You may connect as many
callback functions as you need, and all will be executed in the order you
connected them.

Since we want to use the `GtkWidget` `destroy()` method that accepts one
argument (the widget to be destroyed - in this case the window), we use the
`GLib.Signal.connect_swapped()` method and pass it the object to which we are
connecting it to, the signal to watch out for, the callback to be run and a
reference to the the window to be destroyed.

When the `Gtk.Widget destroy()` method is called it will cause the *"destroy"*
signal to be emitted from the window which will in turn cause the `HelloWorld`
`on_destroy()` method to be called to end the program.

The next line

<pre><code class="vala">this.add(this.button);</code></pre>

is a packing call, which will be explained in depth later on in a later
chapter on Packing Widgets. But it is fairly easy to understand. It simply tells
GTK that the button is to be placed in the window where it will be displayed.
Note that a GTK container can only contain one widget. There are other widgets,
described later, that are designed to lay out multiple widgets in various ways.

Now we have everything set up the way we want it to be. All the signal handlers 
are in place, and the button has been placed in the window.


We now define the `main()` method. This is the point at which execution of
our program begins.

The line

<pre><code class="vala">var hello = new HelloWorld();</code></pre>

creates an instance of the `HelloWorld` class and saves a reference to
it in the `hello` variable.

and in the line

<pre><code class="vala">hello.show_all();</code></pre>

weask GTK to "show" the widgets on the screen using the line.

We then call the `Gtk.main()` function which sleeps and waits for the user to
interact with the program interface.

<pre><code class="vala">Gtk.main();</code></pre>

Now, when we click the mouse button on a GTK button, the widget emits a
*"clicked"* signal. In order for us to use this information, our program sets up
a signal handler to catch that signal, which dispatches the function of our
choice. In our example, when the button we created is clicked, the `hello()`
method is called with no arguments, and then the next handler for this signal is
called. The next handler calls the widget `destroy()` function with the window
as its argument thereby causing the window to emit the *"destroy"* signal, which
is caught, and calls our `HelloWorld` `destroy()` method.

Another course of events is to use the window manager to kill the window, which
will cause the *"delete_event"* to be emitted. This will call our *"delete_event"*
handler. If we return `true` here, the window will be left as is and nothing
will happen. Returning `false` will cause GTK to emit the *"destroy"* signal
that causes the `HelloWorld` *"destroy"* callback to be called, exiting GTK.


## References and Further Reading

* The GTK+ Tutorial: Getting Started. [Online] Available from:
  [https://developer.gnome.org/gtk-tutorial/2.90/c39.html](https://developer.gnome.org/gtk-tutorial/2.90/c39.html)
  [Accessed 16&nbsp;September&nbsp;2014]

* Vala Documentation: Signals and Callbacks. [Online] Available from:
  [https://wiki.gnome.org/Projects/Vala/SignalsAndCallbacks](https://wiki.gnome.org/Projects/Vala/SignalsAndCallbacks)
  [Accessed 16&nbsp;September&nbsp;2014]

* Valadoc (Vala online package binding reference documentation) [Online] Available from:
  [http://valadoc.org/#!api=gobject-2.0/GLib.SignalHandler](http://valadoc.org/#!api=gobject-2.0/GLib.SignalHandler)
  [Accessed 16&nbsp;September&nbsp;2014]
