mandel: imageout.o mandel.o Makefile
	$(FC) -O2 mandel.o imageout.o -o mandel  

mandel-bw: imageout.o mandel-bw.o Makefile
	$(FC) -O2 mandel-bw.o imageout.o -o mandel-bw  

%.o:%.f90 Makefile 
	$(FC) -O2 -c $< -o $@

clean:
	rm -f *.o *.mod mandel mandel-bw *.pgm
