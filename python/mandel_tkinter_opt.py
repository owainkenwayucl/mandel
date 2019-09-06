'''
  Simple mandelbrot generator in Python 3
  This version is for testing optimisation ideas.
  Owain Kenway
'''

from tkinter import *
import numpy as np
import numba
import time
from PIL import Image, ImageTk, ImageOps

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


@numba.jit(nopython=True)
def genimage(image):
    img = np.zeros((image.shape[0], image.shape[1], 3))
    for px in range(image.shape[0]):
        for py in range(image.shape[1]):
            val =  -1 *((image[px,py] * 2.0) - 1.0)

            v = 1.5 - abs(2.0*val - 1.0)
            t = 0 if (v < 0) else v
            img[px, py, 0] = int(255*(1.0 if (t > 1.0) else t))

            v = 1.5 - abs(2.0*val + 1.0)
            t = 0 if (v < 0) else v
            img[px, py, 2] = int(255*(1.0 if (t > 1.0) else t))

            v = 1.5 - abs(2.0*val)
            t = 0 if (v < 0) else v
            img[px, py, 1] = int(255*(1.0 if (t > 1.0) else t))


    return img 

def plotimage(image):
    imdat = Image.fromarray(np.transpose(image, axes=[1,0,2]).astype('uint8'), 'RGB')
    img = ImageTk.PhotoImage(ImageOps.flip(imdat))
    label = Label(image=img)
    label.image = img
    label.pack(expand=YES, fill=BOTH)
    

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

    start = time.time() 
    buffer = mandel(xmax=xmax, xmin=xmin, ymax=ymax, ymin=ymin, max_iter=mi, xres=w, yres=h)
    stop = time.time()
    print("Time taken [calculation]: " + str(stop - start) + " seconds")
    
    image =  genimage(buffer)   
    stop2 = time.time()
    print("Time taken [render]:      " + str(stop2 - stop) + " seconds")
    plotimage(image)
    stop3 = time.time()
    print("Time taken [display]:     " + str(stop3 - stop2) + " seconds")
    win.mainloop()
    
