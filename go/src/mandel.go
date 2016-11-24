// Simple mandelbrot generator in Go
// Owain Kenway

package main

import ("pnmmodules")

func main() {
    var pixels[][] int
    var xmin, xmax, ymin, ymax, rmax, x0, y0, x, y, xt float64
    var xres, yres, max_iter, iter, px, py int

    xmax = 2.0
    xmin = -2.0

    ymax = 2.0
    ymin = -2.0

    xres = 2048
    yres = 2048

    max_iter = 256

    rmax = 2.0

// Allocate slice of slices.
// A 2D slice is a slice of slices.
    pixels = make([][]int, xres)
    for px = 0; px < xres; px++ {

// Allocate slice in slice of slices
        pixels[px] = make([]int, yres)

        x0 = ((float64(px)/float64(xres)) * float64(xmax - xmin)) + xmin

        for py = 0; py < yres; py++ {
            y0 = ((float64(py)/float64(yres)) * float64(ymax - ymin)) + ymin

            iter = 0
            x = 0.0
            y = 0.0

            for (((x*x + y*y) < (rmax * rmax)) && (iter < max_iter)) {
                xt = (x*x) - (y*y) + x0
                y = 2.0 * x * y + y0
                x = xt
                iter = iter + 1                
            }
            pixels[px][py] = max_iter - iter
        }

    } 
    
// Call our Writepgm routine from pgmmodules.
    pnmmodules.Writepgm(pixels, max_iter - 1, "mandel.pgm")


}