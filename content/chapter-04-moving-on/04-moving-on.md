# Moving On

## Vala Data Types

Vala supports four kinds of data types: value types, reference types,
parametrized types, and pointer types. Value types include simple types (e.g.
`char`, `int`, and `float`), enum types, and struct types. Reference types
include object types, array types, delegate types, and error types.

### Value Types

Value types differ from reference types in that instances of value types are
stored directly in variables or fields that represent them. Whenever a value
type instance is assigned to another variable or field, the default action is to
duplicate the value, such that each identifier refers to a unique copy of the
data, over which it has ownership. When a value type is instantiated in a
method, the instance is created on the stack.

Value types include the boolean type, integral types, the floating-point types,
and enumerated types.

The boolean type, `bool`, can have values of `true` or `false`.

Integral types can contain only integers. They are either signed or unsigned,
each of which is considered a different type, though it is possible to cast
between them when needed. Some types define exactly how many bits of storage are
used to represent the integer e.g. `uint8`, `int64`, etc. Others depend on the
environment, for example `long`, `int`, `short` map to C data types and therefore
depend on the machine architecture. A `char` is 1 byte wide and can represent
one of 256 values. A `unichar` is 4 bytes wide, i.e. large enough to store any
[UTF-8](http://en.wikipedia.org/wiki/UTF-8) character.

Floating point types are used to represent contain irrational floating point
numbers in a fixed number of bits. There are two floating point types: `float`
and `double`.

An enumerated type is one in which all possible values that instances of the
type can hold are declared with the type.

### Reference Types

Variables of reference types contain references to the instances, rather than
the instances themselves. Assinging an instance of a reference type to a
variable or field will not make a copy of the data, instead only the reference
to the data is copied. This means that both variables will refer to the same
data, and so changes made to that data using one of the references will be
visible when using the other. Instances of reference types are always stored on
the heap (the part of memory that is dynamically allocated during a program's
run time).

When a variable that is an instance of a reference variable goes out of scope,
the fact that a reference to the instance has been removed is also recorded.
This means that a reference variable can be automatically removed from memory
when it is no longer needed.

Reference types include classes, arrays, delegates, errors and strings.

A **class** definition introduces a new reference type - this is the most common
way of creating a new type in Vala. A class is definition of a new data type. A
class can contain fields, constants, methods, properties, and signals. Class
types support *inheritance*, a mechanism whereby a derived class can extend and
specialize a base class. Vala supports three different types of classes, namely:

* GObject subclasses, which inherit directly from `GLib.Object`, and are the
  most powerful type of class.

* Fundamental GType classes are those either without any superclass or that
  don't inherit at any level from `GLib.Object`. These classes support
  inheritence, interfaces, virtual methods, reference counting, unmanaged
  properties, and private fields. They are instantiated faster than GObject
  subclasses but are less powerful.

* Compact classes, so called because they use less memory per instance, are the
  least featured of all class types. They are not registered with the GType
  system and do not support reference counting, virtual methods, or private
  fields. Such classes are very fast to instantiate but not massively useful
  except when dealing with existing libraries. They are declared using the
  `Compact` attribute on the class.


An **array** is a data structure that can contains zero or more elements of the
same type, up to a limit defined by the type.

A **delegate** is a data structure that refers to a method. A method executes in
a given scope which is also stored, meaning that for instance methods a delegate
will contain also a reference to the instance.

Instances of **error** types represent recoverable runtime errors. All errors
are described using error domains, a type of enumerated value, but errors
themselves are not enumerated types.

Vala has built in support for Unicode strings, via the fundamental `string` type.
This is the only fundamental type that is a reference type. Like other
fundamental types, it can be instantiated with a literal expression. Strings are
UTF-8 encoded which means that they cannot be accessed like character arrays in
C since it is not guaranteed that each Unicode character will be stored in just
one byte. Instead, the string fundamental struct type (which all strings are
instances of) provides access methods along with other tools.


### Parameterized Types

Vala allows definitions of types that can be customised at runtime with type
parameters. For example, a list can be defined so that it can be instantiated 
as a list of ints, a list of Objects, etc. This is achieved using generic
declarations.

### Pointer types

The name of a type can be used to implicitly create a pointer type related to
that type. The value of a variable declared as being of type `T*` represents the
memory address of an instance of type `T`. The instance is never made aware that
its address has been recorded, and so cannot record the fact that it is referred
to in this way.

Instances of any type can be assigned to a variable that is declared to be a
pointer to an instance of that type. For referenced types, direct assignment is
allowed in either direction. For value types the pointer-to operator **`&`**
is required to assign to a pointer, and the pointer-indirection operator **`*`**
is used to access the instance pointed to.

The `void*` type represents a pointer to an unknown type. As the referred type
is unknown, the indirection operator cannot be applied to a pointer of type
`void*`, nor can any arithmetic be performed on such a pointer. However, a
pointer of type `void*` can be cast to any other pointer type (and vice-versa)
and compared to values of other pointer types.

### Nullable Types

There is another characterization of types, *nullable types*. The name of a type
can be used to implicitly create a nullable type related to that type. An
instance of a nullable type `T?` can either be a value of type `T` or `null`.
A nullable type will have either value or reference type semantics, depending on
the type it is based on.



## An Upgraded Hello World

Let us now take a look at a slightly improved `helloworld` with better examples
of callbacks. This will also introduce us to our next topic, packing widgets.

    class HelloWorld : Gtk.Window {
  
      private Gtk.Button button1;
      private Gtk.Button button2;
      private Gtk.Box box;
      
      /* Our new improved callback.  The data passed to this function
       * is printed to stdout. */
      void callback(string data) {
        stdout.printf("Hello! - %s was pressed\n", data);
      }

      /* another callback */
      bool on_delete_event() {
        Gtk.main_quit();
        return false;
      }
      
      public HelloWorld () {
        

        /* This is a new call, which just sets the title of our
         * new window to "Hello Buttons!" */
        this.set_title("Hello Buttons!");

        /* Here we just set a handler for delete_event that immediately
         * exits GTK. */
        this.delete_event.connect(this.on_delete_event);

        /* Sets the border width of the window. */
        this.set_border_width(10);

        /* We create a box to pack widgets into.  This is described 
         * in detail in the "packing" section. The box is not really 
         * visible, it is just used as a tool to arrange widgets. */
        box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);

        /* Put the box into the main window. */
        this.add(box);

        /* Creates a new button with the label "Button 1". */
        this.button1 = new Gtk.Button.with_label("Button 1");
        
        /* Now when the button is clicked, we call the "callback" function
         * with a pointer to "button 1" as its argument */
        this.button1.clicked.connect (() => { this.callback("Button 1"); });  

        /* Instead of gtk_container_add, we pack this button into the 
         * invisible box, which has been packed into the window. */
        box.pack_start(button1, true, true, 0);

        /* Always remember this step, this tells GTK that our preparation 
         * for this button is complete, and it can now be displayed. */
        button1.show();

        /* Do these same steps again to create a second button */
        this.button2 = new Gtk.Button.with_label("Button 2");

        /* Call the same callback function with a different argument,
           passing a pointer to "button 2" instead. */
        this.button2.clicked.connect (() => { this.callback("Button 2"); }); 

        box.pack_start(button2, true, true, 0);

        /* The order in which we show the buttons is not really important, 
         * but we recommend showing the window last, so it all pops up at 
         * once. */
        button2.show();

        box.show();

      }
      
      public static int main (string[] args) {
        /* This is called in all GTK applications. Arguments are parsed
         * from the command line and are returned to the application. */
        Gtk.init (ref args);
        
        var hello = new HelloWorld();

        hello.show();
        
        /* Rest in gtk_main and wait for the fun to begin! */
        Gtk.main();
        
        return 0;
      }  
    }

