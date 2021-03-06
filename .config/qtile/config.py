from typing import List  # noqa: F401
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

COLORS = {
    "dark_blue": "#282c34",
    "light_blue": "#3d5a80",
    "orange": "#ee6c4d",
    "red": "#f43333",
    "blue": "#7b92ed",
    "green": "#7bed8a",
}

ICONS_PATH = "~/.config/qtile/icons/"
icons = {
    "logo": f"{ICONS_PATH}logo.svg",
}
# egrave, underscore, ccedilla
Windows_details = {
    "ampersand": "  ",
    "eacute": "  ",
    "quotedbl": "  ",
    "apostrophe": "  ",
    "parenleft": "  ",
    "minus": "  ",
}

mod = "mod4"
terminal = guess_terminal()

keyboard_shortcut = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    # Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # start rofi launcher
    Key(
        [mod],
        "space",
        lazy.spawn("/home/hakouguelfen/.config/rofi/bin/launcher_colorful"),
        desc="launch rofi",
    ),

    # start apps
    Key([mod], "b", lazy.spawn("brave-browser-nightly"), desc="Launch brave"),
    Key([mod], "e", lazy.spawn("emacsclient -nc"), desc="Launch emacs"),
    Key([mod], "s", lazy.spawn("spotify"), desc="Launch spotify"),
    Key([mod], "f", lazy.spawn("flameshot launcher"), desc="Launch flameshot"),
    Key([mod], "m", lazy.spawn("mailspring launcher"), desc="Launch mailSpring"),
    Key([mod], "l", lazy.spawn("slock"), desc="Launch slock"),

    # volumes
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 -q set Master 2dB+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 -q set Master 2dB-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer set Master toggle")),

    # brightness
    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 5")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 5")),
]

widgets = [
    widget.Sep(padding=5, foreground=COLORS['dark_blue']),
    widget.Image(filename=icons["logo"]),

    widget.GroupBox(
        this_current_screen_border=COLORS['dark_blue'],
        block_highlight_text_color=COLORS['orange'],
        highlight_method='block',
        fontsize=16,
        active=COLORS['light_blue'],
    ),

    widget.Spacer(),

    widget.Clock(
        format='%a %d %b ,',
        padding=7,
    ),
    widget.Clock(
        format='%I:%M',
    ),

    widget.Spacer(),

    widget.Sep(
        linewidth=7, foreground=COLORS['dark_blue']),

    # WIFI widget
    widget.TextBox(
        '',
        fontsize='16',
        foreground=COLORS['blue'],
    ),
    widget.Wlan(
        interface="wlp3s0",
        format='{essid}',
        foreground=COLORS['blue'],

    ),

    widget.Sep(
        linewidth=20, foreground=COLORS['dark_blue']),

    widget.TextBox(
        '',
        fontsize='18',
        foreground=COLORS['green'],

    ),
    #  up  mute  down
    widget.Volume(
        step=5,
        foreground=COLORS['green'],
        font='MesloLGS NF'
    ),

    # widget.Backlight(
    #     background=COLORS['red'],
    #     brightness_name='light',
    #     brightness_file='/bin/light',
    #     change_command='light',
    # ),

    widget.Sep(linewidth=5, foreground=COLORS['dark_blue']),

    widget.QuickExit(
        foreground=COLORS['red'],
        default_text='',
        countdown_format='',
        countdown_start=1,
        padding=15,
        fontsize=16,
    ),
]

keys = keyboard_shortcut

# switch between windows
for command, icon in Windows_details.items():
    keys.append(Key([mod], command, lazy.group[icon].toscreen()))
    keys.append(Key([mod, 'shift'], command, lazy.window.togroup(icon)))

groups = [Group(icon) for icon in Windows_details.values()]

layouts = [layout.Columns(
    margin=4,
    border_focus="#3c4541",
    border_normal='#3c4541',
    border_width=1
)]


widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


screens = [
    Screen(
        top=bar.Bar(
            widgets,
            size=30,
            margin=5,
            background=COLORS['dark_blue'],
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
