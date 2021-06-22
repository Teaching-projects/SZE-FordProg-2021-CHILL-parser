all: compile

compile:
	antlr4 ChillParser.g4
	javac ChillParser*.java

debug:
    compile
	java org.antlr.v4.gui.TestRig ChillParser program -gui

clean:
	rm -f *.class

distclean: clean
	rm -f *.java *.tokens *.interp