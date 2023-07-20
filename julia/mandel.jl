include("TermShow.jl")
include("imageio.jl")
include("fractal.jl")

# Split out mandel as a function so we can call it if need be.

pixels = mandel(xmin=-2.0, xmax=2.0, ymin=-2.0, ymax=2.0, max_iter=255, xres=2048, yres=2048)
imageio.writepgm(pixels, 255, "mandel.pgm")

corrected = convert_image(pixels, depth=255)

TermShow.hires_render_greyscale_image(corrected)


