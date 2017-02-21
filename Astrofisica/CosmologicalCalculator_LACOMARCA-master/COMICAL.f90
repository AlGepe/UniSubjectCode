!===========================================================
! This program is a simple cosmological calculator that 
! calculates ages and various distances for different inputs
! of cosmological parameters.
!===========================================================
!===========================================================
                        PROGRAM COMICAL
!===========================================================
! This is a command-line based program that consists in 6 
! different DOUBLE PRECISION FUNCTIONs: one for the input, one for the 
! output and 4 for the different values we want to compute.
!===========================================================
! The integration method used here is the Simpsons adaptative
! method in an iterative fashion to avoid memory issues that
! arise when using recursive implementations.
!===========================================================
! The program is mean to be as user-friendly as a 
! command-line program can be so some adjustments might be 
! done to the input values if their are no sensible enough.
!===========================================================

    REAL :: omegaRad, omegaLambda, omegaMass, omegaK
    DOUBLE PRECISION, parameter :: c = 299792.458 ! km/s
    DOUBLE PRECISION :: zeta, hubble, A, lbound, rbound, error
    CHARACTER (LEN =40):: fileName
    DOUBLE PRECISION :: stepps

    ! Dummy data
    hubble = 71.0
    omegaRad = 0.0
    omegaMass = 0.24
    omegaLambda = 0.76
    error = 0.001
    zeta = 1091

    ! Get data
    values = 0! INPUT()
    omegaK = 1 - omegaMass -omegaLambda - omegaRad
    WRITE (6,*), omegaK
    ! useful quantity
    A = 1/(1+zeta)
    IF (values == 1) THEN

        !plot and file output

    ELSE IF (values == 0) THEN

        !only values
        DIST_PROP = DISTAPROPIA()
        !WRITE (6,*) 'propia: '
        DIST_LUMIN = DISTALUMEN()
        !WRITE (6,*) 'lumin: '
        DIST_ANG = DISTANGULAR()
        WRITE (6,*) 'Angular: ', A, omegaK
        UNIV_EDAD = 3.08568E19 * UNIEDAD() / 3.1536E16
        !WRITE (6,*) 'Uniedad: '
        CALL OUTPUT()

    END IF

    !CALL OUT2FILE(DIST_PROP, DIST_ANG, DIST_LUMIN, UNIV_EDAD)

CONTAINS

!============================================================
INTEGER FUNCTION INPUT() !check
!============================================================
! Command line based subroutine to input the desired vales 
! for the calculation. 
!------------------------------------------------------------
! Input values include astronomical parameters:
!       - Energy density
!       - Mass density
!       - Radiation Density
!       - Redshift (z) [Starting point, if graphs are wanted]
!       - Hubble constant
!····························································
! Input values also include numerical integration parameters:
!       - Number of steps for the integral calculation [graphs]
!       - Integration error allowed in each step
!       - Size of the step [graphs]
!
!============================================================

    INTEGER :: values

        WRITE(6,110) !Choice
    110 FORMAT('Enter 0 for calculator behaviour or 1 ' &
                'if you wish to get some data to plot')
        READ(5,*) values

    IF (values == 0) THEN
            WRITE(6,1000) ! Energia
        1000 Format('Densidad de energía')
            READ(5,*) omegaLambda
            WRITE(6,1001) ! Materia
        1001 Format('Densidad de materia')
            READ(5,*) omegaMass
            WRITE(6,1002) ! Radiación
        1002 Format('Densidad de radiación')
            READ(5,*) omegaRad 
            WRITE(6,1003) ! Redshift
        1003 Format('Corrimiento al rojo (z)')
            READ(5,*) zeta
            WRITE(6,1004) ! HacheCero
        1004 Format('Constante de Hubble')
            READ(5,*) hubble
            WRITE(6,1005) ! Error
        1005 Format('Error de integración numérica') 
            READ(5,*) error

    ELSE IF (values == 1) THEN

            WRITE(6,1100) ! redshift
        1100 Format('Starting Redshift (z)')
            READ(5,*) z
            WRITE(6,1101) ! #steps
        1101 Format('Number of steps')
            READ(5,*) stepps
            WRITE(6,1102) ! numerical error
        1102 Format('Maximum uncertainty allowed in each integration step')
            READ(5,*) error 
            WRITE(6,1103) ! fileName
        1103 Format('Set name for the output file')
            READ(5,*) fileName
            WRITE(6,1000) ! Energia
        1010 Format('Densidad de energía')
            READ(5,*) omegaLambda
            WRITE(6,1001) ! Materia
        1011 Format('Densidad de materia')
            READ(5,*) omegaMass
            WRITE(6,1002) ! Radiación
        1012 Format('Densidad de radiación')
            READ(5,*) omegaRad 
    
    ELSE 

        WRITE(6,13)
        13 FORMAT("I'm sorry Dave, I'm afraid I can't do that")

    END IF

    INPUT = values

    END FUNCTION INPUT

