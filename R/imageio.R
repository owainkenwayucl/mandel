# R module for doing image I/O.
# Owain Kenway

# Write out a matrix d as pgm.
# - colours = number of (grey) colours
# - filename = file to write to
#
# NOTE: we convert d to integers via floor.
writepgm <- function(d, colours=256, filename="output.pgm") {
  y = nrow(d)
  x = ncol(d)
 
  cat("P2\n", file=filename, append=FALSE)
  cat("# Written by pnmmodules (https://github.com/owainkenwayucl/pnmmodules).\n", file=filename, append=TRUE)
  cat(x, y, "\n", file=filename, append=TRUE) 
  cat(colours, "\n", file=filename, append=TRUE) 

  for (j in 1:y) {
    for (i in 1:x) {
      cat(floor(d[j,i]), "\n", file=filename, append=TRUE)
    }
  }
}

# Write out a matrix d as pbm.
# - threshold = threshold at which a number is 1 rather than 0
# - filename = file to write to
writepbm <- function(d, threshold=0.5, filename="output.pbm") {
  y = nrow(d)
  x = ncol(d)
 
  cat("P1\n", file=filename, append=FALSE)
  cat("# Written by pnmmodules (https://github.com/owainkenwayucl/pnmmodules).\n", file=filename, append=TRUE)
  cat(x, y, "\n", file=filename, append=TRUE) 

  for (j in 1:y) {
    for (i in 1:x) {
      if (d[j,i] >= threshold) {          
        cat(1, "\n", file=filename, append=TRUE)
      } else {
        cat(0, "\n", file=filename, append=TRUE)
      }
    }
  }
}