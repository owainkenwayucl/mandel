'''
  This module provides routines for writing PGM/PBM images in Python (3.x)
  Owain Kenway
'''

# Write PGM images.
# d - the 2d list to write.
# white - the value of white (max value).
# filename - the file to write to.
def writepgm(d, white, filename):
    x = len(d)
    y = len(d[0])

# Open our file.
    f = open(filename, 'w')

# Write header.
    f.write('P2\n')
    f.write('# Written by pnmmodules (https://github.com/owainkenwayucl/pnmmodules).\n')
    f.write(str(x) + ' ' + str(y) + '\n')
    f.write(str(white) + '\n')

# Write out 2d list.
    for j in xrange(y):
        for i in xrange(x):
            f.write(str(d[i][j]) + '\n')


# Tidy up.
    f.close()

# Write PBM images.
# d - the 2d list to write.
# threshold - the value of at which 0 becomes 1.
# filename - the file to write to.
def writepbm(d, threshold, filename):
    x = len(d)
    y = len(d[0])

# Open our file.
    f = open(filename, 'w')

# Write header.
    f.write('P1\n')
    f.write('# Written by pnmmodules (https://github.com/owainkenwayucl/pnmmodules).\n')
    f.write(str(x) + ' ' + str(y) + '\n')

# Write out 2d list.
    for j in xrange(y):
        for i in xrange(x):
            if d[i][j] >= threshold:
                f.write('1\n')
            else:
                f.write('0\n')

# Tidy up.
    f.close()
