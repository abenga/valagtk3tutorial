The Button Widget




Normal Buttons

We've almost seen all there is to see of the button widget. It's pretty simple. 
There is however more than one way to create a button. BeYou can use the 
[CODE]new Gtk.Button.new_with_label()[/CODE] or 
[CODE]Gtk.Button.new_with_mnemonic()[/CODE] to create a button with a label, use 
[CODE]Gtk.Button.new_from_stock()[/CODE] to create a button containing the image 
and text from a stock item or use [CODE]Gtk.Button.new()[/CODE] to create a 
blank button. It's then up to you to pack a label or pixmap into this new 
button. To do this, create a new box, and then pack your objects into this box 
using the usual [CODE]Gtk.Box.pack_start()[/CODE], and then use 
[CODE]Gtk.Container.add()[/CODE] to pack the box into the button.

Here's an example of using [CODE]Gtk.Button.new()[/CODE] to create a button 
with an image and a label in it. I've broken up the code to create a box from 
the rest so you can use it in your programs. There are further examples of using 
images later in the tutorial.

[CODE]

/* 01Button.vala - Example button. */

using Gtk;

/* Create a new hbox with an image and a label packed into it
 * and return the box. */
static Gtk.HBox xpm_label_box(string xpm_filename, 
                              string label_text ) {
  Gtk.HBox box;
  Gtk.Label label;
  Gtk.Image image;

  /* Create box for image and label */
  box = new Gtk.HBox(false, 0);
  box.set_border_width(2);

  /* Now on to the image stuff */
  image = new Gtk.Image.from_file(xpm_filename);

  /* Create a label for the button */
  label = new Gtk.Label(label_text);

  /* Pack the image and label into the box */
  box.pack_start(image, false, false, 3);
  box.pack_start(label, false, false, 3);

  image.show();
  label.show();

  return box;
}

class ButtonWindow {
  
  Gtk.Window window;
  Gtk.Button button;
  Gtk.HBox box;

  /* Our usual callback function */
  void callback (string data) {
    stdout.printf("Hello again - %s was pressed\n", data);
  }

  public ButtonWindow () {

    /* Create a new window. */
    this.window = new Gtk.Window(Gtk.WindowType.TOPLEVEL);

    this.window.set_title("Pixmap'd Buttons!");

    /* It's a good idea to do this for all windows. */
    this.window.destroy.connect( ()=> { Gtk.main_quit(); } );

    this.window.delete_event.connect( ()=> { return false; } );

    /* Sets the border width of the window. */
    this.window.set_border_width(10);

    /* Create a new button. */
    this.button = new Gtk.Button();

    /* Connect the "clicked" signal of the button to our callback. */
    this.button.clicked.connect( ()=> { this.callback("cool button"); });

    /* This calls our box creating function. */
    this.box = xpm_label_box("img.png", "cool button");

    /* Pack and show all our widgets. */
    this.box.show();

    this.button.add(box);

    this.button.show();

    this.window.add(button);

    this.window.show();
    
  }
  
  public static int main (string[] args) {
    
    Gtk.init(ref args);
    new ButtonWindow();
    
    /* Rest in gtk_main and wait for the fun to begin! */
    Gtk.main ();
    
    return 0;
  }

}

[CODE]

The [CODE]xpm_label_box()[/CODE] function could be used to pack images and labels into any widget 
that can be a container.

The Button widget has the following signals:

* pressed - emitted when pointer button is pressed within Button widget

* released - emitted when pointer button is released within Button widget

* clicked - emitted when pointer button is pressed and then released within Button widget

* enter - emitted when pointer enters Button widget

* leave - emitted when pointer leaves Button widget




Toggle Buttons

Toggle buttons are derived from normal buttons and are very similar, except they 
will always be in one of two states, alternated by a click. They may be 
depressed, and when you click again, they will pop back up. Click again, and 
they will pop back down.

Toggle buttons are the basis for check buttons and radio buttons, as such, many 
of the calls used for toggle buttons are inherited by radio and check buttons. 
I will point these out when we come to them.

Creating a new toggle button:

[CODE]
Gtk. *gtk_toggle_button_new( void );

