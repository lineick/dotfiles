## Known Problem

When installing the pop-shell extension not all of the keyboard shortcuts where registered, so I could not deactivate tiling (which is on `Super Y` and on my splitboard layout often triggered on accident).

For new installs following the [setup](https://support.system76.com/articles/pop-shell/) they hopefully fixed it otherwise do the following as proposed [here](https://github.com/pop-os/shell/discussions/1090#discussioncomment-7094925):

0. cd into the pop-shell git repo
1. `sudo cp schemas/org.gnome.shell.extensions.pop-shell.gschema.xml /usr/share/glib-2.0/schemas`
2. `sudo cp keybindings/*.xml /usr/share/gnome-control-center/keybindings`
3. `cd /usr/share/glib-2.0/schemas`
4. `sudo glib-compile-schemas .`

Then you can change the shortcuts for `toggle-tiling` etc. as usual in the settings. I deactivated it fully.



