'''
  Simple mandelbrot generator in Python 3
  Owain Kenway
'''

import pnmmodules.imageio as ii

def mandel(xmin=-2.0, xmax=2.0, ymin=-2.0, ymax=2.0, max_iter=256, xres=2048, yres=2048, filename='mandel.pgm'):
    pixels = []
    rmax = 2.0
    
    for px in range(xres):

        pixels.append([])

        x0 = (((px + 1.0)/xres) * (xmax - xmin)) + xmin

        for py in range(yres):
            y0 = (((py + 1.0)/yres) * (ymax - ymin)) + ymin

            it = 0
            x = 0.0
            y = 0.0

            while (((x*x + y*y) < (rmax * rmax)) and (it < max_iter)):
                xt = (x*x) - (y*y) + x0
                y = 2.0 * x * y + y0
                x = xt
                it = it + 1 

            pixels[px].append(max_iter - it)                
    
    ii.writepgm(pixels, max_iter -1, filename)

if __name__ == '__main__':
    mandel()