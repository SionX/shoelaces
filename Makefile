GO = go
SCDOC = scdoc

pkgs = $(shell $(GO) list ./... | grep -v /vendor/)

all:
	$(GO) build

fmt:
	$(GO) fmt

clean:
	rm -f shoelaces docs/shoelaces.8

shoelaces.8:
	$(SCDOC) < docs/shoelaces.8.scd > docs/shoelaces.8

docs: shoelaces.8

test: fmt
		$(GO) test -v $(pkgs) && \
			./test/integ-test/integ_test.py

.PHONY: all clean docs

binarys: linux windows
linux:
		GOOS=linux ${GO} build -o bin/shoelaces -ldflags "-s -w"
windows:
		GOOS=windows ${GO} build -o bin/shoelaces.exe -ldflags "-s -w"
