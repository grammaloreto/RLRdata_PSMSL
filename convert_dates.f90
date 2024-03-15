
program convert_dates
    implicit none
    integer, parameter :: nmax = 5000
    character(len=100) :: line
    real :: yearFraction
    integer :: year, month, n, ios
    character(len=10) :: str_date

    ! Opening the RLR file
    open(unit=10, file='61.rlrdata', status='old', action='read')

    n = 0
    do while (n < nmax)
        read(10, '(A)', iostat=ios) line  ! Read each line as a complete string
        if (ios > 0) then
            exit 
        else
            n = n + 1
            ! Breaks the line down into its individual components
            read(line, *, iostat=ios) yearFraction
            if (ios > 0) then
                print *, "Error reading data on the line", n
                exit
            else
                ! Calculate the year and month from the fraction of the year
                year = int(yearFraction)
                month = int((yearFraction - year) * 12.0) + 1  
                ! Month between 1 and 12
                month = min(max(month, 1), 12)
                ! Convert and display date in 'YYYY-MM-DD' format
                write(str_date, '(I4, "-", I2.2, "-", "01")') year, month
                print *, 'Converted date: ', trim(str_date)
            endif
        endif
    end do

    close(10)

    if (n == 0) then
        print *, "No data was read from the file."
    endif

end program convert_dates
