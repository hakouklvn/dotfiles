from libqtile import widget
from themes import COLORS, icons

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