Compiling and running the code produces the window below, *"Upgraded Hello World
Example"*.

<figure>
  <img src="https://lh6.googleusercontent.com/-cYMmX6rJU38/Uf-1in36tbI/AAAAAAAAAEk/Al6pmI2Cr2A/w484-h212-no/01_upgradedhelloworld.png" alt="Upgraded Hello World Example" title="Upgraded Hello World Example">
  <figcaption>Upgraded Hello World Example</figcaption>
</figure>

You'll notice this time there is no way to exit the program except to use your
window manager or command line to kill it. A good exercise for the reader would
be to insert a third "Quit" button that will exit the program. You may also wish
to play with the options to `pack_start()` while reading the next section. Try
resizing the window, and observe the behavior.

A short commentary on the code differences from the first *Hello World* program
is in order.

As noted above there is no "destroy" event handler in the upgraded *Hello World*.

The lines

    void callback(string data) {
      stdout.printf("Hello! - %s was pressed\n", data);
    }

define a callback method which is similar to the `hello()` callback
in the first helloworld. The difference is that the callback prints a message
including data passed in.

The line

    this.set_title("Hello Buttons!");

sets a title string to be used on the titlebar of the window, as seen in
the screenshot above.

The line

    box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);

creates a horizontal box (`Gtk.Box`) to hold the two buttons that are
created in the lines

    this.button1 = new Gtk.Button.with_label("Button 1");
    this.button2 = new Gtk.Button.with_label("Button 2");

The line

    this.window.add(box);

adds the horizontal box to the window container.

The lines

    this.button1.clicked.connect (() => { this.callback("Button 1"); });
    this.button2.clicked.connect (() => { this.callback("Button 2"); });

connect the `callback()` method to the "clicked" signal of the buttons. Each
button sets up a different string to be passed to the `callback()` method when
invoked.

The lines

    box.pack_start(button1, true, true, 0);
    box.pack_start(button2, true, true, 0);

pack the buttons into the horizontal box. The lines

    button1.show();
    button2.show();

ask GTK to display the buttons.

The lines

    box.show();

ask GTK to display the box and the window respectively.

The window is shown by the line 

    hello.show();

in `main()`.