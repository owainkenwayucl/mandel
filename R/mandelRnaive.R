# Example naive mandelbrot in R.
# Owain Kenway

# Range for maths.
xmax <- 2.0
xmin <- -2.0

ymax <- 2.0
ymin <- -2.0

# Resolution of plot.
xres <- 512
yres <- 512

# In memory matrix that represents the plot.
img <- matrix(0.0, nrow = yres, ncol=xres)

# Maximum number of interations.
max_iter <- 256

# Rmax is the point we declare escape.
rmax <- 2.0

cat("Working")

# Main Loop.
for (Px in 1:xres) {
  x0 <- (Px/xres)*((xmax-xmin))+xmin
  cat(".")
  for (Py in 1:yres) {
    y0 <- (Py/yres)*((ymax-ymin))+ymin

    iter <- 0
    x <- 0.0
    y <- 0.0

    while ((x*x + y*y < rmax*rmax) && (iter < max_iter)) {
      xt <- (x*x) - (y*y) + x0
      y <- 2*x*y + y0
      x <- xt
      iter <- iter + 1
    }
    img[Py,Px] <- max_iter - iter
  }
}

# Write file.
source("imageio.R")
writepgm(img, white=(max_iter - 1), filename="mandel.pgm")

# Tidy.
cat("Done.\n")
