/*
 Write a pgm file from array at pointer d:
  xres     : x resolution
  yres     : y resolution
  white    : max value (corresponds to white)
  filename : file to write 
*/
void writepgm(int** d, int xres, int yres, int white, char filename[]);

/*
 Write a pbm file from array at pointer d:
  xres      : x resolution
  yres      : y resolution
  threshold : value at which pixel becomes equal to 1.
  filename  : file to write 
*/
void writepbm(int** d, int xres, int yres, int threshold, char filename[]);