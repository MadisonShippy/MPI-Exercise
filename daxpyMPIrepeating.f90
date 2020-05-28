program DaxpyProgram
  implicit none
  include 'mpif.h'
  real, dimension(:), allocatable :: x, y, z, xpart, ypart, zpart
  integer alpha, n, i, ops, p, rank, error, iy
  real :: start, finish  

  !initialize variables to test
  i = 0
  n = 2048
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

if(rank.eq.0) then
  print *, 'operations: ', ops
  allocate(x(n))
  allocate(y(n))
  allocate(z(n))
endif

  allocate(xpart(ops))
  allocate(ypart(ops))
  allocate(zpart(ops))  

if (rank.eq.0) then
  do i = 1, n
    x(i) = 10.2 *i
    y(i) = 10.2
    z(i) = 10.2
  enddo
endif

do i = 1,ops
  xpart(i) = 10.2*i
  ypart(i) = 10.2
  zpart(i) = 10.2
enddo

if(rank.eq.0)then
  call MPI_Scatter(x, ops, MPI_REAL, xpart, ops, MPI_REAL, 0, MPI_COMM_WORLD, error)
  call MPI_Scatter(y, ops, MPI_REAL, ypart, ops, MPI_REAL, 0, MPI_COMM_WORLD, error)
  call MPI_Scatter(z, ops, MPI_REAL, zpart, ops, MPI_REAL, 0, MPI_COMM_WORLD, error)
endif

print *, 'got to process',rank

if(rank.eq.0)then
  call CPU_TIME(start)
endif

do iy = 1, ops
   if(ops*rank+iy <=  n) then
      zpart(iy)=alpha*xpart(iy) + ypart(iy)
   endif
enddo

call MPI_GATHER(zpart, ops, MPI_REAL, z, ops, MPI_REAL, 0, MPI_COMM_WORLD, error)

if (rank.eq.0) then
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

if(rank.eq.0)then
  deallocate(x)
  deallocate(y)
  deallocate(z)
endif

deallocate(xpart)
deallocate(ypart)
deallocate(zpart)

print *, 'exiting on process: ', rank

call MPI_Finalize(error)

end program
