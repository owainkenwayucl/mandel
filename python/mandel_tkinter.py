'''
  Simple mandelbrot generator in Python 3
  Owain Kenway
'''

from tkinter import *

def paint(can, x, y, colour):
    x2 = x+1
    y2 = y+1

    can.create_oval(x,y,x2,y2,fill=colour, outline=colour)

def mandel(can, xmin=-2.0, xmax=2.0, ymin=-2.0, ymax=2.0, max_iter=256, xres=2048, yres=2048):
    

    rmax2 = 4.0
    print("Calculating:", xmin, xmax, ymin, ymax, max_iter, xres, yres)    
    for px in range(xres):
        print(".", end="", flush=True)
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

            shade = hex(int((float(it)/float(max_iter)) * 256)-1)[2:]
            if len(shade) == 1:
                shade='0' + shade

            colour = '#' + shade + shade + shade
# Remember to flip y-axis otherwise image is upside down!
            paint(can, px, yres-py, colour)
    print("\nDone.\n")

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
    mandel(can, xmax=xmax, xmin=xmin, ymax=ymax, ymin=ymin, max_iter=mi, xres=w, yres=h)
    win.mainloop()
    
