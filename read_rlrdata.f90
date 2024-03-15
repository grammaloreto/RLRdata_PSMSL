
program read_rlrdata
    implicit none
    integer, parameter :: nmax = 5000
    character(len=100) :: line
    integer :: n, ios

    ! Open rlrdata file
    open(unit=10, file='61.rlrdata', status='old', action='read')

    n = 0
    do while (n < nmax)
        read(10, '(A)', iostat=ios) line
        if (ios > 0) then
            exit  ! End of the file
        else
            n = n + 1
            print *, 'Line ', n, ': ', trim(line)
            if (n == 10) then  ! Print the first 10 lines to make sure is working
                exit
            endif
        endif
    end do

    close(10)

    if (n == 0) then
        print *, "No data was read from the file"
    endif

end program read_rlrdata