!============================================================
SUBROUTINE OUTPUT() !check
!============================================================
! Basic Screen Output subroutine for debugging
!============================================================


    WRITE (6,*) 'Distancia Propia: ', DIST_PROP
    WRITE (6,*) 'Distancia Angular: ' , DIST_ANG
    WRITE (6,*) 'Distancia Luminosidad: ', DIST_LUMIN
    WRITE (6,*) 'Edad del Universo: ' , UNIV_EDAD

    END SUBROUTINE OUTPUT

!============================================================
SUBROUTINE OUT2FILE(x, y, tags, fileName) !Pending
!============================================================
!      Subroutine that ouputs the data onto a file
!
!   This subroutine recieves the values ("x","y") obtained 
! and plots them in a file called "fileName" for future usage.
!
!   The format is fixed with two different columns (one for 
! each variable) with and initial header containing basic 
! information on what is being written and a secondary header,
! with a label over each column as titles for the values. 
! 
!   The values are printed as DOUBLE PRECISION numbers with 8 decimal 
! digits of precission which here is considered more than 
! enough for the purpose of the program.
!
!============================================================
    
    CHARACTER (LEN = 10), INTENT(IN) :: fileName
    DOUBLE PRECISION, INTENT(IN) :: x
    DOUBLE PRECISION, INTENT(IN) :: y
    CHARACTER, INTENT(IN) :: tags

    OPEN (unit = 1 , file = fileName)

        WRITE (1,3) fileName 
    3   FORMAT(a10)
        WRITE (1,4) fileName, "x", "y"
    4   FORMAT(a10, a16,a16)
        WRITE (1,5) filename, x, y
    5   FORMAT (a10, f16.8,f16.8)

    close (1)

    END SUBROUTINE OUT2FILE

!============================================================
DOUBLE PRECISION FUNCTION DISTAPROPIA()
!============================================================
! Function which returns the proper distance
!============================================================
    
    DOUBLE PRECISION :: massimo = 1.0

    area  = gauss2(1, A, massimo, error)

    SQUIRTLE = SQRT(ABS(omegaK))

    overHubble = c/(hubble)

    IF (omegaK > 0.0) THEN

        DISTA = overHubble * SINH(SQUIRTLE*area) / SQUIRTLE 
    
    ELSE IF (omegaK < 0.0) THEN
    
        DISTA = overHubble * SIN(SQUIRTLE*area) / SQUIRTLE

    ELSE
    
        DISTA = overHubble * area
    
    END IF

    DISTAPROPIA = DISTA

    END FUNCTION DISTAPROPIA

!============================================================
DOUBLE PRECISION FUNCTION DISTALUMEN()
!============================================================
! Calculates luminosity distance
!============================================================

    DOUBLE PRECISION :: massimo = 1.0

    area  = gauss2(1, A, massimo, error)

    SQUIRTLE = SQRT(ABS(omegaK))

    overHubble = c/(hubble)

    IF (omegaK > 0.0) THEN

        DISTA = overHubble * SINH(SQUIRTLE*area) / SQUIRTLE 
    
    ELSE IF (omegaK < 0.0) THEN
    
        DISTA = overHubble * SIN(SQUIRTLE*area) / SQUIRTLE

    ELSE
    
        DISTA = overHubble * area
    
    END IF

    DISTALUMEN = DISTA / A

    END FUNCTION DISTALUMEN

!============================================================
DOUBLE PRECISION FUNCTION DISTANGULAR()
!============================================================
! Caculates angular distance
!============================================================

    DOUBLE PRECISION :: massimo = 1.0

    area  = gauss2(1, A, massimo, error)

    SQUIRTLE = SQRT(ABS(omegaK))

    overHubble = c/(hubble)

    IF (omegaK > 0.0) THEN

        DISTA = overHubble * SINH(SQUIRTLE*area) / SQUIRTLE 
    
    ELSE IF (omegaK < 0.0) THEN
    
        DISTA = overHubble * SIN(SQUIRTLE*area) / SQUIRTLE

    ELSE
    
        DISTA = overHubble * area
    
    END IF

    DISTANGULAR = DISTA * A

    END FUNCTION DISTANGULAR

!============================================================
DOUBLE PRECISION FUNCTION UNIEDAD()
!============================================================
! Calculates universe age
!============================================================
    
    DOUBLE PRECISION :: minimo = 0.000000000000000000001
    DOUBLE PRECISION :: massimo = 1.0

    area = gauss2(2, minimo, massimo, error)

    UNIEDAD = area / hubble !needs not units change 

    END FUNCTION UNIEDAD

