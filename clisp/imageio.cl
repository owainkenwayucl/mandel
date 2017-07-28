; Common LISP module for doing image I/O.
; Owain Kenway

; Write out an array d as a pgm.
; - white - white value (max colour value)
; - filename = file to write to

; NOTE: we convert d to integers via floor.
(defun writepgm (d white filename)
  (defvar w (array-dimension d 0))
  (defvar h (array-dimension d 1))
 
  (with-open-file (pnmfile filename 
                       :direction :output 
                       :if-exists :supersede
                       :if-does-not-exist :create)
    (format pnmfile "P2~%")
    (format pnmfile "# Written by pnmmodules (https://github.com/owainkenwayucl/pnmmodules).~% ")
    (format pnmfile "~a ~a ~%" w h)
    (format pnmfile "~a ~%" white)
    (loop for j from 0 to (- h 1) do
      (loop for i from 0 to (- w 1) do
        (format pnmfile "~a " (floor (aref d i j)))
      )
      (format pnmfile "~%")
    )
  )
)

; Write out an array d as a pbm.
; - threshold - threshold at which a number is 1 rather than 0
; - filename = file to write to
(defun writepbm (d threshold filename)
  (defvar w (array-dimension d 0))
  (defvar h (array-dimension d 1))
 
  (with-open-file (pnmfile filename 
                       :direction :output 
                       :if-exists :supersede
                       :if-does-not-exist :create)
    (format pnmfile "P1~%")
    (format pnmfile "# Written by pnmmodules (https://github.com/owainkenwayucl/pnmmodules).~% ")
    (format pnmfile "~a ~a ~%" w h)
    (loop for j from 0 to (- h 1) do
      (loop for i from 0 to (- w 1) do
        (if (>= (aref d i j) threshold) 
           (format pnmfile "~a " 1)
           (format pnmfile "~a " 0)
        )
      )
      (format pnmfile "~%")
    )
  )
)

