static const char *colorname[] = {
	/* 8 normal colors */
	"#343F44",
	"#7FBBB3",
	"#83C092",
	"#A7C080",
	"#D699B6",
	"#E67E80",
	"#859289",
	"#DBBC7F",

	/* 8 bright colors */
	"#868D80",
	"#7FBBB3",
	"#83C092",
	"#A7C080",
	"#D699B6",
	"#E67E80",
	"#9DA9A0",
	"#DBBC7F",

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	"#D3C6AA", // cursor
	"#505050",
	"#D3C6AA", /* default foreground colour */
	"#2D353B", /* default background colour */
};


/*
 * Default colors (colorname index)
 * foreground, background, cursor, reverse cursor
 */
unsigned int defaultfg = 258;
unsigned int defaultbg = 259;
unsigned int defaultcs = 256;
static unsigned int defaultrcs = 257;
