-------------------- imports --------------------

--necessary
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import System.IO (Handle, hPutStrLn) 

--utilities
import XMonad.Util.Run (spawnPipe)
import XMonad.Actions.NoBorders

--hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.XPropManage
import XMonad.Hooks.FadeInactive

--MO' HOOKS
import Graphics.X11.Xlib.Extras
import Foreign.C.Types (CLong)

--layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Named
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import Data.Ratio((%))


-------------------- main --------------------

main = do 
    h <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
    xmonad $ defaultConfig
        { --workspaces = ["1:term", "2:web", "3:web", "4:code", "5:else"]
          workspaces = ["1:cli", "2:pic", "3:web", "4:mail", "5:dev", "6:gimp", "7:virtualbox","8:windows"]
        , modMask = mod1Mask
        , borderWidth = 3
        , normalBorderColor  = "#a0a0a0"
        , focusedBorderColor = "#008080"
        , terminal = "urxvt"
        , logHook =  logHook' h >> (fadeLogHook)
        , manageHook = manageHook'
        , layoutHook = layoutHook'
        , keys = keys'
        }
-------------------- loghooks --------------------

logHook' ::  Handle -> X ()
logHook' h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }

customPP :: PP
customPP = defaultPP { ppCurrent = xmobarColor "#D81860" ""
             , ppTitle = shorten 75
             , ppSep = "<fc=#D81860> | </fc>"
                 , ppHiddenNoWindows = xmobarColor "#4d4d4d" ""
                     }
fadeLogHook :: X ()
fadeLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0.85
-------------------- layouthooks --------------------

layoutHook' = customLayout
customLayout = onWorkspace "3:web" simpleTabbed $ avoidStrutsOn [U] ( Mirror tiled ||| noBorders Full)
    where
     tiled  = named "Tiled" $ ResizableTall 1 (2/100) (1/2) []

-------------------- menuhook --------------------

getProp :: Atom -> Window -> X (Maybe [CLong])
getProp a w = withDisplay $ \dpy -> io $ getWindowProperty32 dpy a w

checkAtom name value = ask >>= \w -> liftX $ do
                a <- getAtom name
                val <- getAtom value
                mbr <- getProp a w
                case mbr of
                  Just [r] -> return $ elem (fromIntegral r) [val]
                  _ -> return False 

checkDialog = checkAtom "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_DIALOG"
checkMenu = checkAtom "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_MENU"

manageMenus = checkMenu --> doFloat
manageDialogs = checkDialog --> doFloat

-------------------- managehook --------------------

manageHook' :: ManageHook
manageHook' = manageHook defaultConfig <+> manageDocks <+> manageMenus <+> manageDialogs <+> myManageHook

myManageHook :: ManageHook
myManageHook = composeAll . concat $
    [ [className =? c      --> doFloat  | c <- myFloats]
    , [title     =? t      --> doFloat  | t <- myOtherFloats]
    , [className =? r      --> doIgnore | r <- myIgnores]

    , [className =? s2 --> doF (W.shift "2:pic")     | s2 <- shift2]
    , [className =? s3 --> doF (W.shift "3:web")     | s3 <- shift3]
    , [className =? s4 --> doF (W.shift "4:mail")    | s4 <- shift4]
    , [className =? s6 --> doF (W.shift "6:gimp")    | s6 <- shift6]
    , [className =? s7 --> doF (W.shift "7:virtualbox")    | s7 <- shift7]
    , [className =? s8 --> doF (W.shift "8:windows") | s8 <- shift8]
    ]
    where
      myFloats = ["Gimp", "Vlc", "Nitrogen", "Xclock", "feh" ,"Mscore"]
      myOtherFloats = ["Downloads", "Firefox Preferences", "Save As...", "Send file", "Open", "File Transfers"]
      myIgnores = ["trayer", "stalonetray"]

      shift2 = ["Mirage","Xpdf","Epdfview"]
      shift3 = ["Firefox"]
      shift4 = ["Thunderbird"]
      shift6 = ["Gimp","Mscore"]
      shift7 = ["VirtualBox"]
      shift8 = ["rdesktop"]

-------------------- keybinds --------------------

keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

      --launching/killing
      [ ((modMask .|. shiftMask, xK_p     ), spawn "dmenu_run -fn \"-*-lime-*-*-*-*-*-*-*-*-*-*-*-*\" -nb \"#1C1C1C\" -nf \"#4d4d4d\" -sb \"#2A2A2A\" -sf \"#D81860\"")
      , ((modMask .|. shiftMask, xK_Return   ), spawn $ XMonad.terminal conf)
      , ((modMask,               xK_f     ), spawn "firefox")
      , ((modMask .|. shiftMask, xK_m     ), spawn "urxvt -e ncmpcpp")
      , ((modMask .|. shiftMask, xK_c     ), kill)
      --layouts
      , ((modMask,               xK_space ), sendMessage NextLayout)              -- 次のlayoutへ
      , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)  -- layoutをデフォルトに戻す
      , ((modMask,               xK_b     ), sendMessage ToggleStruts)            -- borderなしの最大化
      , ((modMask,               xK_t     ), withFocused $ windows . W.sink)      -- windowをタイルに戻す
      -- refresh
      , ((modMask,               xK_n     ), refresh)                             -- reflesh?
      , ((modMask .|. shiftMask, xK_w     ), withFocused toggleBorder)            -- borderをtoggle
      -- focus
      , ((modMask,               xK_j     ), windows W.focusDown)
      , ((modMask,               xK_k     ), windows W.focusUp)
      , ((modMask,               xK_m     ), windows W.focusMaster)
      , ((modMask,               xK_n     ), spawn "xte 'mousemove 0 80'")        -- 左ディスプレイにフォーカス
      , ((modMask,               xK_p     ), spawn "xte 'mousemove 1800 80'")     -- 右ディスプレイにフォーカス
      -- swapping
      , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
      , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )
      -- increase or decrease number of windows in the master area
      , ((modMask .|. controlMask, xK_h     ), sendMessage (IncMasterN 1))
      , ((modMask .|. controlMask, xK_l     ), sendMessage (IncMasterN (-1)))
      -- resizing
      , ((modMask,               xK_h     ), sendMessage Shrink)
      , ((modMask,               xK_l     ), sendMessage Expand)
      , ((modMask .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
      , ((modMask .|. shiftMask, xK_l     ), sendMessage MirrorExpand)
      -- quit, or restart
      , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
      , ((modMask              , xK_q     ), restart "xmonad" True)
      -- clipbord
      , ((modMask,               xK_y     ), spawn "sleep 1 && xdotool key shift+Insert")
      ]
      ++
      -- mod-[1..9] %! Switch to workspace N
      -- mod-shift-[1..9] %! Move client to workspace N
      [((m .|. modMask, k), windows $ f i)
--          | (i, k) <- zip (XMonad.workspaces conf) [xK_F1 .. xK_F5]
          | (i, k) <- zip (XMonad.workspaces conf) [xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7, xK_8, xK_9]
          , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