GtkWidget *gtk_toggle_button_new_with_label( const gchar *label );

GtkWidget *gtk_toggle_button_new_with_mnemonic( const gchar *label );
[/CODE]

As you can imagine, these work identically to the normal button widget calls. 
The first creates a blank toggle button, and the last two, a button with a label 
widget already packed into it. The _mnemonic() variant additionally parses the 
label for '_'-prefixed mnemonic characters.

To retrieve the state of the toggle widget, including radio and check buttons, 
we use a construct as shown in our example below. This tests the state of the 
toggle button, by accessing the active field of the toggle widget's structure, 
after first using the GTK_TOGGLE_BUTTON macro to cast the widget pointer into a 
toggle widget pointer. The signal of interest to us emitted by toggle buttons 
(the toggle button, check button, and radio button widgets) is the "toggled" 
signal. To check the state of these buttons, set up a signal handler to catch 
the toggled signal, and access the structure to determine its state. The 
callback will look something like:

[CODE]
void toggle_button_callback (GtkWidget *widget, gpointer data)
{
    if (gtk_toggle_button_get_active (GTK_TOGGLE_BUTTON (widget))) 
    {
        /* If control reaches here, the toggle button is down */
    
    } else {
    
        /* If control reaches here, the toggle button is up */
    }
}
[/CODE]

To force the state of a toggle button, and its children, the radio and check 
buttons, use this function:

[CODE]
void gtk_toggle_button_set_active( GtkToggleButton *toggle_button,
                                   gboolean        is_active );
[/CODE]

The above call can be used to set the state of the toggle button, and its 
children the radio and check buttons. Passing in your created button as the 
first argument, and a TRUE or FALSE for the second state argument to specify 
whether it should be down (depressed) or up (released). Default is up, or FALSE.

Note that when you use the gtk_toggle_button_set_active() function, and the 
state is actually changed, it causes the "clicked" and "toggled" signals to be 
emitted from the button.

[CODE]
gboolean gtk_toggle_button_get_active   (GtkToggleButton *toggle_button);
[/CODE]

This returns the current state of the toggle button as a boolean TRUE/FALSE 
value.




Check Buttons

Check buttons inherit many properties and functions from the the toggle buttons 
above, but look a little different. Rather than being buttons with text inside 
them, they are small squares with the text to the right of them. These are often 
used for toggling options on and off in applications.

The creation functions are similar to those of the normal button.

[CODE]
GtkWidget *gtk_check_button_new( void );

GtkWidget *gtk_check_button_new_with_label ( const gchar *label );

GtkWidget *gtk_check_button_new_with_mnemonic ( const gchar *label );
[/CODE]

The gtk_check_button_new_with_label() function creates a check button with a 
label beside it.

Checking the state of the check button is identical to that of the toggle button.




Radio Buttons

Radio buttons are similar to check buttons except they are grouped so that only 
one may be selected/depressed at a time. This is good for places in your 
application where you need to select from a short list of options.

Creating a new radio button is done with one of these calls:

[CODE]
GtkWidget *gtk_radio_button_new( GSList *group );

GtkWidget *gtk_radio_button_new_from_widget( GtkRadioButton *group );

GtkWidget *gtk_radio_button_new_with_label( GSList *group,
                                            const gchar  *label );

GtkWidget* gtk_radio_button_new_with_label_from_widget( GtkRadioButton *group,
                                                        const gchar    *label );

GtkWidget *gtk_radio_button_new_with_mnemonic( GSList *group,
                                               const gchar  *label );

GtkWidget *gtk_radio_button_new_with_mnemonic_from_widget( GtkRadioButton *group,
                                                           const gchar  *label );
[/CODE]

You'll notice the extra argument to these calls. They require a group to 
perform their duty properly. The first call to gtk_radio_button_new() or 
gtk_radio_button_new_with_label() should pass NULL as the first argument. Then 
create a group using:

[CODE]
GSList *gtk_radio_button_get_group( GtkRadioButton *radio_button );
[/CODE]

The important thing to remember is that gtk_radio_button_get_group() must be 
called for each new button added to the group, with the previous button passed 
in as an argument. The result is then passed into the next call to 
gtk_radio_button_new() or gtk_radio_button_new_with_label(). This allows a 
chain of buttons to be established. The example below should make this clear.

