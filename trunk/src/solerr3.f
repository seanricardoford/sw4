c------------------------------------------------------------
      subroutine solerr3(ifirst, ilast, jfirst, jlast, kfirst, klast,
     +     h, uex, u, li, l2)
      implicit none
      integer ifirst, ilast, jfirst, jlast, kfirst, klast
      real*8 h
      real*8 uex(3,ifirst:ilast,jfirst:jlast,kfirst:klast)
      real*8 u(3,ifirst:ilast,jfirst:jlast,kfirst:klast)
     
      integer c, k, j, i
      real*8 li, l2, err(3)

      li = 0
      l2 = 0
c tmp
c      write(*,*)'if=', ifirst, 'il=', ilast, 'jf=', jfirst, 'jl=',
c     +     jlast, 'kf=', kfirst, 'kl=', klast
c this test includes interior points (the arrays include an extra ghost point in k)
      do k=kfirst+2,klast-2
        do j=jfirst+2,jlast-2
          do i=ifirst+2,ilast-2
c exact solution in array 'uex'
            do c=1,3
              err(c) = ABS( u(c,i,j,k) - uex(c,i,j,k) )
            enddo
            if( li.lt.max(err(1),err(2),err(3)) )then
              li = max(err(1),err(2),err(3))
            endif
            l2 = l2 + 
     +           h*h*h* (err(1)**2 + err(2)**2 + err(3)**2)
          enddo
        enddo
      enddo
c$$$      write(*,101) 'Solution errors in max- and L2-norm: ', li, l2
c$$$ 101  format(' ', a, 2(g15.7,tr2))
      return
      end

c------------------------------------------------------------
      subroutine solerrgp(ifirst, ilast, jfirst, jlast, kfirst, klast,
     +     h, uex, u, li, l2)
      implicit none
      integer ifirst, ilast, jfirst, jlast, kfirst, klast
      real*8 h
      real*8 uex(3,ifirst:ilast,jfirst:jlast,kfirst:klast)
      real*8 u(3,ifirst:ilast,jfirst:jlast,kfirst:klast)
     
      integer c, k, j, i
      real*8 li, l2, err(3)

      li = 0
      l2 = 0
c tmp
c      write(*,*)'if=', ifirst, 'il=', ilast, 'jf=', jfirst, 'jl=',
c     +     jlast, 'kf=', kfirst, 'kl=', klast
c this test only includes the ghost points
      k=kfirst+1
      do j=jfirst+2,jlast-2
        do i=ifirst+2,ilast-2
c exact solution in array 'uex'
          do c=1,3
            err(c) = ABS( u(c,i,j,k) - uex(c,i,j,k) )
          enddo
          if( li.lt.max(err(1),err(2),err(3)) )then
            li = max(err(1),err(2),err(3))
          endif
          l2 = l2 + 
     +         h*h*h* (err(1)**2 + err(2)**2 + err(3)**2)
        enddo
      enddo

      k=klast-1
      do j=jfirst+2,jlast-2
        do i=ifirst+2,ilast-2
c exact solution in array 'uex'
          do c=1,3
            err(c) = ABS( u(c,i,j,k) - uex(c,i,j,k) )
          enddo
          if( li.lt.max(err(1),err(2),err(3)) )then
            li = max(err(1),err(2),err(3))
          endif
          l2 = l2 + 
     +         h*h*h* (err(1)**2 + err(2)**2 + err(3)**2)
        enddo
      enddo
c$$$      write(*,101) 'Solution errors in max- and L2-norm: ', li, l2
c$$$ 101  format(' ', a, 2(g15.7,tr2))
      return
      end

