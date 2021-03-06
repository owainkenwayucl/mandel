program mandel

  use imageout

  implicit none
  
  double precision :: xmax, xmin, ymax, ymin, rmax, x0, y0, x, y, xt
  double precision :: start_t, startio_t, stop_t
  integer :: xres, yres, max_iter, iter, px, py
  integer, dimension(:,:), allocatable :: pixels

  xmax = 2.0
  xmin = -2.0
  
  ymax = 2.0
  ymin = -2.0

  xres = 2048
  yres = 2048

  max_iter = 256

  rmax = 2.0

  call cpu_time(start_t)

  allocate(pixels(xres,yres))

  do px = 1, xres
    x0 = ((dble(px)/dble(xres)) * dble(xmax - xmin)) + xmin

    do py = 1, yres
      y0 = ((dble(py)/dble(yres)) * dble(ymax - ymin)) + ymin
      iter = 0
      x = 0.0
      y = 0.0
      
      do while (((x*x + y*y) .lt. (rmax * rmax)) .and. (iter .lt. max_iter))
        xt = (x*x) - (y*y) + x0
        y = 2.0 * x * y + y0
        x = xt
        iter = iter + 1
      end do
      pixels(px,py) = max_iter - iter
    end do

  end do

  call cpu_time(startio_t)
  
  open(unit=24, file="mandel.pgm")
  call writepgm(pixels, xres, yres, (max_iter - 1), 24)
  close(24)
  deallocate(pixels)

  call cpu_time(stop_t)

  write(*,'(A,1F12.5,A)') "Time spent in Mandelbrot:", (startio_t - start_t), " seconds"
  write(*,'(A,1F12.5,A)') "Time spent in I/O:       ", (stop_t - startio_t), " seconds"
  write(*,'(A,1F12.5,A)') "Total:                   ", (stop_t - start_t), " seconds"
end program mandel
