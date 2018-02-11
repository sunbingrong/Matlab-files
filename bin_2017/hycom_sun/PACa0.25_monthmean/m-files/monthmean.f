!
!-------------------------------------------------------------
!----------------        read 3-D_info    --------------------
!-----   change the values of idm jdm kdm din dout and notice 
!     the the data's order & nskip which can be known from *.b files
!
      parameter(idm=765,jdm=357,kdm=28)
      parameter(ndm=(((idm*jdm)+4095)/4096)*4096)
      parameter(dp=9806.)
      parameter(kk=19,kf=1,kl=19)
      character fileout*120,dout*65,din*33,filein*120
      real dat(ndm)
      real,dimension(idm,jdm,kdm) :: t, thknss, u, v, s, den
      real,dimension(idm,jdm,kdm) :: vv, uu, us, vs,dep
      real,dimension(idm,jdm)     :: su, sv, dd
      real,dimension(idm,jdm,kk)  :: ssu, ssv, ddd
      integer year, days, hour, nn, day_num, year_name, day_name
      integer k_simulate
      character*4 syear, sdays, shour, out_year
      character*2  mm, skf, skl
      write(skf,'(i2.2)')kf
      write(skl,'(i2.2)')kl
      din='D:/user1/PACa0.25/expt_01.1/data/'
      dout='./'//skf//'-'//skl
      filein='archv.0011_017_00.a'
      write(*,*) dout 
      nn=12 ! 1:yearmean,12:monthmean 

      do year=2,3                      !  year
      print*,'year:',year
      do mon=1,12      
      num=0
      us=0
      vs=0
      dep=0
      if (nn==1) then  
         day=360                
         write(mm,'(i2.2)')00              
      else
         day=30
         write(mm,'(i2.2)')mon   
      endif
      do days = 1,30
      day_num = 360*(year-1)+30*(mon-1)+days+16
      if (mod(day_num,360)==0) then
         year_name = INT(day_num/360) + 10
      else
         year_name = INT(day_num/360) + 11
      endif
      day_name  = day_num - 360*(year_name-11)+1000
        do hour=0,0
	
	  write(syear,'(i4.4)') year_name
	  write(sdays,'(i4)') day_name
	  write(shour,'(i4)') hour+1000
	  filein(7:10)=syear
	  filein(12:14)=sdays(2:4)
	  filein(16:17)=shour(3:4)
	  
	  write(*,*) din//filein
      
          open(11,file=din//filein,status='old',FORM='UNFORMATTED',
     &            convert='big_endian',
     &            access='direct',recl=ndm,err=200)

	  nskip=6
          num=num+1
!          print*,num
          call readhycom3d(11,14,nskip,u)
          call readhycom3d(11,15,nskip,v)
          call readhycom3d(11,16,nskip,thknss)
          do k=1,kdm
	    do i=1,idm
	      do j=1,jdm
                thknss(i,j,k)=thknss(i,j,k)/dp
	        if (thknss(i,j,k) .lt. 0.) thknss(i,j,k)=-999.9
 	      enddo
	    enddo
	  enddo
         print*,thknss(100,100,5)
          close(11)
          do i=1,idm
             do j=1,jdm
                do k=1,kdm
                   if (thknss(i,j,k)> 0) then
                      if (abs(u(i,j,k))<4) then 
                            us(i,j,k)=u(i,j,k)+us(i,j,k)
                      else 
                            us(i,j,k)=-999.9
                      endif 
                      if ( abs(v(i,j,k))<4 ) then
                            vs(i,j,k)=v(i,j,k)+vs(i,j,k)
                      else
                            vs(i,j,k)=-999.9
                      endif  
                           dep(i,j,k)=dep(i,j,k)+thknss(i,j,k)
                   else
                            us (i,j,k)= -999.9 
                            vs (i,j,k)= -999.9
                            dep(i,j,k)= -999.9
                   endif
  !                          dep(i,j,k)=dep(i,j,k)+thknss(i,j,k)
                enddo
             enddo
          enddo
 200    continue
        enddo
      enddo
      
      do i = 1,idm
        do j = 1,jdm
              k = 1
           do while ( thknss(i,j,k) > 0 .AND. k <= kl ) 
                    k = k + 1
            enddo
            k_simulate = k - 1  
            su(i,j) = sum(us(i,j,1:k_simulate))/num/k_simulate
            sv(i,j) = sum(vs(i,j,1:k_simulate))/num/k_simulate
           dd(i,j) = sum(dep(i,j,1:k_simulate))/num
           write(*,*) k_simulate
         enddo
       enddo

     
          ! ssu = us (:,:,kf:kl)
          ! ssv = vs (:,:,kf:kl)
          ! ddd = dep(:,:,kf:kl)
          ! su  = sum(ssu,3)/num/kk
          ! sv  = sum(ssv,3)/num/kk
          ! dd  = sum(ddd,3)/num
          do i=1,idm
             do j=1,jdm
                if (su(i,j)<-200 .or. su(i,j)>200 ) su(i,j)=-999.9
                if (sv(i,j)<-200 .or. sv(i,j)>200 ) sv(i,j)=-999.9
                if (dd(i,j)<=0)   dd(i,j)=-999.9 
             enddo
          enddo
          write(out_year,'(i4.4)') year+10
!          fileout=trim(dout)//'u3d.'//filein(7:10)//'_'//mm//'.dat'
          fileout=trim(dout)//'u3d.'//out_year//'_'//mm//'.dat'
          call write2d(fileout,su)
          fileout=trim(dout)//'v3d.'//out_year//'_'//mm//'.dat'
!          fileout=trim(dout)//'v3d.'//filein(7:10)//'_'//mm//'.dat'
          call write2d(fileout,sv)
          fileout=trim(dout)//'thknss3d.'//out_year//'_'//mm//'.dat'
!          fileout=trim(dout)//'thknss3d.'//filein(7:10)//'_'//mm//'.dat'
          call write2d(fileout,dd)
      enddo
      enddo
      end


      subroutine readhycom3d(nfile,nrec0,nskip,dat3d)
      parameter(idm=765,jdm=357,kdm=28)
      parameter(ndm=(((idm*jdm)+4095)/4096)*4096)
      real dat1d(ndm), dat3d(idm,jdm,kdm)
      
      
      do k= 1,kdm
      
      nrec=nrec0+(k-1)*nskip
       
      read(nfile,rec=nrec)dat1d

        do j= 1,jdm
          do i= 1,idm
            dat3d(i,j,k) = dat1d(i+(j-1)*idm)
	    if (dat3d(i,j,k).gt.1.e16) dat3d(i,j,k) = -999.9
          enddo
        enddo
      enddo
      
      return
      end
      
      subroutine readhycom(nfile,nrec,dat2d)
      parameter(idm=765,jdm=357)
      parameter(ndm=(((idm*jdm)+4095)/4096)*4096)
      real dat1d(ndm), dat2d(idm,jdm)
       
      read(nfile,rec=nrec)dat1d

      do j= 1,jdm
        do i= 1,idm
          dat2d(i,j) = dat1d(i+(j-1)*idm)
	  if (dat2d(i,j).gt.1.e16) dat2d(i,j) = -999.9
        enddo
      enddo
      
      return
      end
      
      subroutine write2d(filename,dat2d)
      parameter(idm=765,jdm=357)
      real dat2d(idm,jdm)
      character filename*120
      
      nfile=151
             
      open(nfile,file=filename)
        do j=jdm,1,-1
          write(nfile,100) (dat2d(i,j),i=1,idm)
        enddo
      close(nfile)

 100  format(1x,2000f10.2)
      
      return
      end

  
      
      
      
