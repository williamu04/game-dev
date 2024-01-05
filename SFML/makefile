all: compile link

compile:
	g++ -Isrc/include -c main.cpp game.cpp

link:
	g++ main.o game.o -o main -Lsrc/lib -lsfml-graphics -lsfml-window -lsfml-system