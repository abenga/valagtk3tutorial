# GTK+ Programming Using Vala: First Programs

## A First Program

We will start with the simplest program possible: a program
that will create a 200px by 200px window and has no way of exiting
except to be killed using the shell.

    int main(string[] args) {
      Gtk.init (ref args);

      Gtk.Window window = new Window();
      window.show_all();

      Gtk.main();

      return 0;
    }

This code can be found in the example code, in the file
`examples/chapter_02/01_simplewindow.vala`. You can compile the program
above by using

<pre class="prettyprint">
$ valac -o simplewindow --pkg gtk+-3.0 01_simplewindow.vala
</pre>

`valac` is the name of the vala compiler. `--pkg gtk+3.0` tells the vala
compiler to include the Gtk+ header files in the compilation. The `-o` flag
tells the compiler what to call the compiled executable, in this case
`simplewindow`. If this is omitted, the binary will have the same base name
as the vala source file (here its filename would have been `01_simplewindow`)
The final argument is the name of the vala source file we are compiling.
If compilation succeeds, one may execute the program by typing

    $ ./simplewindow

into the console.

A window similar the figure below should pop up on your display:

<figure>
  <img src="https://lh3.googleusercontent.com/-PGKN5vPbB3k/UfbG_-ysOqI/AAAAAAAAACE/nlVCJFgy-8Q/w289-h311-p/01_simplewindow.png" alt="Simple Window" title="A Simple Window">
  <figcaption>Simple Window</figcaption>
</figure>

Just closing this window does not kill the program, however (the window will be
closed, but the program will keep on running). To stop execution of the program,
you have to press `CTR+C` in the console from which you launched the program.

The next line:

    Gtk.init(ref args)

calls `Gtk.init()`, the initialization function
for GTK+; this function will set up GTK+, the type system, the connection
to the windowing environment, etc. `Gtk.init()` takes
as arguments a reference to the command line arguments  that were passed
to the program. They are passed as a reference so that
`Gtk.init()` is able to modify them.

`Gtk.init()` sets up things such as the default visual and color map and calls
`Gdk.init()`.It initializes the library for use, sets up default signal
handlers, and checks the arguments passed to the application, looking for
specific command line arguments that control the behavious of GTK+ itself, i.e.:

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

    Gtk.Window window = new Window();
    window.show_all();

create and display a window. The window constructor `Window()` takes a window
type (one of `Gtk.WindowType.TOPLEVEL` and `Gtk.WindowType.POPUP`) as an
argument that defines how the window will be drawn. The default value is
`Gtk.WindowType.TOPLEVEL` which specifies that we want the window to undergo
window manager decoration and placement. Rather than create a window of 0x0
size, a window without children is set to 200x200 by default so you can still
manipulate it.

The last line

    Gtk.main();

enters the GTK main processing loop. This is a  call you will see in every GTK
application. When control reaches this point, GTK will sleep waiting for the
user to interact with the application through events such as button or key
presses, etc or for timeouts, or file input and output notifications to occur.
In our simple example, however, these events are ignored.


## Hello World

