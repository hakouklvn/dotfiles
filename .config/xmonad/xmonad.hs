import XMonad
import Data.Monoid
import System.Exit

import XMonad.Layout.ThreeColumns

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageHelpers

import XMonad.Util.Loggers
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce

import qualified Data.Map as M
import qualified XMonad.StackSet as W

import Graphics.X11.ExtraTypes.XF86

myTerminal = "alacritty"
myModMask = mod4Mask
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#dddddd"

myWorkspaces = ["\58368", "\58369", "\58363", "\58365", "\58366", "\58367"]
workspacesNames = [xK_ampersand, xK_eacute, xK_quotedbl, xK_apostrophe, xK_parenleft, xK_minus]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- close focused window
    , ((modm,               xK_q     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_p ), sendMessage NextLayout)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm .|. shiftMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart")
    ]

     -- start apps
    ++
    [
     ((modm, xK_space), spawn "rofi -show drun"),
     ((modm, xK_b), spawn "brave-browser-nightly"),
     ((modm, xK_e), spawn "emacsclient -c -a emacs"),
     ((modm, xK_s), spawn "spotify"),
     ((modm, xK_f), spawn "flameshot launcher"),
     ((modm, xK_m), spawn "mailspring launcher")
    ]

    -- volumes
    ++
    [
     ((0, xF86XK_AudioRaiseVolume), spawn "sh .config/dunst/scripts/vol.sh 2dB+"),
     ((0, xF86XK_AudioLowerVolume), spawn "sh .config/dunst/scripts/vol.sh 2dB-"),
     ((0, xF86XK_AudioMute), spawn "amixer -D pulse set Master toggle")
    ]

    -- brightness
    ++
    [
     ((0, xF86XK_MonBrightnessDown), spawn "light -U 5"),
     ((0, xF86XK_MonBrightnessUp), spawn "light -A 5")
    ]

    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) workspacesNames
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom &"
  spawnOnce "lxsession &"
  spawnOnce "dunst &"
  spawnOnce "emacs --daemon &"
  spawnOnce "conky -c .config/conky/conky.conkyrc &"
  spawnOnce "discord --start-minimized &"
  spawnOnce "udiskie &"

myLayoutHook = avoidStruts (tiled ||| Full)
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = purple " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = purple . wrap " " ""
    , ppHidden          = blue . wrap " " ""
    , ppHiddenNoWindows = grey . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . purple . ppWindow
    formatUnfocused = wrap (grey "[") (grey "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    grey, red, blue, purple, yellow, green, white :: String -> String

    grey  = xmobarColor "#404040" ""
    red      = xmobarColor "#f43333" ""
    blue     = xmobarColor "#7b92ed" ""
    purple     = xmobarColor "#F28FADff" ""
    yellow   = xmobarColor "#FAE3B0ff" ""
    green   = xmobarColor "#ABE9B3ff" ""
    white    = xmobarColor "#f8f8f2" ""

main :: IO ()
main = xmonad
     . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
     $ myDefaults

myDefaults = def
  {
    terminal = myTerminal,
    modMask = myModMask,
    layoutHook = myLayoutHook,
    startupHook = myStartupHook,
    keys= myKeys,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,
    workspaces = myWorkspaces
  }

-- ------------------------------------------------------------------------
-- -- Mouse bindings: default actions bound to mouse events
-- --
-- myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

--     -- mod-button1, Set the window to floating mode and move by dragging
--     [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
--                                        >> windows W.shiftMaster))

--     -- mod-button2, Raise the window to the top of the stack
--     , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

--     -- mod-button3, Set the window to floating mode and resize by dragging
--     , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
--                                        >> windows W.shiftMaster))

--     -- you may also bind events to the mouse scroll wheel (button4 and button5)
--     ]

-- ------------------------------------------------------------------------
-- -- Layouts:

