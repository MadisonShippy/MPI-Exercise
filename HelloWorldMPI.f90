program hello_world_mpi
include 'mpif.h'

integer rank, size, ierror

call MPI_INIT(ierror)
call MPI_COMM_SIZE(MPI_COMM_WORLD, size, ierror)
call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierror)

do i = 0, 3, 1
  if (i == rank) then
    print *, 'hello world from process: ', rank, 'of ', size
  end if 

  call MPI_BARRIER(MPI_COMM_WORLD, ierror)
end do

call MPI_Finalize(ierror)

end program

