static const char *colorname[] = {
	/* 8 normal colors */
	"#21222C", // black
	"#FF5555", // red
	"#50FA7B", // green
	"#F1FA8C", // yellow
	"#BD93F9", // blue
	"#FF79C6", // magenta
	"#8BE9FD", // cyan
	"#BBBBBB", // white

	/* 8 bright colors */
	"#44475A", // black
	"#FF5555", // red
	"#50FA7B", // green
	"#F1FA8C", // yellow
	"#BD93F9", // blue
	"#FF79C6", // magenta
	"#8BE9FD", // cyan
	"#FFFFFF", // white

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	"#2e3440", // cursor
	"#d8dee9",
	"#F8F8F2", /* default foreground colour */
	"#282A36"/*background*/, 
};


/*
 * Default colors (colorname index)
 * foreground, background, cursor, reverse cursor
 */
unsigned int defaultfg = 258;
unsigned int defaultbg = 259;
unsigned int defaultcs = 256;
static unsigned int defaultrcs = 257;
