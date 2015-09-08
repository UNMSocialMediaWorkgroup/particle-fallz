P2J=/usr/share/processing/processing-3.0b5/processing-java
CWD=$(shell pwd)
SKETCHDIR=$(CWD)/pfz
OUTDIR=$(CWD)/out
OUTDIRS=$(OUTDIR)

run:
	$(P2J) --sketch=$(SKETCHDIR) --output=$(OUTDIR) --force --run


$(OUTDIRS):
	mkdir -p $@

test:
	echo $(CWD)

clean:
	rm -rf $(OUTDIRS)

.PHONY:	clean test
