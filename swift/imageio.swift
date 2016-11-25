// Module of functions for writing PGM and PBM files in Swift.
// Owain Kenway

import Foundation

// A private class to make writing to OutputStream less of a mess.
// (i.e. more like other programming langauges!)
fileprivate class textfile {
    var filename : String
    var stream : OutputStream

    init(filename: String) {
        self.filename = filename
        self.stream = OutputStream(toFileAtPath: filename, append: false)!
    }

    func open() {
        self.stream.open()
    }

    func close() {
        self.stream.close()
    }

// This is the really unpleasant one method (i.e. why we are doing this.)
    func write(data: String) {
        let retval: Int = self.stream.write(data, maxLength: data.lengthOfBytes(using: String.Encoding.utf8))
        if retval == -1 {
            print("Something has gone horribly wrong.")
            exit(-1)
        }
    }
}

// Method to write 2D array d as a PGM image.
// white: highest value in d
// filename: file to write to
public func writepgm(d: [[Int]], white: Int, filename: String) {
    let x: Int = d.count
    let y: Int = d[0].count
 
 // Open output stream.
    let out: textfile = textfile(filename: filename)
    out.open()

// Write header.
    out.write(data: "P2\n")
    out.write(data: "# Written by pnmmodules (https://github.com/owainkenwayucl/pnmmodules).\n")
    out.write(data: String(x) + " " + String(y) + "\n")
    out.write(data: String(white) + "\n")

    for j in 1...y {
        for i in 1...x {
            out.write(data: String(d[i-1][j-1]) + "\n")
        }
    }
    out.close()

} 

// Method to write 2D array d as a PBM image.
// threshold: value at which a pixel becomes 1.
// filename: file to write to
public func writepbm(d: [[Int]], threshold: Double, filename: String) {
    let x: Int = d.count
    let y: Int = d[0].count
 
 // Open output stream.
    let out: textfile = textfile(filename: filename)
    out.open()

// Write header.
    out.write(data: "P1\n")
    out.write(data: "# Written by pnmmodules (https://github.com/owainkenwayucl/pnmmodules).\n")
    out.write(data: String(x) + " " + String(y) + "\n")

    for j in 1...y {
        for i in 1...x {
            if (Double(d[i-1][j-1]) >= threshold) {
                out.write(data: "1\n")
            } else {
                out.write(data: "0\n")
            }
        }
    }
    out.close()

} 