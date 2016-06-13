/* See LICENSE file for copyright and license details. */
/*includes*/
#include <X11/XF86keysym.h> /*Needed for mulitmedia keys*/

/* appearance */
static const char font[]  =                     "Inconsolataicon-12";

#define NUMCOLORS 9
static const char colors[NUMCOLORS][ColLast][9] = {
  // border foreground background
  { "#212121", "#00FFFF", "#2F4F4F" }, // 0 = normal
  { "#696969", "#ADFF2F", "#2F4F4F" }, // 1 = selected
  { "#212121", "#F8F8FF", "#C71585" }, // 2 = urgent 
  { "#212121", "#90EE90", "#778899" }, // 3 = important 
  { "#212121", "#FFFF00", "#2F4F4F" }, // 4 = yellow
  { "#212121", "#00BFFF", "#2F4F4F" }, // 5 = blue
  { "#212121", "#00FFFF", "#2F4F4F" }, // 6 = cyan
  { "#212121", "#FF00FF", "#2F4F4F" }, // 7 = magenta 
  { "#212121", "#F5F5F5", "#2F4F4F" }, // 8 = grey
  };
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

/* tagging */
static const char *tags[] = { "\u01A0", "\u01a5", "\u01A1 ", "\u01A2", "\u01A3 " };

static const Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            True,        -1 },
	{ "Firefox",  NULL,       NULL,       0,       False,       -1 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = True; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char  *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", colors[0][ColBG], "-nf", colors[0][ColFG], "-sb", colors[1][ColBG], "-sf", colors[1][ColFG], NULL };
static const char *termcmd[]  = { "termite", NULL };
/*functions for volume control*/
static const char *upvol[] = { "amixer", "sset", "Master", "1%+", NULL};
static const char *downvol[] = { "amixer", "sset", "Master", "1%-", NULL};
static const char *mute[] = { "amixer", "sset", "Master", "toggle", NULL};
/*cmus functions*/
static const char *cmusplaypause[] = { "cmus-remote", "-u", NULL};
static const char *cmusnext[] = { "cmus-remote", "--next", NULL};
static const char *cmusprev[] = { "cmus-remote", "--prev", NULL};
/*screenshot*/
static const char *screenshot[] = { "scrot", NULL};

static Key keys[] = {
	/* modifier                     key        function        argument */
  { 0,              XF86XK_AudioRaiseVolume, spawn,          {.v = upvol} },
  { 0,              XF86XK_AudioLowerVolume, spawn,          {.v = downvol} },
  { 0,              XF86XK_AudioMute,        spawn,          {.v = mute } },
  { 0,              XF86XK_AudioPlay,        spawn,          {.v = cmusplaypause} },
  { 0,              XF86XK_AudioPause,       spawn,          {.v = cmusplaypause} },
  { MODKEY,                       XK_u,      spawn,          {.v = cmusplaypause} },
  { MODKEY,                       XK_bracketright,     spawn,          {.v = cmusnext} },
  { MODKEY,                       XK_bracketleft,      spawn,          {.v = cmusprev} },
  { MODKEY|ControlMask,           XK_s,      spawn,          {.v = screenshot} },
  { MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
  TAGKEYS(                        XK_5,                      4)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        toggleview,           {0} },
	{ ClkTagBar,            0,              Button3,        view,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

