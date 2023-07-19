include("imageio.jl")
include("TermShow.jl")
include("fractal.jl")

# Split out mandel as a function so we can call it if need be.

pixels = mandel(-2.0, 2.0, -2.0, 2.0, 255, 2048, 2048)
imageio.writepgm(pixels, 255, "mandel.pgm")

corrected = convert_image(pixels, 255)

TermShow.hires_render_greyscale_image(corrected)


