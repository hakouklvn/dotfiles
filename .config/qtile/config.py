from typing import List  # noqa: F401

import subprocess
import os
from libqtile import hook

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen, DropDown, ScratchPad
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

import yaml

setting = "/home/hakouguelfen/.config/theme/setting.yaml"

DARK = {
    "background": "#282c34",
    "foreground": "#bbc2cf",
    "inactive":"#404040",
    "red": "#f43333",
    "blue": "#7b92ed",
    "purple": "#F28FADff",
    "YELLOW": "#FAE3B0ff",
    "green": "#ABE9B3ff",
}
LIGHT = {
    "background": "#fafafa",
    "foreground": "#34393d",
    "inactive": "#c8c8c8",
    "red": "#f43333",
    "blue": "#5666a5",
    "purple": "#ea4a7b",
    "YELLOW": "#f7d280",
    "green": "#6ed97c",
}

COLORS = DARK

try:
    with open(setting) as setting_file:
        data = yaml.safe_load(setting_file)
    if data["setting"]["qtile"] == "LIGHT":
        COLORS = LIGHT
    else:
        COLORS = DARK
except Exception as e:
    subprocess.run(["notify-send", "Qtile YAML Data", str(e)])

ICONS_PATH = "~/.config/qtile/icons/"
icons = {
    "logo": f"{ICONS_PATH}logo.svg",
}
# egrave, underscore, ccedilla
# myWorkspaces = ["\58368", "\58369", "\58363", "\58365", "\58366", "\58367"]
Windows_details = {
    "ampersand": " ",
    "eacute": " ",
    "quotedbl": " ",
    "apostrophe": " ",
    "parenleft": " ",
    "minus": " ",
    }

mod = "mod4"
mod1 = "mod1"
terminal = guess_terminal()

scriptsDir = '.local/bin/scripts/'
keyboard_shortcut = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
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
    Key([mod, "shift"], "f", lazy.window.toggle_fullscreen()),

    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    #######################################################################
    # Dmenu scripts launched using the key chord SUPER+c followed by 'key'
    KeyChord([mod], "c", [
        Key([], "d", lazy.spawn(f"{scriptsDir}docs.sh"), desc='List all pdf'),
        Key([], "k", lazy.spawn(f"{scriptsDir}killproccess.sh"), desc='kill running proccess'),
        Key([], "a", lazy.spawn(f"{scriptsDir}archwiki.sh"), desc='list archwiki docs'),
        Key([], "w", lazy.spawn(f"{scriptsDir}wifi.sh"), desc='connect to wifi'),
        Key([], "s", lazy.spawn(f"{scriptsDir}surf.sh"), desc='surf the web'),
        Key([], "g", lazy.spawn(f"{scriptsDir}github.sh"), desc='search github repos'),
        # Key([], "t", lazy.spawn(f"python {scriptsDir}theme.py"), desc='change system theme'),
        Key([], "p", lazy.spawn(f"{scriptsDir}power.sh"), desc='power setting'),
        Key([], "t", lazy.spawn(f"{scriptsDir}tv.sh"), desc='watch tv'),
    ]),
    #######################################################################
    # start apps
    Key(
        [mod],
        "space",
        lazy.spawn("rofi -show drun"),
        desc="launch rofi",
    ),
    Key([mod], "b", lazy.spawn("brave-browser-nightly"), desc="Launch brave"),
    Key([mod], "e", lazy.spawn('emacsclient -c -a emacs'), desc="Launch emacs"),
    Key([mod], "s", lazy.spawn("spotify"), desc="Launch spotify"),
    Key([mod], "f", lazy.spawn("flameshot launcher"), desc="Launch flameshot"),
    Key([mod], "m", lazy.spawn("mailspring launcher"), desc="Launch mailSpring"),
    # Key([mod], "l", lazy.spawn("sh /opt/disable_all_functions.sh"), desc="Launch slock"),

    # volumes
    Key([], "XF86AudioRaiseVolume", lazy.spawn("sh .config/dunst/scripts/vol.sh 2dB+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("sh .config/dunst/scripts/vol.sh 2dB-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer sset Master toggle")),

    # brightness
    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 5")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 5")),

    # keyboard layout
    Key([mod1, "shift"], "Return", lazy.spawn(f"{scriptsDir}keyboard.sh")),
]

widgets = [
    widget.Sep(padding=5, foreground=COLORS['background']),

    widget.GroupBox(
        this_current_screen_border=COLORS['background'],
        block_highlight_text_color=COLORS['purple'],
        highlight_method='block',
        fontsize=16,
        active=COLORS['foreground'],
        inactive=COLORS['inactive']
    ),

    widget.Sep(linewidth=7, foreground=COLORS['background']),
    widget.CurrentLayout(fmt='[{}]', foreground=COLORS['purple']),

    widget.Spacer(),
    widget.WindowName(foreground=COLORS['foreground']),
    widget.Spacer(),

    # Battery
    widget.Sep(linewidth=7, foreground=COLORS['background']),
    widget.Battery(
        format='{char} {percent:2.0%}  ',
        discharge_char="",
        charge_char="🌩",
        full_char=" ",
        low_percentage=0.2,
        fontsize=20,
        foreground=COLORS['foreground'],
    ),
    # BLUETOOTH
    # widget.Sep(linewidth=7, foreground=COLORS['background']),
    # widget.TextBox(
    #     '',
    #     fontsize=20,
    #     foreground=COLORS['foreground'],
    # ),
    # widget.Bluetooth(
    #     hci0="dev_00_02_00_00_0F_60",
    #     fontsize=14,
    # ),

    # WIFI
    widget.Sep(linewidth=7, foreground=COLORS['background']),
    widget.TextBox(
        ' ',
        fontsize=25,
        foreground=COLORS['foreground'],
    ),
    widget.Wlan(
        interface="wlp0s20f3",
        format='{essid}',
        foreground=COLORS['foreground'],
    ),

    # VOLUME  up  mute  down
    widget.Sep(linewidth=20, foreground=COLORS['background']),
    widget.TextBox(
        '',
        fontsize=25,
        foreground=COLORS['foreground'],
    ),
    widget.Volume(
        foreground=COLORS['foreground'],
    ),

    # CLOCK
    widget.Sep(linewidth=20, foreground=COLORS['background']),
    widget.Clock(
        format="%I:%M",
        foreground=COLORS['foreground']
    ),
    widget.Sep(linewidth=20, foreground=COLORS['background']),
    widget.Systray(),
    widget.Sep(linewidth=10, foreground=COLORS['background']),
]

keys = keyboard_shortcut

# switch between windows
for command, icon in Windows_details.items():
    keys.append(Key([mod], command, lazy.group[icon].toscreen()))
    keys.append(Key([mod, 'shift'], command, lazy.window.togroup(icon)))

groups = [Group(icon) for icon in Windows_details.values()]
groups.append(
    ScratchPad("scratchpad", [
        DropDown("term", terminal)
    ])
)

# Layouts: [Columns, Floating]
layouts = [
    layout.Columns(
        margin=1,
        border_focus="#3c4541",
        border_normal='#3c2541',
        border_width=0
    ),
]


widget_defaults = dict(
    font='Fira Code',
    fontsize=16,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            widgets,
            size=32,
            background=COLORS['background'],
        ),
    ),
]

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~/.config/qtile/scripts/autostart.sh');
    subprocess.Popen([home])

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
