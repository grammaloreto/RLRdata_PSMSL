!The slope represents the rate of change in sea level per year

program trend_analysis
    implicit none
    integer, parameter :: nmax = 5000
    integer :: n, ios, valid_count
    real :: yearFraction, rlr, sum_x, sum_y, sum_xy, sum_xx, slope, intercept
    real, dimension(nmax) :: valid_years, valid_rlr
    character(len=100) :: line

    ! Variables
    n = 0
    valid_count = 0
    sum_x = 0.0
    sum_y = 0.0
    sum_xy = 0.0
    sum_xx = 0.0

    ! RLR File
    open(unit=10, file='61.rlrdata', status='old', action='read')

    ! Read data and store valid values
    do while (n < nmax)
        read(10, '(A)', iostat=ios) line
        if (ios > 0) exit  
        n = n + 1
        read(line, *, iostat=ios) yearFraction, rlr
        if (ios > 0) then
            print *, "Error reading data on the line", n
            exit
        elseif (rlr /= -99999.0) then  ! Ignore missing values
            valid_count = valid_count + 1
            valid_years(valid_count) = yearFraction
            valid_rlr(valid_count) = rlr
            sum_x = sum_x + yearFraction
            sum_y = sum_y + rlr
            sum_xy = sum_xy + yearFraction * rlr
            sum_xx = sum_xx + yearFraction**2
        endif
    end do

    close(10)

    ! Calculates the slope and intercept of the trend
    if (valid_count > 1) then
        slope = (valid_count * sum_xy - sum_x * sum_y) / (valid_count * sum_xx - sum_x**2)
        intercept = (sum_y - slope * sum_x) / valid_count
    else
        print *, "There is not enough valid data for trend analysis."
        stop
    endif

    ! Print the results
    print *, "Slope (change per year):", slope
    print *, "Intercept", intercept
    print *, "The trend indicates that sea level is ", &
             "changing at a rate of ", slope, " units per year."

end program trend_analysis
