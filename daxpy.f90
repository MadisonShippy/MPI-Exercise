DaxpyProgram
  implicit none
  real, dimension(:,:), allocatable :: x,y
  integer i, j
  real time_begin, time_end
interface 
  subroutine daxpy(x,y)
    real, dimension(:,:), intent(in) :: x
    real, dimension(:,:), intent(out) :: y
  end subroutine 

end interface

  allocate (x(10,10))
  allocate (y(10,10))
call CPU_TIME(time_begin)

do i = 1,10
  do j = 1,10
    x(i,j) = (10.2*i)
    y(i,j) = 10.2
  end do
end do

call daxpy(x,y)
print *,' Result: '

do i = 1,10
  do j = 1,10
    write (*,*) 'Matrix(',i,',',j,')=',y(i,j)
  end do
end do

call CPU_TIME(time_end)
write (*,*) 'time of operation: ', time_end - time_begin, 's'

deallocate(x)
deallocate(y)

end program DaxpyProgram

subroutine daxpy(x,y)
  implicit none
  real, dimension(:,:), intent(in) :: x
  real, dimension(:,:), intent(out) :: y

  integer :: n 
  real :: alpha,ix,iy
  integer :: incx, incy, i, j

  n = 10
  alpha = 4.0
  incx = 1
  incy = 1
  i = 0

  if ((incx == 1) .and. (incy == 1)) then 
    do i = 1,n
      do j = 1,n
        y(i,j) = alpha*x(i,j) + y(i,j)
      end do
    end do
  end if 
 return
end subroutine