Here we will create a program with a widget (a button). It will
print out "Hello World" when the button is pressed and exit the
program.

    /* examples/chapter_02/02_helloworld.vala */

    class HelloWorld {

      private Gtk.Window window;
      private Gtk.Button button;

      /* This is a callback function. It takes no arguments in
       * this example. We will learn more about callbacks later. */
      public void hello () {
        stdout.printf("Hello World\n");
      }

      /* If you return FALSE in the "delete_event" signal handler, GTK will
       * emit the "destroy" signal. Returning TRUE means you don’t want the
       * window to be destroyed. This is useful for popping up ’are you sure
       * you want to quit?’ type dialogs.
       *
       * If you change "return true;" to "return false" the main window will
       * be destroyed with a "delete_event".*/
      public bool delete_event () {
        stdout.printf("delete event occurred\n");
        return true;
      }

      /* Another callback. */
      public void destroy() {
        Gtk.main_quit();
      }

      public HelloWorld () {

        /* Create a new window */
        this.window = new Gtk.Window();

        /* When the window is given the "delete_event" signal (this is given
         * by the window manager, usually by the "close" option, or on the
         * titlebar), we ask it to call the delete_event () function as
         * defined above. The data passed to the callback function is NULL
         * and is ignored in the callback function. */
        this.window.delete_event.connect(this.delete_event);

        /* Here we connect the "destroy" event to a signal handler.
         * This event occurs when we call gtk_widget_destroy() on the window,
         * or if we return false in the "delete_event" callback. */
        this.window.destroy.connect(this.destroy);

        /* Sets the border width of the window. */
        this.window.set_border_width(10);

        /* Creates a new button with the label "Hello World". */
        this.button = new Gtk.Button.with_label("Hello World");

        /* When the button receives the "clicked" signal, it will call the
         * function hello() passing it None as its argument.  The hello()
         * function is defined above. */
        this.button.clicked.connect(this.hello);

        /* This will cause the window to be destroyed by calling
         * Gtk.Widget.destroy(window) when "clicked".  Again, the destroy
         * signal could come from here, or the window manager. */
        GLib.Signal.connect_swapped(this.button, "clicked",
                                    (GLib.Callback) destroy, this.window);

        /* This packs the button into the window (a GTK container). */
        this.window.add(this.button);

        /* The final step is to display this newly created widget. */
        this.button.show();

        /* and the window */
        this.window.show();
      }

      public static int main(string[] args){
        Gtk.init(ref args);

        var hello = new HelloWorld();

        /* All Vala GTK applications must have a Gtk.main(). Control
         * ends here and waits for an event to occur (like a key press
         * or mouse event). */
        Gtk.main();

        return 0;
      }

    }


## Compiling Hello World

Vala code is written in files with `.vala`   extensions. The source files for
the program are supplied as command   line parameters to the Vala compiler
`valac`, along   with compiler flags.

To compile *Hello World* above, you would use the following command:

    $ valac --pkg gtk+-3.0 -o helloworld 02_helloworld.vala

If you did this instead:

    $ valac --pkg gtk+-3.0 -C 02_helloworld.vala

i.e. if you give valac the `-C` switch, it won't compile your program into a
binary file. Instead it will output the intermediate C code for each of your
Vala source files into a corresponding C source file, in this case
`02_helloworld.c`. If you look at the content of these files you can see that
programming a class in Vala is equivalent to the same task in C, but a whole lot
more succinct.


## Theory of Signals and Callbacks

Before we look in detail at *Hello World*, we'll discuss signals and callbacks.
GTK+ is an event driven toolkit, which means it will sleep in `Gtk.main()` until
an event occurs and control is passed to the appropriate function.

This passing of control is done using the idea of *"signals"*. Signals are a
system allowing a objects to emit events which can be recieved by arbitrary
listeners. They form a convenient way for objects to inform each other about
events. Only instances of classes  descended from `GLib.Object` can emit signals.
These signals are not the same as the Unix system signals, and are not
implemented using them, although the terminology is almost identical. Through
these signals, we can connect arbitrary application-specific events with any
number of listeners.

### Signals and Callbacks in Vala

Signals are usually defined in a class and interested parties register their
callback functions to these signals of an instance. The instance can emit the
signal in the style of a method call and each callback function (referred to
as *handler*) connected to the signal will get called.

For example,

    class Foo : Object {
      public signal void some_event ();// definition of the signal

      public void method () {
        some_event ();                 // emitting the signal (callbacks get invoked)
      }
    }

    void callback_a () {
      stdout.printf ("Callback A\n");
    }

    void callback_b () {
      stdout.printf ("Callback B\n");
    }

    void main () {
      var foo = new Foo ();
      foo.some_event.connect (callback_a);      // connecting the callback functions
      foo.some_event.connect (callback_b);
      foo.method ();
    }

You may disconnect signal callbacks in one of two ways. The first (and simplest)
is by calling `myobject.mysignal.disconnect(callback)`. In our example above,
`callback_a` may be disconnected by calling

    foo.some_event.disconnect(callback_a);

