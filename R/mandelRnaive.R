# Example naive mandelbrot in R.
# Owain Kenway

# Range for maths.
xmax <- 2.0
xmin <- -2.0

ymax <- 2.0
ymin <- -2.0

# Resolution of plot.
xres <- 2048
yres <- 2048

# Resolution of file.
fxres <- 1024
fyres <- 1024

# In memory matrix that represents the plot.
img <- matrix(0.0, nrow = yres, ncol=xres)

# Maximum number of interations.
max_iter <- 100

# Rmax is the point we declare escape.
rmax <- 2.0

# Generate a greyscale color map.
cols <- colorRampPalette(c("white","black"))(max_iter)

# Open our  output file.
png(file="output.png", width=fxres, height=fyres)

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
    img[Py,Px] <- iter
  }
}

# Transpose image as matrices are not display co-ords.
timg <- t(img)

# Write file.
image(1:xres, 1:yres, timg, col=cols, useRaster=TRUE, axes=FALSE, ann=FALSE, frame.plot=FALSE)

# Tidy.
cat("Done.\n")