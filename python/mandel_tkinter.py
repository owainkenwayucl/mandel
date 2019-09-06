'''
  Simple mandelbrot generator in Python 3
  Owain Kenway
'''

from tkinter import *
import numpy as np
import numba
import time

def paint(can, x, y, colour):
    x2 = x+1
    y2 = y+1

    can.create_oval(x,y,x2,y2,fill=colour, outline=colour)

@numba.jit(nopython=True)
def mandel(xmin=-2.0, xmax=2.0, ymin=-2.0, ymax=2.0, max_iter=256, xres=2048, yres=2048):
    buffer = np.zeros((xres,yres))
    rmax2 = 4.0   
    for px in range(xres):
        x0 = (((px + 1.0)/xres) * (xmax - xmin)) + xmin      
        for py in range(yres):
            y0 = (((py + 1.0)/yres) * (ymax - ymin)) + ymin
            it = 0
            x = 0.0
            y = 0.0
            while (((x*x + y*y) < rmax2) and (it < max_iter)):
                xt = (x*x) - (y*y) + x0
                y = 2.0 * x * y + y0
                x = xt
                it = it + 1 
            buffer[px,py] = float(it)/float(max_iter)
    return(buffer)

def genColgrey(val):
    shade = hex(int(val*255))[2:]
    if len(shade) == 1:
          shade='0' + shade
    return '#' + shade + shade + shade

def genColjet(val):
    adjusted = -1 *((val * 2.0) - 1.0)
    r = red(adjusted)
    b = blue(adjusted)
    g = green(adjusted)
    return '#' + r + g + b

def clamp(val):
    t = 0 if (val < 0) else val
    return 1.0 if (t > 1.0) else t

def red(val):
    r = clamp(1.5 - abs(2.0*val - 1.0))
    r = hex(int(r*255))[2:]
    if len(r) == 1:
           r ='0' + r 
    return r

def blue(val):
    r = clamp(1.5 - abs(2.0*val + 1.0))
    r = hex(int(r*255))[2:]
    if len(r) == 1:
           r ='0' + r 
    return r

def green(val):
    r = clamp(1.5 - abs(2.0*val))
    r = hex(int(r*255))[2:]
    if len(r) == 1:
           r ='0' + r 
    return r

def plotimage(can, image):
    for px in range(image.shape[0]):
        for py in range(image.shape[1]):
            #colour = genColgrey(image[px,py])
            colour = genColjet(image[px,py])
            paint(can, px, image.shape[1]-py, colour)

def getdefault(text, default, f):
    challenge = text + "[" + str(default) + "]: "
    r = input(challenge)
    if r == '':
      r = str(default)
    if f:
      return float(r)
    else:
      return int(r)
    
if __name__ == '__main__':
    print("\nMandelbrot Generator:")
    print("====================\n")
    xmax = getdefault("Xmax", 1, True)
    xmin = getdefault("Xmin", -2, True)
    ymax = getdefault("Ymax", 1, True)
    ymin = getdefault("Ymin", -1, True)
    w = getdefault("Width", 1500, False)
    h = getdefault("Height", 1000, False)
    mi = getdefault("Iterations", 32, False)
    win = Tk()
    win.title("Mandelbrot generator")
    can = Canvas(win, width=w, height=h)
    can.pack(expand=YES, fill=BOTH)
    start = time.time() 
    buffer = mandel(xmax=xmax, xmin=xmin, ymax=ymax, ymin=ymin, max_iter=mi, xres=w, yres=h)
    stop = time.time()
    print("Time taken [calculation]: " + str(stop - start) + " seconds")    
    plotimage(can,buffer)
    stop2 = time.time()
    print("Time taken [display]:     " + str(stop2 - stop) + " seconds")
    win.mainloop()
    
