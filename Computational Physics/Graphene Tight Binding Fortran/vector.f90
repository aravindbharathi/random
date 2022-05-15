module class_lv
  implicit none
    public
  real :: pi = 4*atan(1.0) ! Class-wide private constant

  type, public :: lv
     complex :: a
     real :: a1(2) = (/ 1., 0. /)
     real :: a2(2) = (/ -0.5, sqrt(3.)/2. /)
     real :: a3(2) = (/ -0.5, -sqrt(3.)/2. /)
   contains
     procedure :: construct => lv_construct
  end type lv
contains

  subroutine lv_construct(this)
    class(lv), intent(inout) :: this
    real x, y, theta, d
    real tmp_x, tmp_y
    x = realpart(this%a)
    y = imagpart(this%a)
    d = abs(this%a)
    theta = -atan(y/x)

    tmp_x = this%a1(1)*cos(theta) + this%a1(2)*sin(theta)
    tmp_y = this%a1(2)*cos(theta) - this%a1(1)*sin(theta)
    this%a1(1) = d*tmp_x
    this%a1(2) = d*tmp_y

    tmp_x = this%a2(1)*cos(theta) + this%a2(2)*sin(theta)
    tmp_y = this%a2(2)*cos(theta) - this%a2(1)*sin(theta)
    this%a2(1) = d*tmp_x
    this%a2(2) = d*tmp_y
    
    tmp_x = this%a3(1)*cos(theta) + this%a3(2)*sin(theta)
    tmp_y = this%a3(2)*cos(theta) - this%a3(1)*sin(theta)
    this%a3(1) = d*tmp_x
    this%a3(2) = d*tmp_y

  end subroutine lv_construct
end module class_lv


! program lv_test
!   use class_lv
!   implicit none

!   type(lv) :: c     ! Declare a variable of type Circle.
!   c = lv(2.)       ! Use the implicit constructor, radius = 1.5.
!   write(*, *) c%a
!   call c%construct         ! Call the type-bound subroutine
!   write(*, *) c%a1, c%a2, c%a3
! end program lv_test