-- -- You can specify and transform your layouts by modifying these values.
-- -- If you change layout bindings be sure to use 'mod-shift-space' after
-- -- restarting (with 'mod-q') to reset your layout state to the new
-- -- defaults, as xmonad preserves your old layout settings by default.
-- --
-- -- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- -- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- -- Instead use the 'ewmh' function from that module to modify your
-- -- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- -- startupHook ewmh notes.)
-- --
-- -- The available layouts.  Note that each layout is separated by |||,
-- -- which denotes layout choice.
-- --
-- myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
--   where
--     -- default tiling algorithm partitions the screen into two panes
--     tiled   = Tall nmaster delta ratio

--     -- The default number of windows in the master pane
--     nmaster = 1

--     -- Default proportion of screen occupied by master pane
--     ratio   = 1/2

--     -- Percent of screen to increment by when resizing panes
--     delta   = 3/100

-- ------------------------------------------------------------------------
-- -- Window rules:

-- -- Execute arbitrary actions and WindowSet manipulations when managing
-- -- a new window. You can use this to, for example, always float a
-- -- particular program, or have a client always appear on a particular
-- -- workspace.
-- --
-- -- To find the property name associated with a program, use
-- -- > xprop | grep WM_CLASS
-- -- and click on the client you're interested in.
-- --
-- -- To match on the WM_NAME, you can use 'title' in the same way that
-- -- 'className' and 'resource' are used below.
-- --
-- myManageHook = composeAll
--     [ className =? "MPlayer"        --> doFloat
--     , className =? "Gimp"           --> doFloat
--     , resource  =? "desktop_window" --> doIgnore
--     , resource  =? "kdesktop"       --> doIgnore ]

-- ------------------------------------------------------------------------
-- -- Event handling

-- -- Defines a custom handler function for X Events. The function should
-- -- return (All True) if the default handler is to be run afterwards. To
-- -- combine event hooks use mappend or mconcat from Data.Monoid.
-- --
-- -- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- -- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- -- It will add EWMH event handling to your custom event hooks by
-- -- combining them with ewmhDesktopsEventHook.
-- --
-- myEventHook = mempty

-- ------------------------------------------------------------------------
-- -- Status bars and logging

-- -- Perform an arbitrary action on each internal state change or X event.
-- -- See the 'XMonad.Hooks.DynamicLog' extension for examples.
-- --
-- --
-- -- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- -- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- -- It will add EWMH logHook actions to your custom log hook by
-- -- combining it with ewmhDesktopsLogHook.
-- --
-- myLogHook = return ()

-- ------------------------------------------------------------------------
-- -- Startup hook

-- -- Perform an arbitrary action each time xmonad starts or is restarted
-- -- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- -- per-workspace layout choices.
-- --
-- -- By default, do nothing.
-- --
-- -- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- -- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- -- It will add initialization of EWMH support to your custom startup
-- -- hook by combining it with ewmhDesktopsStartup.
-- --
-- myStartupHook = do
--   spawnOnce "xmobar &"
--   spawnOnce "picom &"

-- ------------------------------------------------------------------------
-- -- Now run xmonad with all the defaults we set up.

-- -- Run xmonad with the settings you specify. No need to modify this.
-- --
-- main = xmonad $ docks defaults

-- -- A structure containing your configuration settings, overriding
-- -- fields in the default config. Any you don't override, will
-- -- use the defaults defined in xmonad/XMonad/Config.hs
-- --
-- -- No need to modify this.
-- --
-- defaults = defaultConfig {
--       -- simple stuff
--         terminal           = myTerminal,
--         focusFollowsMouse  = myFocusFollowsMouse,
--         borderWidth        = myBorderWidth,
--         modMask            = myModMask,
--         -- numlockMask deprecated in 0.9.1
--         -- numlockMask        = myNumlockMask,
--         workspaces         = myWorkspaces,
--         normalBorderColor  = myNormalBorderColor,
--         focusedBorderColor = myFocusedBorderColor,

--       -- key bindings
--         keys               = myKeys,
--         mouseBindings      = myMouseBindings,

--       -- hooks, layouts
--         layoutHook         = myLayout,
--         manageHook         = myManageHook,
--         handleEventHook    = myEventHook,
--         logHook            = myLogHook,
--         startupHook        = myStartupHook
--     }
