static const char *colorname[] = {
	/* 8 normal colors */
	"#15161e", // black
	"#f7768e", // red
	"#9ece6a", // green
	"#e0af68", // yellow
	"#7aa2f7", // blue
	"#bb9af7", // magenta
	"#7dcfff", // cyan
	"#a9b1d6", // white

	/* 8 bright colors */
	"#414868", // black
	"#f7768e", // red
	"#9ece6a", // green
	"#e0af68", // yellow
	"#7aa2f7", // blue
	"#bb9af7", // magenta
	"#7dcfff", // cyan
	"#c0caf5", // white

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	"#c0caf5", // cursor
	"#1a1b26",
	"#c0caf5", /* default foreground colour */
	"#1a1b26"/*background*/, 
};


/*
 * Default colors (colorname index)
 * foreground, background, cursor, reverse cursor
 */
unsigned int defaultfg = 258;
unsigned int defaultbg = 259;
unsigned int defaultcs = 256;
static unsigned int defaultrcs = 257;
