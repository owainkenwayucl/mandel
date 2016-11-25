// Implementation of mandelbrot set in Swift.
// Uses my pnmmodules (https://github.com/owainkenwayucl/pnmmodules) PGM writer
// Owain Kenway

let xres: Int = 2048
let yres: Int = 2048

let xmin: Double = -2.0
let xmax: Double = 2.0

let ymin: Double = -2.0
let ymax: Double = 2.0

let rmax: Double = 2.0

let max_iter: Int = 256

var pixels: [[Int]] = Array(repeating: Array(repeating: 0, count: yres), count: xres)

for px in 1...xres {
    let x0: Double = ((Double(px)/Double(xres)) * Double(xmax - xmin)) + xmin

    for py in 1...yres {
        let y0: Double = ((Double(py)/Double(yres)) * Double(ymax - ymin)) + ymin

        var iter: Int = 0
        var x: Double = 0.0
        var y: Double = 0.0

        while (((x*x + y*y) < (rmax * rmax)) && (iter < max_iter)) {
            let xt = (x*x) - (y*y) + x0
            y = 2.0 * x * y + y0
            x = xt
            iter = iter + 1             
        }
        pixels[px-1][py-1] = max_iter - iter
    }
}
writepgm(d:pixels, white:(max_iter - 1), filename:"mandel.pgm")