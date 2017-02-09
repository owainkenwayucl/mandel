#include <stdio.h>

/*
 Write a pgm file from array at pointer d:
  xres     : x resolution
  yres     : y resolution
  white    : max value (corresponds to white)
  filename : file to write 
*/
void writepgm(int** d, int xres, int yres, int white, char filename[]) {
    int i, j;
    FILE *outfile;

// Open file.
    outfile = fopen(filename, "w");

// Write our header.
    fprintf(outfile, "P2\n");
    fprintf(outfile, "# Written by pnmmodules (https://github.com/owainkenwayucl/pnmmodules).\n");
    fprintf(outfile, "%d %d\n%d\n", xres, yres, white);

// Write out the array.
    for (j = 0; j < yres; j++){
        for (i = 0; i < xres; i++) {
            fprintf(outfile, "%d\n", d[i][j]);
        }
    }

// Close the file.
    fclose(outfile);
}

/*
 Write a pbm file from array at pointer d:
  xres      : x resolution
  yres      : y resolution
  threshold : value at which pixel becomes equal to 1.
  filename  : file to write 
*/
void writepbm(int** d, int xres, int yres, int threshold, char filename[]) {
    int i, j;
    FILE *outfile;

// Open file.
    outfile = fopen(filename, "w");

// Write our header.
    fprintf(outfile, "P1\n");
    fprintf(outfile, "# Written by pnmmodules (https://github.com/owainkenwayucl/pnmmodules).\n");
    fprintf(outfile, "%d %d\n", xres, yres);

// Write out the array.
    for (j = 0; j < yres; j++){
        for (i = 0; i < xres; i++) {
            if (d[i][j] >= threshold) {
                fprintf(outfile, "1\n");
            } else {
                fprintf(outfile, "0\n");
            }
        }
    }

// Close the file.
    fclose(outfile);
}