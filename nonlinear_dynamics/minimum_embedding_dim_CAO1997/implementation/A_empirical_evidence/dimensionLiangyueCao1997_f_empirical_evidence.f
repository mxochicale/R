***************************************************************************
*      Pratical method for determing the minimum embedding dimension      *
*                     of a scalar time series                             *
*           L. Cao, Physica D, 110 (1 & 2), 43-52, 1997.                  *
*                                                                         *
*   Notices:   This program is ONLY used for your researches.            *
*                                                                         *
*	                                Liangyue Cao       March,1997.    *
***************************************************************************
      dimension x(20),v(50),a(50),ya(50)
      double precision  v,v0,vij
      integer d, tau

***************************************************************************
*     ndp  is the number of data points used for your calculation;
*     ndp  should be smaller than 100000; 
*     tau  is the time-delay used for phase space reconstructions;
*     maxd is the maximum dimension which you want to test;
*     maxd should be smaller than 50.
***************************************************************************
      ndp=20 		! Number of data points
      tau=1 			! Time delay value
      maxd=10			! Maximum embedding dimension 
      
	open(9,file='henon_xn.dat')              ! Data file	
!open(9,file='lorenz_N20.dat')     ! Data file
!open(9,file='lorenz_N20.dat')     ! Data file


	open(10,file='E1.dat')	
	open(11,file='E2.dat')	
      read(9,*) (x(i),i=1,ndp)

      write(*,*)' +++++++++++++++++++++++++++++++++++++++++++'
      write(*,*)' +++++++++++++++++++++++++++++++++++++++++++'
      write(*,*)' +++++++++++++++++++++++++++++++++++++++++++'
      write(*,*)' +++++++++++++++++++++++++++++++++++++++++++'
      write(*,*)'x(t) time serie = ', x
      write(*,*)' +++++++++++++++++++++++++++++++++++++++++++'
      write(*,*)' +++++++++++++++++++++++++++++++++++++++++++'
      write(*,*)' +++++++++++++++++++++++++++++++++++++++++++'
      write(*,*)' +++++++++++++++++++++++++++++++++++++++++++'




	!+++++++++++++++++++++++++++++++++++++++++++
	do d=1,maxd
	a(d)=0.
	ya(d)=0.
	ng=ndp-d*tau

        write(*,*)'========================'
        write(*,*)'====   d=', d
        write(*,*)'========================'
        write(*,*)'ng=', ng

		!+++++++++++++++++++++++++++++++++++++++++++
		do i=1,ng
		v0=1.e+30	
		write(*,*)'----------------------------------'
		write(*,*)'----------------------------------i=', i
		write(*,*)'----------------------------------'

			!+++++++++++++++++++++++++++++++++++++++++++
			do j=1,ng
			write(*,*)'----j=', j

			if(j.eq.i) go to 20  !!if true, it does jump to the next jth iteration
				write(*,*)'j and i are different '
				do k=1,d
				write(*,*)'k=',k,',  i+(k-1)*tau=', i+(k-1)*tau, x(i+(k-1)*tau)
				write(*,*)'k=',k,',  j+(k-1)*tau=', j+(k-1)*tau, x(j+(k-1)*tau)
				write(*,*)'v(k)=|xi-xj|', abs(x(i+(k-1)*tau) - x(j+(k-1)*tau))
				v(k)=abs( x(i+(k-1)*tau) - x(j+(k-1)*tau)  )
				enddo

			if (d.eq.1) go to 50 
			!if true, it jumps to 50 and the code proceeds 
			!if false, it execute the following line and the code proceeds 
				!Check which is the max of v(k) vector and save the value in v(d)
	    			write(*,*) 'd=',d,' is differen than 1'	
				do k=1,d-1
				v(k+1)=max(v(k),v(k+1))
				write(*,*)'k=',k,'v(k+1)=max(v(k),v(k+1))',v(k+1)
				enddo

