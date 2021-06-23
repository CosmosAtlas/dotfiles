    -- Base
import XMonad
import qualified Data.Map as M
import System.Exit

    -- Hooks
import XMonad.Hooks.ServerMode
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

    -- Actions
import XMonad.Actions.Commands

    -- Util
import XMonad.Util.Run


-- Remove all keybindings besides launch terminal
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ 
    ((modMask, xK_Return), spawn $ XMonad.terminal conf)
    ]

myStartupHook :: X ()
myStartupHook = do
    setWMName "LG3D"

myCommands :: X [(String, X ())]
myCommands = do
    return newCommands
  where
    newCommands = 
        [ ("rofi"   , spawn "rofi -show drun")
        , ("dmenu"  , spawn "dmenu_run")
        , ("my-restart-wm", restart "xmonad" True)
        ]

myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]

myConfig = def
    { modMask         = mod4Mask -- set 'Mod' to windows key
    , handleEventHook = serverModeEventHookCmd
                        <+> docksEventHook
                        <+> serverModeEventHookCmd' myCommands -- now produces duplicate event values. For example now 1 does both switch workspace and run rofi
                        <+> serverModeEventHook
                        <+> serverModeEventHook' myCommands
                        <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn)
                        <+> serverModeEventHookF "EXEC" spawn
    , terminal        = "termite"
    , manageHook = manageDocks <+> manageHook def
    , layoutHook = avoidStruts $ layoutHook def
    , keys            = myKeys
    , startupHook     = myStartupHook
    }
    where
        commands = defaultCommands

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ myConfig 
        { logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        }
