program to_csv
    implicit none
    integer, parameter :: nmax = 5000
    character(len=100) :: line
    real :: yearFraction, rlr
    integer :: year, month, n, ios
    character(len=10) :: str_date

    ! Open the RLR data file to read
    open(unit=10, file='61.rlrdata', status='old', action='read')
    ! Open a new file to save the converted dates and RLR values
    open(unit=20, file='marseille.csv', status='replace', action='write')

    ! Write CSV file header
    write(20, '(A)') 'Date,RLR'

    n = 0
    do while (n < nmax)
        read(10, '(A)', iostat=ios) line  ! Read each line as a complete string
        if (ios > 0) then
            exit  
        else
            n = n + 1
            ! Breaks the line down into its individual components
            read(line, *, iostat=ios) yearFraction, rlr
            if (ios > 0) then
                print *, "Error reading data on the line", n
                exit
            else
                ! Calculate the year and month from the fraction of the year
                year = int(yearFraction)
                month = int((yearFraction - year) * 12.0) + 1  ! 
                ! Month between 1 and 12
                month = min(max(month, 1), 12)
                ! Convert and display date in 'YYYY-MM-DD' format
                write(str_date, '(I4, "-", I2.2, "-", "01")') year, month
                ! Check if the RLR value is -99999, if so, leave the cell empty
                if (rlr == -99999.0) then
                    write(20, '(A, ",")') trim(str_date)
                else
                    write(20, '(A, ",", F6.0)') trim(str_date), rlr
                endif
            endif
        endif
    end do

    close(10)
    close(20)

    print *, "The converted dates and RLR values have been saved in marseille.csv"
end program to_csv

