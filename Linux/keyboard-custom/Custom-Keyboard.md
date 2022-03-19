# Path Relativo
Linux/keyboard-custom/Custom-Keyboard.md

# Custom keyboard layout definitions
https://help.ubuntu.com/community/Custom%20keyboard%20layout%20definitions?action=show&redirect=Howto%3A+Custom+keyboard+layout+definitions


# Introduction

This tutorial will introduce you to the basics of modifying and creating custom keyboard layouts for use with the system-standard gnome-keyboard-properties application (usually accessed through System->Preferences->Keyboads). 

--------------

# What are the steps needed to create new keyboard layout on ubuntu?
https://askubuntu.com/questions/510024/what-are-the-steps-needed-to-create-new-keyboard-layout-on-ubuntu

This entry maps a key on the keyboard to a number of specific characters using the following conventions:

    <A C01> The first letter A indicates we are looking in the alphanumeric key block (other options include KP [for keypad] and FK [for Function Key]);

    <A C 01> The second letter C indicates the row, counting from the bottom in which the key is found. (In a standard US keyboard, the space bar is in row AA and the number keys are in row AE).

    <AC 01> The numbers 01 indicates the position of the key, counting from the left and ignoring any specially named key like TAB or ~ (tilde): AC01 is in the third row up, first key over from the left (ignoring Caps Lock, if present); on a standard US keyboard, this is the key marked “a”.

    The brackets enclose the list of characters assigned to each key. This contains up to four entries, separated by commas:
        a - The unmodified key.
        A - The Shift character.
        á - The Alt Gr character. (aacute)
        Á - The Shift+Alt Gr character. (Aacute)

# Para dar los acentos estar en español y:
    
    Ctrl(derecho)+vocal (soltar control) + ' = resultado es ó

    Ctrl(derecho)+o soltar control y + ' y resultado es: ó

    Y asi con las demas vocales









