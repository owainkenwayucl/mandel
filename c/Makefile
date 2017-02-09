mandel: imageio.o mandel.o Makefile
	$(CC) mandel.o imageio.o -o mandel 

%.o:src/%.c Makefile 
	$(CC) -Iinclude -c $< -o $@

clean:
	rm -f *.o mandel *.pgm *.pbm
