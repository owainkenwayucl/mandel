#include <imageio.h>
#include <stdlib.h>



int main(void) {
    int **pixels;
    int xres, yres, max_iter, it, px, py;
    int i, j;
    double xmax, xmin, ymax, ymin, rmax, x0, y0, xt, x, y;

    rmax = 2.0;
    xmax = 2.0;
    xmin = -2.0;
    
    ymax = 2.0;
    ymin = -2.0;
    
    xres = 2048;
    yres = 2048;
    
    max_iter = 256;

    pixels = malloc(xres * sizeof *pixels);
    for (px = 0; px < xres; px++) {
        pixels[px] = malloc(yres * sizeof *pixels[px]);

        x0 = ((((double)px + 1.0)/(double)xres) * (double)(xmax - xmin)) + (double)xmin;

        for (py = 0; py < yres; py++) {
            y0 = ((((double)py + 1.0)/(double)yres) * (double)(ymax - ymin)) + (double)ymin;

            it = 0;
            x = 0.0;
            y = 0.0;

            while (((x*x + y*y) < (rmax * rmax)) && (it < max_iter)) {
                xt = (x*x) - (y*y) + x0;
                y = 2.0 * x * y + y0;
                x = xt;
                it = it + 1; 
            }

            pixels[px][py] = (double)(max_iter - it);
        } 
    }

    writepgm(pixels, xres, yres, max_iter - 1, "mandel.pgm");

// free array
    for (i = 0; i < xres; i++) {
        free(pixels[i]);
    }
    free(pixels);

}
