static const char *colorname[] = {
	/* 8 normal colors */
	"#212529",
	"#EA5252",
	"#ACB765",
	"#C1BF89",
	"#82ABBC",
	"#B18A97",
	"#88B482",
	"#B3CFA7",

	/* 8 bright colors */
	"#31363B",
	"#EA5252",
	"#ACB765",
	"#C1BF89",
	"#82ABBC",
	"#B18A97",
	"#88B482",
	"#B3CFA7",

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	"#D3C6AA", // cursor
	"#505050",
	"#B3CFA7", /* default foreground colour */
	"#2A2F33", /* default background colour */
};


/*
 * Default colors (colorname index)
 * foreground, background, cursor, reverse cursor
 */
unsigned int defaultfg = 258;
unsigned int defaultbg = 259;
unsigned int defaultcs = 256;
static unsigned int defaultrcs = 257;
