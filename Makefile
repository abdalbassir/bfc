CC=			gcc
CXX=		g++
CFLAGS=		-g -Wall -O2 -Wno-unused-function -Wno-char-subscripts
CXXFLAGS=	$(CFLAGS)
CPPFLAGS=
INCLUDES=	
KMC_OBJS=	kmc_file.o kmer_api.o mmer.o
OBJS=		$(KMC_OBJS) bkmer.o kthread.o utils.o bseq.o bbf.o count.o correct.o bfc.o
PROG=		bfc-kmc
LIBS=		-lm -lz -lpthread

.SUFFIXES:.c .cpp .o

.c.o:
		$(CC) -c $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $< -o $@

.cpp.o:
		$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) $(INCLUDES) $< -o $@

all:$(PROG)

bfc-kmc:$(OBJS)
		$(CXX) $^ -o $@ $(LIBS)

clean:
		rm -fr gmon.out *.o ext/*.o a.out $(PROG) *~ *.a *.dSYM session*

depend:
		(LC_ALL=C; export LC_ALL; makedepend -Y -- $(CFLAGS) $(DFLAGS) -- *.c *.cpp)

# DO NOT DELETE

bbf.o: bbf.h
bfc.o: bfc.h bbf.h kmer.h bseq.h
bseq.o: bseq.h kseq.h
correct.o: bfc.h bbf.h kmer.h bseq.h kvec.h ksort.h
count.o: bfc.h bbf.h kmer.h bseq.h bkmer.h
bkmer.o: bkmer.h kmc_file.h kmer_defs.h kmer_api.h mmer.h
kmc_file.o: stdafx.h mmer.h kmer_defs.h kmc_file.h kmer_api.h
kmer_api.o: stdafx.h kmer_api.h kmer_defs.h mmer.h
mmer.o: stdafx.h mmer.h kmer_defs.h
