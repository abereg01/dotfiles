static const char *colorname[] = {
	/* 8 normal colors */
	"#3b4252", // black
	"#bf616a", // red
	"#a3be8c", // green
	"#ebcb8b", // yellow
	"#81a1c1", // blue
	"#b48ead", // magenta
	"#88c0d0", // cyan
	"#e5e9f0", // white

	/* 8 bright colors */
	"#3b4252", // black
	"#bf616a", // red
	"#a3be8c", // green
	"#ebcb8b", // yellow
	"#81a1c1", // blue
	"#b48ead", // magenta
	"#88c0d0", // cyan
	"#e5e9f0", // white

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	"#2e3440", // cursor
	"#d8dee9",
	"#d8dee9", /* default foreground colour */
	"#2e3440"/*background*/, 
};


/*
 * Default colors (colorname index)
 * foreground, background, cursor, reverse cursor
 */
unsigned int defaultfg = 258;
unsigned int defaultbg = 259;
unsigned int defaultcs = 256;
static unsigned int defaultrcs = 257;
