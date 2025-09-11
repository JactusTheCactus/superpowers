.PHONY: all build clean

all : clean build

clean : logs
logs : ./script.sh
	@rm -rf logs

build :
	@./script.sh