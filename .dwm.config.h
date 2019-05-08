/* See LICENSE file for copyright and license details. */

// applied patches
// https://dwm.suckless.org/patches/alpha/dwm-alpha-20180613-b69c870.diff
// https://dwm.suckless.org/patches/attachaside/dwm-attachaside-20180126-db22360.diff
// https://dwm.suckless.org/patches/autostart/dwm-autostart-20161205-bb3bd6f.diff
// https://dwm.suckless.org/patches/cyclelayouts/dwm-cyclelayouts-20180524-6.2.diff
// https://dwm.suckless.org/patches/fancybar/dwm-fancybar-2019018-b69c870.diff
// https://dwm.suckless.org/patches/gridmode/dwm-gridmode-20170909-ceac8c9.diff
// https://dwm.suckless.org/patches/rotatestack/dwm-rotatestack-20161021-ab9571b.diff
// https://dwm.suckless.org/patches/selfrestart/dwm-r1615-selfrestart.diff
// https://dwm.suckless.org/patches/statuspadding/dwm-statuspadding-20150524-c8e9479.diff
// https://dwm.suckless.org/patches/uselessgap/dwm-uselessgap-6.1.diff

#include "layouts.c"
#include "selfrestart.c"

#define XF86AudioMute           0x1008ff12
#define XF86AudioLowerVolume    0x1008ff11
#define XF86AudioRaiseVolume    0x1008ff13

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 5;        /* gap pixel between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int horizpadbar        = 6;        /* horizontal padding for statusbar */
static const int vertpadbar         = 7;        /* vertical padding for statusbar */
static const char *fonts[]          = { "monospace:size=10" };
static const char dmenufont[]       = "monospace:size=13";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const unsigned int baralpha = 0xd0;
static const unsigned int borderalpha = OPAQUE;
static const char *colors[][3]      = {
        /*               fg         bg         border   */
        [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
        [SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};
static const unsigned int alphas[][3]      = {
        /*               fg      bg        border     */
        [SchemeNorm] = { OPAQUE, baralpha, borderalpha },
        [SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
        /* xprop(1):
         *      WM_CLASS(STRING) = instance, class
         *      WM_NAME(STRING) = title
         */
        /* class                instance    title       tags mask     isfloating   monitor */
        { "alsamixer",          NULL,       NULL,       0,            1,           -1 },
        { "Nitrogen",           NULL,       NULL,       0,            1,           -1 },
        { "Lxappearance",       NULL,       NULL,       0,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
        /* symbol     arrange function */
        { "[]=",      tile },    /* first entry is default */
        { "><>",      NULL },    /* no layout function means floating behavior */
        { "[M]",      monocle },
        { "HHH",      grid },
        { NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
        { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
        { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
        { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
        { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]           = { "dmenu_run", "-i" , "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]            = { "st", NULL };
static const char *volup[]              = { "pactl", "set-sink-volume", "0", "+5%", NULL };
static const char *voldown[]            = { "pactl", "set-sink-volume", "0", "-5%", NULL };
static const char *voltoggle[]          = { "pactl", "set-sink-volume", "0", "toggle", NULL };
static const char *shutdowncmd[]        = { "/home/conni/bin/i3cmds/rdq", "Are you sure you want to shutdown?", "shutdown -h now", NULL };
static const char *rebootcmd[]          = { "/home/conni/bin/i3cmds/rdq", "Are you sure you want to reboot?", "reboot", NULL };
static const char *nnn[]                = { "st", "nnn", NULL };
static const char *nvim[]               = { "st", "nvim", NULL };
static const char *firefox[]            = { "firefox", NULL };
static const char *newsboat[]           = { "st", "newsboat", NULL };
static const char *neomutt[]            = { "st", "neomutt", NULL };
static const char *slack[]              = { "st", "weechat", NULL };
static const char *alsa[]               = { "st", "alsamixer", NULL };
static const char *trello[]             = { "surf", "trello.com", NULL };


static Key keys[] = {
        /* modifier                     key             function        argument */
        { MODKEY,                       XK_d,           spawn,          {.v = dmenucmd } },
        { MODKEY,                       XK_Return,      spawn,          {.v = termcmd } },
        { MODKEY,                       XK_b,           togglebar,      {0} },
        { MODKEY|ShiftMask,             XK_j,           rotatestack,    {.i = +1 } },
        { MODKEY|ShiftMask,             XK_k,           rotatestack,    {.i = -1 } },
        { MODKEY,                       XK_j,           focusstack,     {.i = +1 } },
        { MODKEY,                       XK_k,           focusstack,     {.i = -1 } },
        { MODKEY,                       XK_Left,        focusstack,     {.i = +1 } },
        { MODKEY,                       XK_Right,       focusstack,     {.i = -1 } },
        { MODKEY,                       XK_i,           incnmaster,     {.i = +1 } },
        { MODKEY,                       XK_o,           incnmaster,     {.i = -1 } },
        { MODKEY,                       XK_h,           setmfact,       {.f = -0.05} },
        { MODKEY,                       XK_l,           setmfact,       {.f = +0.05} },
        { MODKEY,                       XK_Return,      zoom,           {0} },
        { MODKEY,                       XK_Tab,         view,           {0} },
        { MODKEY|ShiftMask,             XK_q,           killclient,     {0} },
        { MODKEY,                       XK_t,           setlayout,      {.v = &layouts[0]} },
        { MODKEY,                       XK_f,           setlayout,      {.v = &layouts[1]} },
        { MODKEY,                       XK_m,           setlayout,      {.v = &layouts[2]} },
        { MODKEY,                       XK_g,           setlayout,      {.v = &layouts[3]} },
        { MODKEY|ControlMask,           XK_comma,       cyclelayout,    {.i = -1 } },
        { MODKEY|ControlMask,           XK_period,      cyclelayout,    {.i = +1 } },
        { MODKEY,                       XK_space,       setlayout,      {0} },
        { MODKEY|ShiftMask,             XK_space,       togglefloating, {0} },
        { MODKEY,                       XK_0,           view,           {.ui = ~0 } },
        { MODKEY|ShiftMask,             XK_0,           tag,            {.ui = ~0 } },
        { MODKEY,                       XK_comma,       focusmon,       {.i = -1 } },
        { MODKEY,                       XK_period,      focusmon,       {.i = +1 } },
        { MODKEY|ShiftMask,             XK_comma,       tagmon,         {.i = -1 } },
        { MODKEY|ShiftMask,             XK_period,      tagmon,         {.i = +1 } },

        TAGKEYS(                        XK_1,                           0)
        TAGKEYS(                        XK_2,                           1)
        TAGKEYS(                        XK_3,                           2)
        TAGKEYS(                        XK_4,                           3)
        TAGKEYS(                        XK_5,                           4)
        TAGKEYS(                        XK_6,                           5)
        TAGKEYS(                        XK_7,                           6)
        TAGKEYS(                        XK_8,                           7)
        TAGKEYS(                        XK_9,                           8)

        { MODKEY|ShiftMask,             XK_x,           spawn,          {.v = shutdowncmd } },
        { MODKEY|ShiftMask,             XK_Escape,      spawn,          {.v = rebootcmd } },
        { MODKEY|ShiftMask,             XK_r,           self_restart,   {0} },
        { MODKEY|ShiftMask,             XK_e,           quit,           {0} },
        { 0,                            XF86AudioRaiseVolume,   spawn,          {.v = volup } },
        { 0,                            XF86AudioLowerVolume,   spawn,          {.v = voldown } },
        { 0,                            XF86AudioMute,          spawn,          {.v = voltoggle } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
        /* click                event mask      button          function        argument */
        { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
        { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
        { ClkWinTitle,          0,              Button2,        zoom,           {0} },
        { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
        { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
        { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
        { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
        { ClkTagBar,            0,              Button1,        view,           {0} },
        { ClkTagBar,            0,              Button3,        toggleview,     {0} },
        { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
        { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