!============================================================
DOUBLE PRECISION FUNCTION EFOFEX(x, f)
!============================================================
! Value of f at point x
! Method: Evaluates the selected function f at the given 
!         point x
! written by: Alvaro Diez (February 2015)
!------------------------------------------------------------
! IN:
! f   - Function to evaluate (1 for distance, othe for age)
! x   - Point of evaluation
! OUT:
! efofex  - value of f(x)
!============================================================
    
    DOUBLE PRECISION, INTENT(IN) :: x
    INTEGER, INTENT(IN) :: f

    overx = 1 / x
    overx2 = overx * overx
    theRest = 1 /(x * SQRT(omegaLambda+(omegaK*overx2) &
                +(omegaMass*overx*overx2)+(omegaRad*overx2*overx2)))
 
    IF (f == 1) THEN
        EFOFEX = overx * theRest
    ELSE
        EFOFEX = theRest
    END IF

    END FUNCTION EFOFEX
                !*************************!
!============================================================
!============================================================
!             EXTERNAL CODE USED FOR INTEGRATION
!============================================================
!============================================================
                !*************************!
!============================================================
DOUBLE PRECISION function gauss2(f,a,b,eps)
!============================================================
! Integration of f(x) on [a,b]
! Method: Gauss quadratures with doubling number of intervals  
!         till  error = |I_16 - I_8| < eps
! written by: Alex Godunov (October 2009)
! adapted by: Álvaro Díez (February 2015)
!------------------------------------------------------------
! IN:
! f   - Function to integrate (supplied by a user)
! a   - Lower limit of integration
! b   - Upper limit of integration
! eps - tolerance
! OUT:
! integral - Result of integration
! nint     - number of intervals to achieve accuracy
!============================================================
    
    DOUBLE PRECISION, INTENT(IN) ::  a, b, eps
    DOUBLE PRECISION :: s1, s2, h, ax, bx, integral
    INTEGER :: nint, n, i
    INTEGER, parameter :: nmax=999999999 ! max number of intervals
    INTEGER, INTENT(IN) :: f

    ! loop over number of intervals (starting from 1 interval)
    n=1
    do while (n <= nmax)
       s1 = 0.0
       s2 = 0.0   
       h = (b-a)/dfloat(n)
       do i=1, n
          ax = a+h*dfloat(i-1)
          bx = ax + h
          s1 = s1 + gauss8(f,ax,bx)
          s2 = s2 + gauss16(f,ax,bx)
    !write(*,101) i, ax, bx, s1, s2
    !101 format(i5,4f15.5)
       end do
       if(abs(s2-s1)<= eps .and. abs(s2-s1)/abs(s2+s1)<= eps) then
          integral = s2
          nint = n
          exit
       end if
       integral = s2
       nint = n
       n = n*2
    end do

    WRITE(6,*) 'nint: ', nint
    gauss2 = integral 

    end FUNCTION gauss2

!============================================================
FUNCTION gauss8(f,a,b)
!============================================================
! Integration of f(x) on [a,b]
! Method: Gauss 8 points  
! written by: Alex Godunov (October 2009)
! adapted by: Álvaro Díez (February 2015)
!------------------------------------------------------------
! IN:
! f   - Function to integrate (supplied by a user)
! a   - Lower limit of integration
! b   - Upper limit of integration
! OUT:
! gauss8 - Result of integration
!============================================================

    INTEGER, parameter :: n=4
    DOUBLE PRECISION, INTENT(IN) :: a, b
    DOUBLE PRECISION :: ti(n), ci(n)
    data ti/0.1834346424, 0.5255324099, 0.7966664774, 0.9602898564/
    data ci/0.3626837833, 0.3137066458, 0.2223810344, 0.1012285362/ 
    DOUBLE PRECISION :: r, m, c
    INTEGER :: i
    INTEGER, INTENT(IN) :: f

    r = 0.0;
    m = (b-a)/2.0;
    c = (b+a)/2.0;

    do i = 1,n 
    r = r + ci(i)*(EFOFEX(m*(-1.0)*ti(i) + c, f) + EFOFEX(m*ti(i) + c, f))
    end do
        gauss8 = r*m
    end FUNCTION gauss8

