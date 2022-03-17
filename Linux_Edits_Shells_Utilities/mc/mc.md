# Path Relativo
Linux_Edits_Shells_Utilities/mc/mc.md

# Midnight Commander Install

https://www.youtube.com/watch?v=SqhoPBkS0KE&list=PL6ubK4uhF2NVmtgKwTDsIEJNBPUgPxgWL&index=16

sudo apt-get install mc (rbp)
o
sudo apt install mc (linux ubuntu)

|   Key        | Description of function   |
|------------- |-------------------------  |
| Ctrl+Insert  | Copy text in Editor       |
| Shift+Insert | Paste text in Editor      |
| F9+o         | Panel Options             |
| Ctrl+\       | Directory HotList         |
| F10          | Salir                     |
| Esc+0        | Salir                     |
| F9           | Menu                      |
| Alt+s        | Search                    |
| Esc+s        | Search                    |
| Ctrl+o       | Hide/Show mc              |
| TAB          | Cambiar de Panel          |
| SHIFTt+↑/↓   | Select Files              |
| +,-,\*       | Select Files              |
| +            | Select Group of File      |
| /            | DeSelect Group of files   |
| Alt+.        | Hide/Unhide Hidden Files  |
| Alt + i      | Same dir ambos paneles    |
| Ctrl - u     | Cambiar los paneles       |
| cd           | Home directory            |
| F3           | Ver Visor Interno         |
| F4           | Editor                    |
| F5           | Copy                      |
| Insert       | Select/deselect curr file |
| Alt + ,      | Cambiar Layout Horizontal |
| Ctrl + r     | Refresh Panel             |
| Esc+Enter    | C.FileName to CommandLine |
| Alt+?        | Find File                 |
| SHIFT+F6     | Rename File               |

## Cambiar default editor mc
https://unix.stackexchange.com/questions/80845/how-to-set-default-editor-viewer-for-midnight-commander-to-sublime

## Global setting for all programs that use `EDITOR` (not recommended):
```
EDITOR=sublime
export EDITOR
```

## Temporary setting for the given Midnight Commander session only:
```
alias mc='EDITOR=sublime mc'
alias mc='EDITOR=nano mc'
alias mc='EDITOR=vim mc'
alias mc='EDITOR=micro mc'
```
La forma mas facil de escoger el editor es:
Run MC as usual. On the command line right above the bottom row of menu selections type:
`select-editor`


1. incluir uno de estos alias en .bashrc
2. para reiniciar .bashrc una vez que lo hayamos actualizado, reiniciarlo con:

```
source ~/.bashrc
```



## Midnight Commander Oficial Documentation

[https://midnight-commander.org/wiki/doc](https://midnight-commander.org/wiki/doc)

## Midnight Commander

[http://linuxcommand.org/lc3\_adv\_mc.php#:\~:text=The%20Directory%20Hotlist,displayed%20by%20pressing%20Ctrl%2D%5C%20.&text=To%20add%20a%20directory%20to,and%20type%20Ctrl%2Dx%20h%20.](http://linuxcommand.org/lc3_adv_mc.php#:~:text=The%20Directory%20Hotlist,displayed%20by%20pressing%20Ctrl%2D%5C%20.&text=To%20add%20a%20directory%20to,and%20type%20Ctrl%2Dx%20h%20.)

## color scheme

[https://midnight-commander.org/wiki/doc/common/skins](https://midnight-commander.org/wiki/doc/common/skins)
# HotKeys Oficial

[https://midnight-commander.org/wiki/doc/filePanels/hotkeys](https://midnight-commander.org/wiki/doc/filePanels/hotkeys)

|  |  |
| --- | --- |
| *F3* | View file. |
| *F4* | Edit file. |
| *F13* | View raw file without extension specific. |
| *F14* | Create new file. |
| *F19* | Activate last used menu element. |
| *F20* | Quiet exit, without confirmation. |
| *Insert* | Select 'current object'<sup>1</sup> |
| *+* | select a group of files. (regular expression can be used) |
| \*\* | Unselect a group of files. This is the opposite of the Plus key. |
| *Meta+Enter* | Insert 'current object'<sup>1</sup> to command line. |
| *Meta+.* | Show/hidde hidden files and directories (that starts with '.'). |
| *Meta+,* | Change panel split view mode to vertical/horizontal. |
| *Meta+a*<br>*Ctrl+x,p* | Insert in command line path of active panel. |
| *Meta+c* | Displays change directory dialog for active panel. |
| *Meta+h* | Displays command history. |
| *Meta+i* | Make the current directory of the current panel also the current directory of the other panel. Put the other panel to the listing mode if needed. If the current panel is panelized, the other panel doesn't become panelized. |
| *Meta+n*<br>*Meta+p* | Use these keys to browse through the command history. Meta-p takes you to the last entry, Meta-n takes you to the next one. |
| *Meta+o* | If the currently selected file is a directory, load that directory on the other panel and moves the selection to the next file. |
| *Meta+g*<br>*Meta+r*<br>*Meta+j* | Used to select the top/middle/bottom file in a panel repectively |
| *Meta+t* | Change panel view ('Full','Brief','Long') |
| *Meta+Shift+?* | Find file. |
| *Meta+Shift+A*<br>*Ctrl+x,Ctrl+p* | Insert to command line inactive panel path. |
| *Meta+Shift+H* | Display directory history. |
| Ctrl+\ | Display directory hotlist. |
| *Ctrl+l* | Repaint all information in midnight commander. |
| *Ctrl+o* | Show/hida panell. |
| *Ctrl+r* | Reread content of current directory. |
| *Ctrl+s* | Quick search. |
| *Ctrl+Space* | Show directory size. |
| *Ctrl+x,a* | Show active VFS list. |
| *Ctrl+x,c* | Chmod (Change file Mode) for file or directory. |
| *Ctrl+x,i* | Set the other panel display mode to information. |
| *Ctrl+x,j* | Show background jobs. |
| *Ctrl+x,l* | Create hardlink for active file or directory. |
| *Ctrl+x,o* | Chown (Change Owner) for file or directory. |
| *Ctrl+x,q* | Set the other panel display mode to quick view. |
| *Ctrl+x,s* | Create symlink for active file or directory. |
| *Ctrl+x,t* | Insert selected names to command line. |
| *Ctrl+x,Ctrl+s* | Edit symlink. |

