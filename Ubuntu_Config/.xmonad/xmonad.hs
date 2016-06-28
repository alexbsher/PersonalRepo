import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.Minimize
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.WindowMenu
import XMonad.Actions.UpdatePointer
import XMonad.Layout.Minimize
import XMonad.Layout.LimitWindows
import XMonad.Layout.LayoutHints
import XMonad.Layout.Tabbed
import XMonad.Layout.Grid
import System.IO
import qualified XMonad.StackSet as W
import XMonad.Util.WorkspaceCompare
import XMonad.Hooks.SetWMName

myExtraWorkspaces = [(xK_0, "0"),(xK_minus, "tmp"),(xK_equal, "swap")]
myWorkspaces = ["1","2","3","4","5","6","7","8","9"] ++ (map snd myExtraWorkspaces)

myManageHook = composeAll [
          (resource =? "Do") --> doIgnore
        , (className =? "Gnome-panel" <&&> title =? "Run Application") --> doFloat
        ]

myHandleEventHook = hintsEventHook <+> minimizeEventHook <+> ewmhDesktopsEventHook

myLayout = minimize $ avoidStruts (layouts)
  where
    layouts = tiled ||| Mirror tiled ||| Grid ||| simpleTabbed ||| Full
    tiled = Tall 1 0.03 0.5

myTerminal = "terminator"

-- | The default pretty printing options, as seen in 'dynamicLog'.
myDefaultPP :: PP
myDefaultPP = PP { ppCurrent         = wrap "[" "]"
               , ppVisible         = wrap "<" ">"
               , ppHidden          = id
               , ppHiddenNoWindows = wrap "_" "_"
               , ppUrgent          = id
               , ppSep             = " : "
               , ppWsSep           = " "
               , ppTitle           = shorten 80
               , ppLayout          = id
               , ppOrder           = id
               , ppOutput          = putStrLn
               , ppSort            = getSortByIndex
               , ppExtras          = []
               }

main = do
    -- xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
    xmonad $ gnomeConfig
      { startupHook = startupHook gnomeConfig >> setWMName "LG3D"
      , terminal = myTerminal
      , modMask = mod4Mask -- use the mod key to the windows key
      , manageHook = myManageHook <+> manageHook gnomeConfig
      , layoutHook = myLayout
      , workspaces = myWorkspaces
      --, logHook = dynamicLogWithPP xmobarPP
      --                { ppOutput = hPutStrLn xmproc
      --                , ppHiddenNoWindows = xmobarColor "orange" ""
      --                , ppTitle = xmobarColor "green" "" . shorten 50
      --                }
      , handleEventHook = myHandleEventHook
      }
      `additionalKeysP`(
          [ ("M-c", kill)
          , ("M-g", goToSelected defaultGSConfig)
          , ("M-M1-g", windowMenu)
          , ("M-n", spawn "gnome-do")
          , ("M-M1-n", spawn "dmenu_run")
          , ("M-S-n", spawn "gmrun")
          , ("M-;", spawn myTerminal)
          , ("M-,", spawn "gnome-terminal")
          , ("M-b", spawn "google-chrome")
          , ("M-v", spawn "nautilus ~")
          , ("M-m", withFocused minimizeWindow)
          , ("M-M1-m", sendMessage RestoreNextMinimizedWin)
          , ("M-u", prevWS)
          , ("M-i", nextWS)
          , ("M-S-u", shiftToPrev)
          , ("M-S-i", shiftToNext)
          , ("M-M1-u", shiftToPrev >> prevWS)
          , ("M-M1-i", shiftToNext >> nextWS)
          , ("M-M1-j", windows W.swapDown)
          , ("M-M1-k", windows W.swapUp)
          , ("M-y", nextScreen)
          , ("M-S-y", shiftNextScreen)
          , ("M-M1-l", spawn "xscreensaver-command -lock")
          , ("M-M1-y", shiftNextScreen >> nextScreen)
          ] ++
          -- Shifts a window to specifiec workspace, and sets that workspace in screen
          [ ("M-M1-" ++ tag, (windows $ W.shift tag) >> (windows $ W.greedyView tag)) | tag <- myWorkspaces
          ]
       )
       `additionalKeys`(
          -- Mapping extra workspaces
          [
            ((mod4Mask, key), (windows $ W.greedyView ws))
            | (key,ws) <- myExtraWorkspaces
          ] ++
          [
            ((mod4Mask .|. shiftMask, key), (windows $ W.shift ws))
            | (key,ws) <- myExtraWorkspaces
          ]
      )