!============================================================
FUNCTION gauss16(f,a,b)
!============================================================
! Integration of f(x) on [a,b]
! Method: Gauss 16 points  
! written by: Alex Godunov (October 2009)
! adapted by: Álvaro Díez (February 2015)
!------------------------------------------------------------
! IN:
! f   - Function to integrate (supplied by a user)
! a   - Lower limit of integration
! b   - Upper limit of integration
! OUT:
! gauss16 - Result of integration
!============================================================
    
    INTEGER, parameter :: n=8
    DOUBLE PRECISION, INTENT(IN) :: a, b
    DOUBLE PRECISION :: ti(n), ci(n)
    data ti/0.0950125098, 0.2816035507, 0.4580167776, 0.6178762444, &  
            0.7554044083, 0.8656312023, 0.9445750230, 0.9894009349/ 
    data ci/0.1894506104, 0.1826034150, 0.1691565193, 0.1495959888, &
            0.1246289712, 0.0951585116, 0.0622535239, 0.0271524594/ 
    DOUBLE PRECISION :: r, m, c
    INTEGER :: i
    INTEGER, INTENT(IN) :: f

    r = 0.0;
    m = (b-a)/2.0;
    c = (b+a)/2.0;

    do i = 1,n 
    r = r + ci(i)*(EFOFEX(m*(-1.0)*ti(i) + c, f) + EFOFEX(m*ti(i) + c, f))
    end do
        gauss16 = r*m
    end FUNCTION gauss16

!============================================================
! End of the aditional functions used. No more code ahead
!============================================================
END PROGRAM COMICAL

    ! !============================================================
    ! DOUBLE PRECISION FUNCTION gauss2(f, lbound, rbound, error)
    ! !============================================================
    ! !        Iterative & adaptative integration method
    ! !
    ! !   By using the Simpson approximate method for calculating 
    ! ! integrals (inplemented ) this subroutine calculates the 
    ! ! integral of the function "f" between "lbownd" and "rbound" 
    ! ! using as few steps as possible while attaining an error 
    ! ! below the threshold "error".
    ! !
    ! !   This function uses the STEP function and the f indentifier
    ! ! to compute the deride values at the relevant positions.
    ! !
    ! !============================================================
       
    !     DOUBLE PRECISION, INTENT(IN) :: lbound, rbound
    !     INTEGER, INTENT(IN) :: f
    !     DOUBLE PRECISION, INTENT(IN) :: error
    !     INTEGER :: n = 0
    !     INTEGER, parameter :: nmax = 1000
    !     DOUBLE PRECISION :: auxA, auxB, auxMid, dif

    !     gauss2 = 0.0
    !     auxA = lbound
    !     auxB = rbound

    !     WRITE (6,*), auxA

    !     DO 100 WHILE (auxA /= rbound)

    !         !WRITE (6,*), auxA
            
    !         auxMid = (auxA+auxB)/2.0; 

    !         Ione = STEP(auxA, auxB, f) 
    !         Itwo = STEP(auxA, auxMid, f) + STEP(auxMid, auxB, f)

    !         auxLen = auxB-auxA

    !         dif = ABS(Ione-Itwo)
            
    !         IF ((dif) <= error .or. n >= nmax) THEN
                

    !             gauss2 = gauss2 + Itwo
                
    !             fracOfLen = (auxB-lbound)/auxLen
    !             compare = MOD(fracOfLen,2.0)
    !             IF ( compare == 0.0) THEN    
                    
    !                 auxA = auxB
    !                 auxB = auxB+2.0*auxLen
                    
    !             ELSE 
                   
    !                 auxA = auxB
    !                 auxB = auxB+auxLen
                    
    !             END IF
                
    !         ELSE
                
    !             auxB = auxMid
    !             n = n + 1
                
    !         END IF 

    !     100 END DO

    !     END FUNCTION gauss2

    ! !============================================================
    ! DOUBLE PRECISION FUNCTION STEP(lowerBound, upperBound, f)
    ! !============================================================
    ! !    Simple Simpson Method for integral/Area calculation
    ! !
    ! !   This function calculates the area underneath a function 
    ! ! "f" by using the simple simpson method. This method consists
    ! ! on diving the interval in two halves and applying the 
    ! ! trapezoidal to compute the are on both intervals. Then sums
    ! ! them up and returns the final value.
    ! ! 
    ! !   This function is used for simplicity and modularity by
    ! ! the INTEGRAL function.
    ! !
    ! !   This function uses the EFOFEX function to decide which is
    ! ! the apropiate function to use and obtain the value of it
    ! ! at a certain point.
    ! ! 
    ! !============================================================

    !     DOUBLE PRECISION, INTENT(IN) :: lowerBound
    !     DOUBLE PRECISION, INTENT(IN) :: upperBound
    !     INTEGER, INTENT(IN) :: f
    !     DOUBLE PRECISION :: mid

    !     ! search for the right function
    !     mid = (lowerBound+upperBound)/2.0

    !     step = ((upperBound - lowerBound)/6.0) &
    !         * (EFOFEX(lowerBound, f) + (4.0 * EFOFEX(mid, f)) &
    !         + EFOFEX(upperBound,f))

    !     ! compte value at A and B
    !     ! return area

    !     END FUNCTION STEP
