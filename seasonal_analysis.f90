program seasonal_analysis
    implicit none
    integer, parameter :: nmax = 5000, nmonths = 12
    integer :: n, ios, year, month, i, count(nmonths)
    real :: yearFraction, rlr, sum_month(nmonths), average_month(nmonths)
    character(len=100) :: line

    ! Variables
    n = 0
    sum_month = 0.0
    count = 0

    ! Open de the RLR file
    open(unit=10, file='61.rlrdata', status='old', action='read')

    ! Read the data
    do while (n < nmax)
        read(10, '(A)', iostat=ios) line
        if (ios > 0) exit  ! 
        n = n + 1
        read(line, *, iostat=ios) yearFraction, rlr
        if (ios > 0) then
            print *, "Error reading data on the line", n
            exit
        elseif (rlr /= -99999.0) then  ! Ignore missing values
            year = int(yearFraction)
            month = int((yearFraction - year) * 12.0) + 1
            if (month >= 1 .and. month <= nmonths) then
                count(month) = count(month) + 1
                sum_month(month) = sum_month(month) + rlr
            endif
        endif
    end do

    close(10)

    ! Monthly mean
    do i = 1, nmonths
        if (count(i) > 0) then
            average_month(i) = sum_month(i) / count(i)
        else
            average_month(i) = -99999.0  ! 'No data' indicator
        endif
    end do

    ! Print the monthly mean
    print *, "Monthly mean sea level (RLR):"
    do i = 1, nmonths
        if (average_month(i) /= -99999.0) then
            print *, "Month ", i, ": ", average_month(i)
        else
            print *, "Month ", i, ": no data"
        endif
    end do

end program seasonal_analysis
