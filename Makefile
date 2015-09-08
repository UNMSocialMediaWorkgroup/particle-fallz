P2J=/usr/share/processing/processing-2.2.1/processing-java
CWD=$(shell pwd)
SKETCHDIR=$(CWD)/pfz
OUTDIR=$(CWD)/out
OUTDIRS=$(OUTDIR)

run:
	$(P2J) --run --sketch=$(SKETCHDIR) --output=$(OUTDIR)


$(OUTDIRS):
	mkdir -p $@

test:
	echo $(CWD)

clean:
	rm -rf $(OUTDIRS)

.PHONY:	clean test
