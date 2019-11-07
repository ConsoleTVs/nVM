all:
	@$(MAKE) -s release
release:
	@nim compile -d:release --hints:off main.nim
