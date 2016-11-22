del *.o 
del *.mod 
del mandel.exe
nagfor -c imageout.f90
nagfor -c mandel.f90
nagfor -o mandel.exe mandel.o imageout.o