50			vij=v(d)
			!
			!prove that vij is 0 <= vij <= v0
			!where v0 is originally equal to 1e+30
			!then if updated v0 is equal to vij and save the jth value in n0
			!
	    		write(*,*)'vij=v(d)=',v(d),'d=',d
				write(*,*)'vij.lt.v0', vij.lt.v0 ! vij is less than 1.e+30
				write(*,*)'vij.ne.0', vij.ne.0   ! vij is not equal to 0
				if (vij.lt.v0 .and. vij.ne.0) then !! prove that vij is 0 <= vij <= 1e+30
				n0=j
				v0=vij
				write(*,*)'n0=j=', j
				write(*,*)'v0=vij=', vij
				endif
20	    		continue
			enddo !!!!j=1,ng
			!-------------------------------------------
			write(*,*)'<<<<<<<<<<<<<<<<<<<<<<<<'
			write(*,*)'v0=', v0
			write(*,*)'i+d*tau', i+d*tau, x(i+d*tau)
			write(*,*)'n0+d*tau', n0+d*tau, x(n0+d*tau)
			write(*,*) 'abs ( x(',i+d*tau,')  - x(',n0+d*tau,')  ='
			write(*,*) abs(x(i+d*tau) - x(n0+d*tau) ) 
			write(*,*)'max(v0, abs(x(i+d*tau) - x(n0+d*tau) ) )/v0 ='
			write(*,*) max(v0, abs(x(i+d*tau) - x(n0+d*tau) ) )/v0

			a(d)= a(d) + max(v0, abs(x(i+d*tau) - x(n0+d*tau) ) )/v0
			write(*,*)'a(',d,')=a(d)= a(d) + max( .. )'			
			write(*,*) a(d)
			write(*,*)' - - - - - - - - - - - - - -'
			write(*,*)'i+d*tau', i+d*tau, x(i+d*tau)
			write(*,*)'n0+d*tau', n0+d*tau, x(n0+d*tau)
			write(*,*) 'abs ( x(',i+d*tau,')  - x(',n0+d*tau,')  ='
			write(*,*) abs(x(i+d*tau) - x(n0+d*tau) ) 
			ya(d)= ya(d) + abs(x(i+d*tau) - x(n0+d*tau) )
			write(*,*)'ya(',d,')=ya(d)= ya(d) + abs( .. )'			
			write(*,*) ya(d)

			write(*,*)'>>>>>>>>>>>>>>>>>>>>>>'

		enddo !!!!i=1,ng
		!-------------------------------------------


	write(*,*)'E1E2E1E2E1E2E1E2E1E2E1E2E1E2E1E2E1E2'
	a(d)=a(d)/float(ng)
	ya(d)=ya(d)/float(ng)
	write(*,*)'a(',d,')=a(d)=a(d)/float(ng)=',a(d)
	write(*,*)'ya(',d,')=ya(d)=ya(d)/float(ng)',ya(d)

	write(*,*)'- - - - - - - - - - - -'
	!
	! The followind code section is not considered
	! for computations when d is equal to 1
	!

	!
	! when d=1, the following section is not executed because
	! it has only been computed a(1) and ya(1)
	!
	if (d.ge.2) then
	    	write(*,*)'### d is greater and equal to 2'
		write(11,*) d-1,ya(d)/ya(d-1)
		write(10,*) d-1,a(d)/a(d-1)
		write(*,*) d-1,'  E1=',a(d)/a(d-1), '  E2=', ya(d)/ya(d-1)
	endif
	write(*,*)'E1E2E1E2E1E2E1E2E1E2E1E2E1E2E1E2E1E2'

	enddo !!!d=1,maxd
	!-------------------------------------------

	close(10)
	close(11)



!           1    E1=  0.98006922         E2=   1.0964123    
!           2    E1=  0.98535597         E2=   1.0949044    
!           3    E1=  0.98700911         E2=   1.1041924    
!           4    E1=             NaN     E2=             NaN


	!call system("xmgrace E2.dat")
	!xmgrace is a tool for presenting graphical results
	!and this one is apparently not installed in GNU/Linux machine


      end
