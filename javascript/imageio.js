/*
  This module provides routines for writing PGM/PBM images in Node.js.
  Owain Kenway
 */

module.exports = {
// Write PGM images.
// d - the 2d array to write.
// white - the value of white (max value).
// filename - the file to write to.
    writepgm: function(d, white, filename) {
        const fs = require('fs');

// Determine array dimensions
        x = d.length;
        y = d[0].length;

// Open our file
        var outfile = fs.createWriteStream(filename, {'flags':'w'});

// Write header
        outfile.write('P2\n');
        outfile.write('# Written by pnmmodules (https://github.com/owainkenwayucl/pnmmodules).\n');
        outfile.write(x + ' ' + y + '\n' + white + '\n');

// Write out our array
        for (var j=0; j < y; j++) {
            for (var i=0; i < x; i++) {
                outfile.write(d[i][j] + '\n');
            }
        }

// Tidy up
        outfile.end('');
    },

// Write PBM images.
// d - the 2d array to write.
// threshold - the value of at which 0 becomes 1.
// filename - the file to write to.
    writepbm: function(d, threshold, filename) {
        const fs = require('fs');

// Determine array dimensions
        x = d.length;
        y = d[0].length;

// Open our file
        var outfile = fs.createWriteStream(filename, {'flags':'w'});

// Write header
        outfile.write('P1\n');
        outfile.write('# Written by pnmmodules (https://github.com/owainkenwayucl/pnmmodules).\n');
        outfile.write(x + ' ' + y + '\n');

// Write out our array
        for (var j=0; j < y; j++) {
            for (var i=0; i < x; i++) {
                if (d[i][j] >= threshold) {
                    outfile.write('1\n');
                } else {
                    outfile.write('0\n');
                }
            }
        }

// Tidy up
        outfile.end('');
    }

}