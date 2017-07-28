(load "imageio.cl")

(defun mandel (xmin xmax ymin ymax maxiter xres yres filename)
  (let ((x 0.0) 
        (y 0.0) 
        (x0 0.0) 
        (y0 0.0) 
        (xt 0.0) 
        (it 0) 
        (r2 4.0)
        (pixels (make-array (list xres yres) :initial-element 0)))

    (loop for px from 0 to (- xres 1) do
      (setq x0 (* -1 (+ (* (/(+ px 1) xres) (- xmax xmin)) xmin)))
      (loop for py from 0 to (- yres 1) do
        (setq y0 (+ (* (/ (+ py 1) yres) (- ymax ymin)) ymin))

        (setq it 0)
        (setq x 0.0)
        (setq y 0.0)

        (loop while (and (< (+ (* x x) (* y y)) r2) (< it maxiter)) do
          (setq xt (+ (- (* x x) (* y y) x0)))
          (setq y (+ (* (* y x) 2.0) y0))
          (setq x xt)
          (setq it (+ it 1))
        )
        (setf (aref pixels px (- yres (+ py 1))) (- maxiter it))
      )
    )
    (writepgm pixels (- maxiter 1) filename)
  )
)
