P2J=/usr/share/processing/processing-3.0b5/processing-java
CWD=$(shell pwd)
SKETCHDIR=$(CWD)/pfz
OUTDIR=$(CWD)/out
OUTDIRS=$(OUTDIR)

run:
	$(P2J) --sketch=$(SKETCHDIR) --output=$(OUTDIR) --force --run

present:
	$(P2J) --sketch=$(SKETCHDIR) --output=$(OUTDIR) --force --present

compile:
	$(P2J) --sketch=$(SKETCHDIR) --output=$(OUTDIR) --force --export


$(OUTDIRS):
	mkdir -p $@

test:
	echo $(CWD)

clean:
	rm -rf $(OUTDIRS)

.PHONY:	clean test
