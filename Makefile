PBCLIB=pbc/.libs/libpbc.a

.PHONY: all test

all: test

test: bilinear_acc example
	./bilinear_acc < pbc/param/a.param
	./example < pbc/param/a.param

bilinear_acc: bilinear_acc.c $(PBCLIB)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $< -Ipbc/include -Ipbc $(PBCLIB) $(LDFLAGS) -lgmp -lm

example: example.modified.c $(PBCLIB)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $< -Ipbc/include -Ipbc $(PBCLIB) $(LDFLAGS) -lgmp -lm

$(PBCLIB): pbc/Makefile
	$(MAKE) -C pbc

pbc/Makefile: pbc/configure.ac pbc/Makefile.am
	cd pbc && autoreconf --install && ./configure
