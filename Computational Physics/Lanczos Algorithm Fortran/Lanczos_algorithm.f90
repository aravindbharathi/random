program main
    implicit none
    real h, Emin, Emax, E
    real delta
    integer, parameter :: N = 40
    real a(N), b(N+1), indx(N)
    complex T, G, G_ii
    integer i, j
    integer intervals
    real nofE
    complex z
    complex c_a(N+1), c_b(N+1)

    Emin = -10
    Emax = 10
    h = 0.01
    delta = 0.001
    intervals = int((Emax - Emin)/h)
    z = cmplx(Emin, delta)
    i = 1

    open(4, file = 'data.txt', status = 'old')
    b(1) = 1.0
    c_b(1) = cmplx(b(1), 0)
    do j = 1, N
        read(4,*) indx(j), a(j), b(j+1)
        c_a(j) = cmplx(a(j), 0)
        c_b(j+1) = cmplx(b(j+1), 0)
    end do

    G_ii = G(z, a, b, i, N)

    print*, G_ii
    !print*, b(N)**2 / (z - a(N) - b(N+1)**2*T(z, a, b, N))
    print*, nofE(G_ii)

    open(5, file = 'DOS.dat', status = 'new')
    do j = 0, intervals
        E = Emin + h*j
        z = cmplx(E, delta)
        G_ii = G(z, a, b, i, N)
        write(5, *) E, nofE(G_ii)
    end do

end program main

complex function T(z, a, b, i)
    complex z
    real a(40), b(41)
    integer i
    T = (z - a(i) - sqrt((z-a(i))**2 - 4*b(i+1)**2)) / (2*b(i+1)**2)
endfunction

recursive function G(z, a, b, i, N) result (G_ii)
    complex z
    real a(40), b(41)
    integer i
    complex G_ii, T
    if (i < N) then
        G_ii = (b(i)**2) / (z - a(i) - G(z, a, b, i+1, N))
    else
        G_ii = (b(N)**2) / (z - a(N) - b(N+1)**2 * T(z, a, b, N))
        !print*, G_ii
    endif
endfunction

real function nofE(G_ii)
    complex G_ii
    real, parameter :: PI = 3.1416
    nofE = -1/PI * imag(G_ii)
endfunction