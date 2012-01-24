      function CSW( xi, latilde )
      real*8 xi, latilde
      CSW = sqrt(1-xi*xi)*sqrt(1-xi*xi/(2+latilde)) - (1-0.5d0*xi*xi)**2
      end


      function CSWP( xi, latilde )
      real*8 xi, latilde
      CSWP = -xi*sqrt(1-xi*xi/(2+latilde))/sqrt(1-xi*xi) -
     *      xi*sqrt(1-xi*xi)/(2+latilde)/sqrt(1-xi*xi/(2+latilde))
     *      + 2*xi*(1-0.5d0*xi*xi)
      end


      real*8 function RVEL( la, mu )
      implicit none
      real*8 la, mu
      real*8 pr, cRel, xi, latilde, csw0, dxi
      real*8 CSW, CSWP
      integer iter
      pr = la/(2*(la+mu))
      cRel = (0.87d0 + 1.12d0*pr)/(1+pr)
      xi = cRel
      latilde = la/mu
      csw0 = CSW(xi, latilde)
      do iter=0,9
        dxi = -csw0/CSWP(xi, latilde)
        xi  = xi+dxi
        csw0 = CSW(xi, latilde)
      enddo
      RVEL = xi      
      end

      subroutine rayleigh_exact( nx, ny, h, u, t, lambda, mu, omega )
      implicit none
      real*8 CSW, CSWP
      integer nx, ny, i, j, iter
      real*8 u(2,-1:nx+1,-1:ny+1), lambda, mu, omega, h, t
      real*8 pr, cRel, xi, latilde, csw0, dxi, c, xi2, amp1, amp2
      real*8 x, y, phase, pi
      pi = 4*ATAN(1d0)
      pr = lambda/(2*(lambda+mu))
      cRel = (0.87d0 + 1.12d0*pr)/(1+pr)
      xi = cRel
      latilde = lambda/mu
      csw0 = csw(xi, latilde)
      do iter=0,9
         dxi = -csw0/CSWP(xi, latilde)
         xi  = xi+dxi
         csw0 = CSW(xi, latilde)
      enddo
c      write(*,101) 'csw = ',csw0, ' xi=',xi
 101  format(' Rayleigh', a, g12.5, a, g18.11 )
      cRel = xi      
*** assuming unit density
      c  = cRel*sqrt(mu)
      xi = c/sqrt(mu)
      xi2 = xi*xi
c      write(*,*),'Rayleigh params:', cRel, mu, c, xi
      phase = pi/2
      amp1 = 1
      amp2 = -amp1*(2-xi2)/2
c      write(*,*)'Rayleigh:', omega, amp1, amp2, xi2, c, t, phase
      do j=-1,ny+1
         y = (j-1)*h
         do i=-1,nx+1
            x  = (i-1)*h
            u(1,i,j) = amp1 * exp( -abs(omega)*x*sqrt(1-xi2) ) * 
     *        cos(omega*(c*t + y) + phase) +
     *	  amp2 * exp( -abs(omega)*x*sqrt(1- xi2/(2+latilde)) ) * 
     *        cos(omega*(c*t + y) + phase)

            u(2,i,j) = amp1 * exp( -abs(omega)*x*sqrt(1-xi2) ) * 
     *  omega/abs(omega) * sqrt(1-xi2) * sin(omega*(c*t + y) + phase) +
     *    amp2 * exp( -abs(omega)*x*sqrt(1- xi2/(2+latilde)) ) * 
     *    omega/abs(omega) / sqrt(1-xi2/(2+latilde)) * 
     *        sin(omega*(c*t + y) + phase)
         enddo
      enddo
      end
