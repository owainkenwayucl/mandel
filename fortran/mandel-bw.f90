program mandel

  use imageout

  implicit none
  
  double precision :: xmax, xmin, ymax, ymin, rmax, x0, y0, x, y, xt
  integer :: xres, yres, max_iter, iter, px, py
  integer, dimension(:,:), allocatable :: pixels

  xmax = 2.0
  xmin = -2.0
  
  ymax = 2.0
  ymin = -2.0

  xres = 128
  yres = 128

  max_iter = 256

  rmax = 2.0

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
  
  open(unit=24, file="mandel.pbm")
  call writepbm(pixels, xres, yres, 1, 24)
  close(24)
  deallocate(pixels)
end program mandel
