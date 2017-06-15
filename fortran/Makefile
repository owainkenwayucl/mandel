mandel: imageout.o mandel.o Makefile
	$(FC) mandel.o imageout.o -o mandel  

mandel-bw: imageout.o mandel-bw.o Makefile
	$(FC) mandel-bw.o imageout.o -o mandel-bw  

%.o:%.f90 Makefile 
	$(FC) -c $< -o $@

clean:
	rm -f *.o *.mod mandel mandel-bw *.pgm