You can shorten this slightly by using the following syntax, which removes the 
need for a variable to hold the list of buttons:

[CODE]
button2 = gtk_radio_button_new_with_label(
                 gtk_radio_button_get_group (GTK_RADIO_BUTTON (button1)),
                 "button2");
[/CODE]

The _from_widget() variants of the creation functions allow you to shorten this 
further, by omitting the gtk_radio_button_get_group() call. This form is used 
in the example to create the third button:

[CODE]
     button2 = gtk_radio_button_new_with_label_from_widget(
                 GTK_RADIO_BUTTON (button1), 
                 "button2");
[/CODE]

It is also a good idea to explicitly set which button should be the default 
depressed button with:

[CODE]
void gtk_toggle_button_set_active( GtkToggleButton *toggle_button,
                                   gboolean        state );
[/CODE]

This is described in the section on toggle buttons, and works in exactly the 
same way. Once the radio buttons are grouped together, only one of the group 
may be active at a time. If the user clicks on one radio button, and then on 
another, the first radio button will first emit a "toggled" signal (to report 
becoming inactive), and then the second will emit its "toggled" signal (to 
report becoming active).

The following example creates a radio button group with three buttons.

[CODE]
#include <glib.h>
#include <gtk/gtk.h>

static gboolean close_application( GtkWidget *widget,
                                   GdkEvent  *event,
                                   gpointer   data )
{
  gtk_main_quit ();
  return FALSE;
}

int main( int   argc,
          char *argv[] )
{
    GtkWidget *window = NULL;
    GtkWidget *box1;
    GtkWidget *box2;
    GtkWidget *button;
    GtkWidget *separator;
    GSList *group;
  
    gtk_init (&argc, &argv);    
      
    window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
  
    g_signal_connect (window, "delete-event",
                      G_CALLBACK (close_application),
                      NULL);

    gtk_window_set_title (GTK_WINDOW (window), "radio buttons");
    gtk_container_set_border_width (GTK_CONTAINER (window), 0);

    box1 = gtk_vbox_new (FALSE, 0);
    gtk_container_add (GTK_CONTAINER (window), box1);
    gtk_widget_show (box1);

    box2 = gtk_vbox_new (FALSE, 10);
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10);
    gtk_box_pack_start (GTK_BOX (box1), box2, TRUE, TRUE, 0);
    gtk_widget_show (box2);

    button = gtk_radio_button_new_with_label (NULL, "button1");
    gtk_box_pack_start (GTK_BOX (box2), button, TRUE, TRUE, 0);
    gtk_widget_show (button);

    group = gtk_radio_button_get_group (GTK_RADIO_BUTTON (button));
    button = gtk_radio_button_new_with_label (group, "button2");
    gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (button), TRUE);
    gtk_box_pack_start (GTK_BOX (box2), button, TRUE, TRUE, 0);
    gtk_widget_show (button);

    button = gtk_radio_button_new_with_label_from_widget (GTK_RADIO_BUTTON (button),
                                                          "button3");
    gtk_box_pack_start (GTK_BOX (box2), button, TRUE, TRUE, 0);
    gtk_widget_show (button);

    separator = gtk_hseparator_new ();
    gtk_box_pack_start (GTK_BOX (box1), separator, FALSE, TRUE, 0);
    gtk_widget_show (separator);

    box2 = gtk_vbox_new (FALSE, 10);
    gtk_container_set_border_width (GTK_CONTAINER (box2), 10);
    gtk_box_pack_start (GTK_BOX (box1), box2, FALSE, TRUE, 0);
    gtk_widget_show (box2);

    button = gtk_button_new_with_label ("close");
    g_signal_connect_swapped (button, "clicked",
                              G_CALLBACK (close_application),
                              window);
    gtk_box_pack_start (GTK_BOX (box2), button, TRUE, TRUE, 0);
    gtk_widget_set_can_default (button, TRUE);
    gtk_widget_grab_default (button);
    gtk_widget_show (button);
    gtk_widget_show (window);
     
    gtk_main ();

    return 0;
}
[/CODE]
