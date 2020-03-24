program daxpy
  integer,parameter :: n = 10
  integer :: incx, incy
  real*8,save :: alpha, x(n), y(n)

  call Daxpy(n, alpha, x, incx, y, incy)
  print *, "this is the result", y
end program 
  
subroutine Daxpy(n, alpha, x, incx, y, incy)
  implicit none
  integer :: n, incx, incy
  double precision :: alpha, x(n), y(n)
  double precision :: i, ix, iy 

  if ((incx == 1) .and. (incy == 1)) then
      do i=1,n
        y(i) = alpha*x(i) + y(i)
      end do
  else
      ix = 1
      iy = 1
      
      do i=1,n
        ix = 1+(i-1)*incx
        iy = 1+(i-1)*incy
        y(iy) = a*x(ix)+y(iy)
      end do
  end if 
  return
     
end subroutine 

