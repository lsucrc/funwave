#-----------BEGIN MAKEFILE-------------------------------------------------
            SHELL         = /bin/sh
            DEF_FLAGS     = -P -traditional 
#            DEF_FLAGS     = -P -C -traditional 
            EXEC          = mytvd
#==========================================================================
#--------------------------------------------------------------------------
#        PRECISION          DEFAULT PRECISION: SINGLE                     
#                           UNCOMMENT TO SELECT DOUBLE PRECISION
#--------------------------------------------------------------------------

#            FLAG_1 = -DDOUBLE_PRECISION 
            FLAG_2 = -DPARALLEL
            FLAG_3 = -DSAMPLES
            FLAG_4 = -DCARTESIAN
#              FLAG_6 = -DINTEL
             FLAG_7 = -DMIXING
#             FLAG_8 = -DCOUPLING
#             FLAG_9 = -DZALPHA
#             FLAG_10 = -DMANNING

#--------------------------------------------------------------------------
#  mpi defs 
#--------------------------------------------------------------------------
         CPP      = /usr/bin/cpp 
         CPPFLAGS = $(DEF_FLAGS)
#         FC       = gfortran
         FC        = mpif90
         DEBFLGS  = 
         OPT      = 
         CLIB     = 
#==========================================================================

         FFLAGS = $(DEBFLGS) $(OPT) 
         MDEPFLAGS = --cpp --fext=f90 --file=-
         RANLIB = ranlib
#--------------------------------------------------------------------------
#  CAT Preprocessing Flags
#--------------------------------------------------------------------------
           CPPARGS = $(CPPFLAGS) $(DEF_FLAGS) $(FLAG_1) $(FLAG_2) \
			$(FLAG_3) $(FLAG_4) $(FLAG_5) $(FLAG_6) \
			$(FLAG_7) $(FLAG_8) $(FLAG_9) $(FLAG_10)  \
			$(FLAG_11) $(FLAG_12) $(FLAG_13) $(FLAG_14) \
			$(FLAG_15) $(FLAG_16) $(FLAG_17) $(FLAG_18) \
			$(FLAG_19) $(FLAG_20) $(FLAG_21) $(FLAG_22) \
			$(FLAG_23) $(FLAG_24)
#--------------------------------------------------------------------------
#  Libraries           
#--------------------------------------------------------------------------

#            LIBS  = $(PV3LIB) $(CLIB)  $(PARLIB) $(IOLIBS) $(MPILIB) $(GOTMLIB)
#            INCS  = $(IOINCS) $(GOTMINCS)


#--------------------------------------------------------------------------
#  Preprocessing and Compilation Directives
#--------------------------------------------------------------------------
.SUFFIXES: .o .f90 .F .F90 

.F.o:
	$(CPP) $(CPPARGS) $*.F > $*.f90
	$(FC)  -c $(FFLAGS) $(INCS) $*.f90
#	\rm $*.f90
#--------------------------------------------------------------------------
#  FUNWAVE-TVD Source Code.
#--------------------------------------------------------------------------

MODS  = mod_param.F	mod_global.F	mod_util.F \

MAIN  = main.F bc.F fluxes.F init.F io.F trid.F       \

SRCS = $(MODS)  $(MAIN)

OBJS = $(SRCS:.F=.o)

#--------------------------------------------------------------------------
#  Linking Directives               
#--------------------------------------------------------------------------

$(EXEC):	$(OBJS)
		$(FC) $(FFLAGS) $(LDFLAGS) -o $(EXEC) $(OBJS) $(LIBS)
#	mv $(EXEC) ../work/.
#--------------------------------------------------------------------------

#--------------------------------------------------------------------------
#  Tar Up Code                           
#--------------------------------------------------------------------------

tarfile:
	tar cvf funwave_tvd.tar *.F  Makefile

#--------------------------------------------------------------------------
#  Cleaning targets.
#--------------------------------------------------------------------------

clean:
		/bin/rm -f *.o *.mod

clobber:	clean
		/bin/rm -f *.f90 *.o mytvd