The second way is to store the return value of the `connect()` callback (it
usually returns a `ulong` handler id) and then pass this signal id to
`my_object.disconnect()`. Note that you have to invoke `disconnect()` on the
object, not the signal. This is particularly useful when you connect closures
(anonymous methods, also known as *lambda expressions*) as callbacks, for
example:

    ulong handlerId = foo.some_event.connect (() => { /* Closure code here. */ });
    foo.disconnect (handlerId);

You can also temporarily disable and reenable signal handlers with the
`GLib.SignalHandler.block()` and `GLib.SignalHandler.unblock()` family of
functions.


    void GLib.SignalHandler.block(void* instance,
                                  ulong handler_id);

    void GLib.SignalHandler.block_by_func (void* instance,
                                           void* func,
                                           void* data);

    void GLib.SignalHandler.unblock(void* object,
                                    ulong id );

    void GLib.SignalHandler.unblock_by_func(void* object,
                                            void* func,
                                            void* data );

### GTK+ Signals

In GTK+, every user event (keystroke or mouse move) is received from the X
server and generates a GTK+ event. When an event occurs, such as the press of a
mouse button, the appropriate signal will be emitted by the widget that was
pressed. This is how GTK+ does most of its useful work. There are signals that
all widgets inherit, such as "destroy", and there are signals that are widget
specific, such as *"toggled"* on a toggle button.

To make a button perform an action, we set up a signal handler to catch these
signals and call the functions connected to this signal.

    handlerID = object.signal.connect(func)

where `object` is the `Gtk.Widget` instance which will be emitting the signal,
and the argument `func` is the "callback function" you wish to be called when it
is caught. The method returns a handler id that can be used to disconnect or
block the handler. `func` is called a "callback function" and is ordinarily a
member function of a class that subclasses `Gtk.Widget`.


## Events

In addition to the signal mechanism described above, there is a set of *events*
that reflect the X event mechanism. Callbacks may also be attached to these
events.

These events are not the same as the signals that GTK+ widgets emit.
Although many of these events result in corresponding signals being
emitted, the events are often transformed or filtered along the
way.

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
above events. The callback function (or method) for events has a slightly
different form than that for signals:

`Gdk.Event` is a struct that contains a union of all of the event structs. Its
type depends upon which of the above events has occurred. Possible values for
the `Gdk.EventType` are:

* `NOTHING`: a special code to indicate a null event.

* `DELETE`: the window manager has requested that the toplevel window be
hidden or destroyed, usually when the user clicks on a special icon in the title
bar.

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
Note that GTK+ discards these events for `WINDOW_CHILD` windows.

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

* `WINDOW_STATE`: the state of a window has changed. See `Gdk.WindowState` for
the possible window states

* `SETTING`: a setting has been modified.

* `OWNER_CHANGE`: the owner of a selection has changed.

* `GRAB_BROKEN`: a pointer or keyboard grab was broken.

* `DAMAGE`: the content of the window has been changed.

* `EVENT_LAST`: marks the end of the GdkEventType enumeration.


In order to connect a callback function to one of these events you use the
function `object.signal.connect`, for example

    window.destroy.connect(func)

## Stepping Through Hello World

Now that we know the theory behind this, let's clarify by walking through the
example `02_helloworld.vala` program.

Lines 4-89 define the `HelloWorld` class that contains all the callbacks as
object methods and the object instance initialization method. Lines 6 and 7
define the members of `HelloWorld`. These are the widgets that we will be
manipulating in the program.

    private Gtk.Window window;
    private Gtk.Button button;

Now let's examine the callback methods.

Lines 11-13 define the `hello()` callback method that will be called when the
button is "clicked".
When called the method prints *"Hello World"* to the console. In this case the
data parameter is left out since the `hello()` method will never called with
user data. The next example will use the data argument to tell us which button
was pressed.


    public void hello () {
      stdout.printf("Hello World\n");
    }

The next callback (lines 22-25) is a bit special. The *"delete_event"* occurs
when the window manager sends this event to the application. This happens, for
example, when the user clicks the close button on the window. We have a choice
here as to what to do about these events. We can ignore them, respond, or simply
quit the application.

The value you return in this callback lets GTK+ know what action to take. By
returning `true`, we let it know that we don't want to have the *"destroy"*
signal emitted, keeping our application running. By returning `false`, we ask
that *"destroy"* be emitted, which in turn will call our *"destroy"* signal
handler. Note the comments have been removed for clarity.

    public bool delete_event () {
      stdout.printf("delete event occurred\n");
      return true;
    }

