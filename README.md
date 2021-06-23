# SZE-FordProg-2021-CHILL-parser

Antlr4 style Chill Parser (To be continued...)

#### Prerequisite:
- Install Java (1.7 or higher).
- Install Antlr4: 
   - See: https://github.com/antlr/antlr4/blob/master/doc/getting-started.md
   - Some distros already contain (```` apt install antlr4```` )

#### Files:
- ChillLexer.g4: Contains most of the tokens used in CHILL language.
- ChillParser.g4: Contains several grammar rules for CHILL language.
- ChillParserOld.g4: Old, unfinished version of ChillParser.g4
- examples/*.ch: Example code samples.
- Makefile: ***Experimental***
- download.sh: Script downloads the antlr4 jar from Antlr website. 
   
#### Usage:
```` 
$ antlr4 ChillParser.g4
$ javac ChillParser*.java
$ grun ChillParser program [filename] (-gui|-tree)
```` 

##### Sources:
- ANTLR4: https://github.com/antlr/antlr4/blob/master/doc/getting-started.md
- CHILL Documentation: https://www.itu.int/rec/dologin_pub.asp?lang=e&id=T-REC-Z.200-199911-I!!PDF-E
- GNU Compiler collection: https://gcc.gnu.org/git/?p=gcc.git;a=tree;f=gcc/ch;hb=2f9834e8055d89ec753d6bea65cb734dcd8f0dc0
- Installing ANTLR4 in your Linux: https://www.cs.upc.edu/~padro/CL/practica/install.html