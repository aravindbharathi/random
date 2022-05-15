program main
    use class_lv
    implicit none

    ! Bloch Hamiltonian
    complex H0(2,2)
    complex h
    ! Onsite energy and hopping strength
    real epsilon, t1
    real M, t2
    ! Momentum vector k = (kx, ky)
    real k(2)
    ! Energy eigenvalues E = (acoustic, optical) branch
    real E(2)
    ! Iterator variables
    integer i, j, l
    ! # data points
    ! integer, parameter :: n = 20
    integer n, arglen
    character(:), allocatable :: arg
    if (command_argument_count() .eq. 1) then 
        call get_command_argument(number=1, length=arglen)
        allocate (character(arglen) :: arg)
        call get_command_argument(number=1, value=arg)
        read (arg,'(I10)') n
    else 
        n = 20
    end if
    epsilon = 1.0
    t1 = 1.0
    M = 0.0
    t2 = 0.00

    l = 1

    ! Data saved in file
    open(4, file='output.dat', status='new')

    ! Data
    do i = -2*n, 2*n
        do j = -2*n, 2*n
            k(1) = i*1.3/n
            k(2) = j*1.3/n
            call BlockHam(H0, k, t1, epsilon)
            call Haldane(H0, M, t2, k)
            call Eig(H0, E)
            write(4,*) k(1), k(2), E(1), E(2)
        end do
    end do

    close(4)
    
    !k(1) = 2*PI/3
    !k(2) = 2*PI/3/sqrt(3.0)

    !print*, h(k, t1)
    !call BlockHam(H0, k, t1, epsilon)
    !print*, H0
    !call Eig(H0, E)
    !print*, E
end program main

! Need to write numerical eigenvalue solver
! Need to write real space Bloch Hamiltonian --> Diagonalisation --> Fourier Transform
! Need to write local maxima calculator to find Dirac cones
! Python: Need to write scatter plot to signify Dirac cone

subroutine Haldane(H0, M, t2, k)
    use class_lv
    complex H0(2,2)
    real M, t2
    real sigma_z(2,2)
    real k(2)
    complex vec

    type(lv) :: b

    vec = cmplx(1,0) + cmplx(1./2., sqrt(3.)/2.)

    b = lv(vec)

    call b%construct

    sigma_z(1,1) = 1
    sigma_z(1,2) = 0
    sigma_z(2,1) = 0
    sigma_z(2,2) = -1

    do i = 1, 2
        do j = 1, 2
            H0(i,j) = H0(i,j) + sigma_z(i,j)*M + 2*t2*cmplx(1,0) * &
                    sigma_z(i,j)*(sin(sum(k*b%a1)) + sin(sum(k*b%a2)) + sin(sum(k*b%a3)))
        end do   
    end do
end subroutine
! Function to calculate Energy eigenvalue
! Input: Bloch Hamiltonian
! Returns: Energy eigenvalues
subroutine Eig(H0, E)
    complex H0(2,2)
    real E(2)
    real epsilon
    real M
    complex trace, det
    epsilon = (H0(1,1) + H0(2,2))/2
    M = abs(H0(1,1) - H0(2,2))/2
    trace = H0(1,1) + H0(2,2)
    det = H0(1,1)*H0(2,2) - H0(1,2)*H0(2,1)
    
    E(1) = trace/2. - 1./2. * sqrt(abs(trace**2 - 4*det))
    E(2) = trace/2. + 1./2. * sqrt(abs(trace**2 - 4*det))
end subroutine

! Function to calculate Bloch Hamiltonian
! Input: momentum vector k(2), nearest neighbour hopping amplitude, onsite energy
! Returns: Bloch Hamiltonian in momentum space
subroutine BlockHam(H0, k, t1, epsilon)
    use class_lv
    implicit none
    complex sigma_x(2,2), sigma_y(2,2), sigma_0(2,2), H0(2,2)
    integer i,j
    real t1, epsilon
    real k(2)
    
    type(lv) :: a
    a = lv(1.)

    sigma_x(1,1) = 0
    sigma_x(1,2) = 1
    sigma_x(2,1) = 1
    sigma_x(2,2) = 0

    sigma_y(1,1) = 0
    sigma_y(1,2) = cmplx(0,-1)
    sigma_y(2,1) = cmplx(0,1)
    sigma_y(2,2) = 0

    sigma_0(1,1) = 1
    sigma_0(1,2) = 0
    sigma_0(2,1) = 0
    sigma_0(2,2) = 1

    call a%construct

    do i = 1, 2
        do j = 1, 2
            H0(i,j) = sigma_x(i,j)*(cos(sum(k*a%a1)) + cos(sum(k*a%a2)) + cos(sum(k*a%a3))) &
                    - sigma_y(i,j)*(sin(sum(k*a%a1)) + sin(sum(k*a%a2)) + sin(sum(k*a%a3)))
            H0(i,j) = t1*H0(i,j)
            H0(i,j) = H0(i,j) + sigma_0(i,j)*epsilon
        end do   
    end do

end subroutine

! Function to calculate hopping amplitude
! Input: momentum vector k(2)
! Returns: hopping amplitude
complex function h(k, t1)
    use class_lv
    implicit none
    real k(2)
    real t1
    type(lv) :: a
    a = lv(1.)

    call a%construct
    
    h = cexp(complex(0,1)*sum(k*a%a1)) + cexp(complex(0,1)*sum(k*a%a2)) + cexp(complex(0,1)*sum(k*a%a3))
    h = h*t1
    
endfunction