The `destroy()` callback method (lines 28-30) causes the program to quit by
calling `Gtk.main_quit()`. This function tells GTK+ that it is to exit from
`Gtk.main()` when control is returned to it.

    public void destroy() {
      Gtk.main_quit();
    }

Lines 32-74 define the `HelloWorld` constructor `HelloWorld()` that creates the
window and widgets used by the program.

Line 35 creates a new window, but it is not displayed until we direct GTK+ to
show the window near the end of our program. The window reference is saved in
the `HelloWorld` attribute `window` for later access.

    this.window = new Gtk.Window();

Lines 42 and 47 illustrate two examples of connecting a signal handler to an
object, in this case, the window. Here, the *"delete_event"* and *"destroy"*
signals are caught. The first is emitted when we use the window manager to close
the window, or when we use the `GtkWidget` `destroy()` method call. The second
is emitted when, in the "delete_event" handler, we return `false`.

    this.window.delete_event.connect(this.delete_event);

    this.window.destroy.connect(this.destroy);

Line 50 sets an attribute of a container object (in this case the window) to
have a blank area along the inside of it 10 pixels wide where no widgets will be
placed. There are other similar methods that we will look at later
<!--(in Chapter 18, Setting Widget Attributes.)-->

    this.window.set_border_width(10);

Line 53 creates a new button and saves a reference to it in `self.button`. The
button will have the label *"Hello World"* when displayed.

    this.button = new Gtk.Button.with_label("Hello World");

In line 58 we attach a signal handler to the button so when it emits the
*"clicked"* signal, our `hello()` callback method is called. We are not passing
any data to `hello()` so we don't pass any arguments. The "clicked" signal is
emitted when we click the button with our mouse pointer.

    this.button.clicked.connect(this.hello);

We are also going to use this button to exit our program. This will illustrate
how the *"destroy"* signal may come from either the window manager, or our
program.  When the button is *"clicked"*, same as above, it calls the first
`hello()`  callback function, and then causes *"destroy"* signal to be emitted.
(It does these two in the order they are set up). You may have as many callback
functions as you need, and all will be executed in the order you connected them.

Since we want to use the `GtkWidget` `destroy()` method that accepts one
argument (the widget to be destroyed - in this case the window), we use the
`GLib.Signal.connect_swapped()` method and pass it the object to which we are
connecting it to, the signal to watch out for, the callback to be run and a
reference to the the window to be destroyed.

When the `Gtk.Widget destroy()` method is called it will cause the *"destroy"*
signal to be emitted from the window which will in turn cause the `HelloWorld`
`destroy()` method to be called to end the program.

    GLib.Signal.connect_swapped(this.button, "clicked",
                                (GLib.Callback) destroy, this.window);

Line 67 is a packing call, which will be explained in depth later on in a later
chapter on Packing Widgets. But it is fairly easy to understand. It simply tells
GTK+ that the button is to be placed in the window where it will be displayed.
Note that a GTK+ container can only contain one widget. There are other widgets,
described later, that are designed to layout multiple widgets in various ways.

    this.window.add(this.button);

Now we have everything set up the way we want it to be. With all the signal
handlers in place, and the button placed in the window where it should be, we
ask GTK+ (lines 67 and 70) to "show" the widgets on the screen. The window
widget is shown last so the whole window will pop up at once rather than seeing
the window pop up, and then the button forming inside of it. Although with such
a simple example, you'd never notice.

    this.button.show();

    this.window.show();

Lines 76-87 define the `main()` method. This is the point at which execution of
our program begins.

Line 79 creates an instance of the `HelloWorld` class and saves a reference to
it in the `hello` variable.

In line 84, we call the `Gtk.main()` function which sleeps and waits for the
user to interact with the program interface.

    Gtk.main()

Now, when we click the mouse button on a GTK+ button, the widget emits a
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
will happen. Returning `false` will cause GTK+ to emit the *"destroy"* signal
that causes the `HelloWorld` *"destroy"* callback to be called, exiting GTK.
