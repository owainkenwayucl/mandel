/*
    Mandelbrot example in Javascript/Node.js.
    Dr Owain Kenway
 */

function mandel(xmin, xmax, ymin, ymax, max_iter, xres, yres, filename) {
    const imageio = require('./imageio.js');
    const rmax = 2.0;
    
    var pixels=[];

    for (var px = 0; px < xres; px++) {
        pixels[px] = [];

        var x0 = (((px + 1.0)/xres) * (xmax - xmin)) + xmin;
        for (var py = 0; py < yres; py++) {
            var y0 = (((py + 1.0)/yres) * (ymax - ymin)) + ymin;

            var it = 0;
            var x = 0.0;
            var y = 0.0;

            while (((x*x + y*y) < (rmax * rmax)) && (it < max_iter)) {
                var xt = (x*x) - (y*y) + x0;
                y = 2.0 * x * y + y0;
                x = xt;
                it = it + 1; 
            }

            pixels[px][py] = max_iter - it;

        }

    }
    imageio.writepgm(pixels, max_iter -1, filename);



}

mandel(-2.0, 2.0, -2.0, 2.0, 256, 2048, 2048, 'mandel.pgm');