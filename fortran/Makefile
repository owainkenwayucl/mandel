mandel: imageout.o mandel.o Makefile
	$(FC) mandel.o imageout.o -o mandel  

%.o:%.f90 Makefile 
	$(FC) -c $< -o $@

clean:
	rm -f *.o *.mod mandel *.pgm
