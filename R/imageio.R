# R module for doing image I/O.
# Owain Kenway

# Write out a matrix d as pgm.
# - white - white value (max colour value)
# - filename = file to write to
#
# NOTE: we convert d to integers via floor.
writepgm <- function(d, white=255, filename="output.pgm") {
  y = nrow(d)
  x = ncol(d)
 
  cat("P2\n", file=filename, append=FALSE)
  cat("# Written by pnmmodules (https://github.com/owainkenwayucl/pnmmodules).\n", file=filename, append=TRUE)
  cat(x, y, "\n", file=filename, append=TRUE) 
  cat(white, "\n", file=filename, append=TRUE) 

# Write file by constructing a line string per line, and writing it.
# This balances between cat being slow (multiple file operations) on Windows 
# and paste() being slow for very large strings.
  for (j in 1:y) {
    line = ""
    for (i in 1:x) {
      line = paste(line, floor(d[j,i]), sep="\n")
    }
    cat(line, file=filename, append=TRUE)
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

# Write file by constructing a line string per line, and writing it.
# This balances between cat being slow (multiple file operations) on Windows 
# and paste() being slow for very large strings.
  for (j in 1:y) {
    line = ""
    for (i in 1:x) {
      if (d[j,i] >= threshold) {          
        line = paste(line, 1, sep="\n")
      } else {
        line = paste(line, 0, sep="\n")
      }
    }
    cat(line, file=filename, append=TRUE)
  }
}