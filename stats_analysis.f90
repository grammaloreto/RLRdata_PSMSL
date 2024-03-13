program stats_analysis
    implicit none
    integer, parameter :: nmax = 5000
    integer :: n, ios, valid_count, i
    real :: yearFraction, rlr, sum_rlr, mean, variance, stdev, min_rlr, max_rlr
    real, dimension(nmax) :: valid_rlr
    character(len=100) :: line

    ! Variable initialization
    n = 0
    valid_count = 0
    sum_rlr = 0.0
    variance = 0.0
    min_rlr = 1.0E30   ! A large number
    max_rlr = -1.0E30  ! A small number

    ! Open the RLR data file to read
    open(unit=10, file='61.rlrdata', status='old', action='read')

    ! Read data and store valid values
    do while (n < nmax)
        read(10, '(A)', iostat=ios) line
        if (ios > 0) exit  ! end
        n = n + 1
        read(line, *, iostat=ios) yearFraction, rlr
        if (ios > 0) then
            print *, "Error reading data on the line", n
            exit
        elseif (rlr /= -99999.0) then  ! Ignore missing values
            valid_count = valid_count + 1
            valid_rlr(valid_count) = rlr
            sum_rlr = sum_rlr + rlr
            min_rlr = min(min_rlr, rlr)
            max_rlr = max(max_rlr, rlr)
        endif
    end do

    close(10)

    ! Calculate the mean
    if (valid_count > 0) then
        mean = sum_rlr / valid_count
    else
        print *, "There is no valid data."
        stop
    endif

    ! Calculate the variance and standard deviation
    do i = 1, valid_count
        variance = variance + (valid_rlr(i) - mean)**2
    end do
    variance = variance / valid_count
    stdev = sqrt(variance)

    ! Print the statistical results
    print *, "Number of valid data:", valid_count
    print *, "Mean:", mean
    print *, "Variance:", variance
    print *, "Standard Deviation:", stdev
    print *, "Min:", min_rlr
    print *, "Max:", max_rlr

end program stats_analysis
