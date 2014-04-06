
all: SyrupApplet.class MyAppletStub.class SyrupClientServant.class
	rm *.jar
	jar cmf META-INF/MANIFEST.MF syrup_files.jar *.class Syrup/*.class
	chmod 755 syrup_files.jar

SyrupApplet.class : SyrupApplet.java
	javac SyrupApplet.java

MyAppletStub.class : MyAppletStub.java
	javac MyAppletStub.java

SyrupClientServant.class : SyrupClientServant.java
	javac SyrupClientServant.java

clean:	
	rm *.class
