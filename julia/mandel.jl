include("imageio.jl")
import imageio

# Split out mandel as a function so we can call it if need be.
function mandel(xmin=-2.0, xmax=2.0, ymin=-2.0, ymax=2.0, max_iter=256, xres=2048, yres=2048, filename="mandel.pgm")

  rmax = 2.0
  pixels = zeros(Int64, xres, yres)

  for px = 1:xres
    x0 = (Float64(px)/Float64(xres)) * Float64(xmax - xmin) + xmin

    for py = 1:xres
      y0 = (Float64(py)/Float64(yres)) * Float64(ymax - ymin) + ymin

      iter = 0

      x = 0.0
      y = 0.0

      while (((x*x + y*y) < (rmax * rmax)) && (iter < max_iter)) 
        xt = (x*x) - (y*y) + x0
        y = 2.0 * x * y + y0
        x = xt
        iter = iter + 1
      end

      pixels[px,py] = max_iter - iter
    end
 

  end

  imageio.writepgm(pixels, max_iter - 1, "mandel.pgm")

end

mandel()
