program DaxpyProgram
  implicit none
  include 'mpif.h'
  real, dimension(:), allocatable :: x, y, z, xpart, ypart, zpart, tempx, tempy, tempz
  integer alpha, n, i, ops, p, rank, error, iy
  real :: begin, finish, start, done
  
  !initialize variables to test
  i = 0
  n = 50
  alpha = 4
  
  call MPI_INIT(error)
  call MPI_COMM_SIZE(MPI_COMM_WORLD, p, error)
  call MPI_COMM_RANK(MPI_COMM_WORLD, rank, error)

  print *, 'process', rank, 'running'

  if (MOD(n,p)/=0) then
    ops = n/p + 1
  else
    ops = n/p
  endif

  start = (rank*ops)+1
  done = (rank+1)*ops

  print *, 'operations: ', ops
  allocate(x(n))
  allocate(y(n))
  allocate(z(n)) 
  allocate(xpart(ops))
  allocate(ypart(ops))
  allocate(zpart(ops))
  
  do i = 1, n
    x(i) = 10.2 *i
    y(i) = 10.2
    z(i) = 10.2
  enddo

  do i = 1,ops
    xpart(i) = 10.2*i
    ypart(i) = 10.2
    zpart(i) = 10.2
  enddo

  print *, 'got to process',rank
  
  xpart = x((rank*ops)+1:(rank+1)*ops)
  ypart = y((rank*ops)+1:(rank+1)*ops)
  zpart = z((rank*ops)+1:(rank+1)*ops)
  
  if(rank.eq.0)then
    call CPU_TIME(begin)
  endif

  do iy = 1, ops
    if(ops*rank+iy <=  n) then
      zpart(iy)=alpha*xpart(iy) + ypart(iy)
    endif
  enddo

  x((rank*ops)+1:(rank+1)*ops) = xpart
  y((rank*ops)+1:(rank+1)*ops) = ypart
  z((rank*ops)+1:(rank+1)*ops) = zpart
 
  if(rank.eq.0) then
    do i = 1,n
      print *, z(i)
    end do
  end if

  if(rank.eq.0)then
    call CPU_TIME(finish)
  endif

  if(rank.eq.0)then
    write (*,*) 'time of operation: ', finish-start, 's'
  endif

  deallocate(x)
  deallocate(y)
  deallocate(z)
  deallocate(xpart)
  deallocate(ypart)
  deallocate(zpart)
  
  if(rank.eq.0)then
    print *, 'exiting on process: ', rank
  endif
  call MPI_Finalize(error)
end program
