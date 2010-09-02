CXXFLAGS=-Wall -Wextra -Wshadow -pedantic -Wno-long-long -Wfloat-equal -Wcast-qual -Wsign-conversion -g
CXX=g++
BIN=${DESTDIR}/usr/bin

# For 'make man': sudo apt-get install xsltproc docbook-xsl docbook-xml
DB2MAN=/usr/share/sgml/docbook/stylesheet/xsl/nwalsh/manpages/docbook.xsl
XP=xsltproc -''-nonet -''-param man.charmap.use.subset "0"
MAN_SOURCE=man/cppcheck.1.xml


###### Object Files

LIBOBJ =     lib/checkautovariables.o \
              lib/checkbufferoverrun.o \
              lib/checkclass.o \
              lib/checkexceptionsafety.o \
              lib/checkmemoryleak.o \
              lib/checkobsoletefunctions.o \
              lib/checkother.o \
              lib/checkstl.o \
              lib/checkunusedfunctions.o \
              lib/cppcheck.o \
              lib/errorlogger.o \
              lib/executionpath.o \
              lib/filelister.o \
              lib/filelister_unix.o \
              lib/filelister_win32.o \
              lib/mathlib.o \
              lib/path.o \
              lib/preprocessor.o \
              lib/settings.o \
              lib/timer.o \
              lib/token.o \
              lib/tokenize.o

CLIOBJ =     cli/cmdlineparser.o \
              cli/cppcheckexecutor.o \
              cli/main.o \
              cli/threadexecutor.o

TESTOBJ =     test/testautovariables.o \
              test/testbufferoverrun.o \
              test/testcharvar.o \
              test/testclass.o \
              test/testconstructors.o \
              test/testcppcheck.o \
              test/testdivision.o \
              test/testexceptionsafety.o \
              test/testfilelister.o \
              test/testincompletestatement.o \
              test/testmathlib.o \
              test/testmemleak.o \
              test/testobsoletefunctions.o \
              test/testother.o \
              test/testpreprocessor.o \
              test/testredundantif.o \
              test/testrunner.o \
              test/testsettings.o \
              test/testsimplifytokens.o \
              test/teststl.o \
              test/testsuite.o \
              test/testthreadexecutor.o \
              test/testtoken.o \
              test/testtokenize.o \
              test/testunusedfunctions.o \
              test/testunusedprivfunc.o \
              test/testunusedvar.o \
              test/tinyxml/tinystr.o \
              test/tinyxml/tinyxml.o \
              test/tinyxml/tinyxmlerror.o \
              test/tinyxml/tinyxmlparser.o


###### Targets

cppcheck:	$(LIBOBJ)	$(CLIOBJ)
	$(CXX) $(CXXFLAGS) -o cppcheck $(CLIOBJ) $(LIBOBJ) $(LDFLAGS)

all:	cppcheck	testrunner	tools

testrunner:	$(TESTOBJ)	$(LIBOBJ)	cli/threadexecutor.o
	$(CXX) $(CXXFLAGS) -o testrunner $(TESTOBJ) $(LIBOBJ) cli/threadexecutor.o $(LDFLAGS)

test:	all
	./testrunner

dmake:
	$(CXX) -o dmake tools/dmake.cpp lib/filelister*.cpp

clean:
	rm -f lib/*.o cli/*.o test/*.o testrunner cppcheck

man:	$(MAN_SOURCE)
	$(XP) $(DB2MAN) $(MAN_SOURCE)

install:	cppcheck
	install -d ${BIN}
	install cppcheck ${BIN}


###### Build

lib/checkautovariables.o: lib/checkautovariables.cpp lib/checkautovariables.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h lib/settings.h lib/errorlogger.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/checkautovariables.o lib/checkautovariables.cpp

lib/checkbufferoverrun.o: lib/checkbufferoverrun.cpp lib/checkbufferoverrun.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h lib/settings.h lib/errorlogger.h lib/mathlib.h lib/executionpath.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/checkbufferoverrun.o lib/checkbufferoverrun.cpp

lib/checkclass.o: lib/checkclass.cpp lib/checkclass.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h lib/settings.h lib/errorlogger.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/checkclass.o lib/checkclass.cpp

lib/checkexceptionsafety.o: lib/checkexceptionsafety.cpp lib/checkexceptionsafety.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h lib/settings.h lib/errorlogger.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/checkexceptionsafety.o lib/checkexceptionsafety.cpp

lib/checkmemoryleak.o: lib/checkmemoryleak.cpp lib/checkmemoryleak.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h lib/settings.h lib/errorlogger.h lib/mathlib.h lib/executionpath.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/checkmemoryleak.o lib/checkmemoryleak.cpp

lib/checkobsoletefunctions.o: lib/checkobsoletefunctions.cpp lib/checkobsoletefunctions.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h lib/settings.h lib/errorlogger.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/checkobsoletefunctions.o lib/checkobsoletefunctions.cpp

lib/checkother.o: lib/checkother.cpp lib/checkother.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h lib/settings.h lib/errorlogger.h lib/mathlib.h lib/executionpath.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/checkother.o lib/checkother.cpp

lib/checkstl.o: lib/checkstl.cpp lib/checkstl.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h lib/settings.h lib/errorlogger.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/checkstl.o lib/checkstl.cpp

lib/checkunusedfunctions.o: lib/checkunusedfunctions.cpp lib/checkunusedfunctions.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h lib/settings.h lib/errorlogger.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/checkunusedfunctions.o lib/checkunusedfunctions.cpp

lib/cppcheck.o: lib/cppcheck.cpp lib/cppcheck.h lib/settings.h lib/errorlogger.h lib/checkunusedfunctions.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h lib/preprocessor.h lib/filelister.h lib/path.h lib/timer.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/cppcheck.o lib/cppcheck.cpp

lib/errorlogger.o: lib/errorlogger.cpp lib/errorlogger.h lib/path.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/errorlogger.o lib/errorlogger.cpp

lib/executionpath.o: lib/executionpath.cpp lib/executionpath.h lib/token.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/executionpath.o lib/executionpath.cpp

lib/filelister.o: lib/filelister.cpp lib/filelister.h lib/filelister_win32.h lib/filelister_unix.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/filelister.o lib/filelister.cpp

lib/filelister_unix.o: lib/filelister_unix.cpp lib/filelister.h lib/filelister_unix.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/filelister_unix.o lib/filelister_unix.cpp

lib/filelister_win32.o: lib/filelister_win32.cpp lib/filelister.h lib/filelister_win32.h lib/path.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/filelister_win32.o lib/filelister_win32.cpp

lib/mathlib.o: lib/mathlib.cpp lib/mathlib.h lib/tokenize.h lib/classinfo.h lib/token.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/mathlib.o lib/mathlib.cpp

lib/path.o: lib/path.cpp lib/path.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/path.o lib/path.cpp

lib/preprocessor.o: lib/preprocessor.cpp lib/preprocessor.h lib/tokenize.h lib/classinfo.h lib/token.h lib/filelister.h lib/path.h lib/errorlogger.h lib/settings.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/preprocessor.o lib/preprocessor.cpp

lib/settings.o: lib/settings.cpp lib/settings.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/settings.o lib/settings.cpp

lib/timer.o: lib/timer.cpp lib/timer.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/timer.o lib/timer.cpp

lib/token.o: lib/token.cpp lib/token.h lib/errorlogger.h lib/check.h lib/tokenize.h lib/classinfo.h lib/settings.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/token.o lib/token.cpp

lib/tokenize.o: lib/tokenize.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/filelister.h lib/mathlib.h lib/settings.h lib/errorlogger.h lib/check.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o lib/tokenize.o lib/tokenize.cpp

cli/cmdlineparser.o: cli/cmdlineparser.cpp cli/cmdlineparser.h lib/cppcheck.h lib/settings.h lib/errorlogger.h lib/checkunusedfunctions.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h lib/timer.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o cli/cmdlineparser.o cli/cmdlineparser.cpp

cli/cppcheckexecutor.o: cli/cppcheckexecutor.cpp cli/cppcheckexecutor.h lib/errorlogger.h lib/settings.h lib/cppcheck.h lib/checkunusedfunctions.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h cli/threadexecutor.h cli/cmdlineparser.h lib/filelister.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o cli/cppcheckexecutor.o cli/cppcheckexecutor.cpp

cli/main.o: cli/main.cpp cli/cppcheckexecutor.h lib/errorlogger.h lib/settings.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o cli/main.o cli/main.cpp

cli/threadexecutor.o: cli/threadexecutor.cpp cli/threadexecutor.h lib/settings.h lib/errorlogger.h lib/cppcheck.h lib/checkunusedfunctions.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h
	$(CXX) $(CXXFLAGS) -Ilib -c -o cli/threadexecutor.o cli/threadexecutor.cpp

test/testautovariables.o: test/testautovariables.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/checkautovariables.h lib/check.h lib/settings.h lib/errorlogger.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testautovariables.o test/testautovariables.cpp

test/testbufferoverrun.o: test/testbufferoverrun.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/checkbufferoverrun.h lib/check.h lib/settings.h lib/errorlogger.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testbufferoverrun.o test/testbufferoverrun.cpp

test/testcharvar.o: test/testcharvar.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/checkother.h lib/check.h lib/settings.h lib/errorlogger.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testcharvar.o test/testcharvar.cpp

test/testclass.o: test/testclass.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/checkclass.h lib/check.h lib/settings.h lib/errorlogger.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testclass.o test/testclass.cpp

test/testconstructors.o: test/testconstructors.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/checkclass.h lib/check.h lib/settings.h lib/errorlogger.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testconstructors.o test/testconstructors.cpp

test/testcppcheck.o: test/testcppcheck.cpp lib/cppcheck.h lib/settings.h lib/errorlogger.h lib/checkunusedfunctions.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h test/testsuite.h lib/path.h test/tinyxml/tinyxml.h test/tinyxml/tinystr.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testcppcheck.o test/testcppcheck.cpp

test/testdivision.o: test/testdivision.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/checkother.h lib/check.h lib/settings.h lib/errorlogger.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testdivision.o test/testdivision.cpp

test/testexceptionsafety.o: test/testexceptionsafety.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/checkexceptionsafety.h lib/check.h lib/settings.h lib/errorlogger.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testexceptionsafety.o test/testexceptionsafety.cpp

test/testfilelister.o: test/testfilelister.cpp test/testsuite.h lib/errorlogger.h lib/filelister_win32.h lib/filelister.h lib/filelister_unix.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testfilelister.o test/testfilelister.cpp

test/testincompletestatement.o: test/testincompletestatement.cpp test/testsuite.h lib/errorlogger.h lib/tokenize.h lib/classinfo.h lib/token.h lib/checkother.h lib/check.h lib/settings.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testincompletestatement.o test/testincompletestatement.cpp

test/testmathlib.o: test/testmathlib.cpp lib/mathlib.h test/testsuite.h lib/errorlogger.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testmathlib.o test/testmathlib.cpp

test/testmemleak.o: test/testmemleak.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/checkmemoryleak.h lib/check.h lib/settings.h lib/errorlogger.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testmemleak.o test/testmemleak.cpp

test/testobsoletefunctions.o: test/testobsoletefunctions.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/checkobsoletefunctions.h lib/check.h lib/settings.h lib/errorlogger.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testobsoletefunctions.o test/testobsoletefunctions.cpp

test/testother.o: test/testother.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/checkother.h lib/check.h lib/settings.h lib/errorlogger.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testother.o test/testother.cpp

test/testpreprocessor.o: test/testpreprocessor.cpp test/testsuite.h lib/errorlogger.h lib/preprocessor.h lib/tokenize.h lib/classinfo.h lib/token.h lib/settings.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testpreprocessor.o test/testpreprocessor.cpp

test/testredundantif.o: test/testredundantif.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/checkother.h lib/check.h lib/settings.h lib/errorlogger.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testredundantif.o test/testredundantif.cpp

test/testrunner.o: test/testrunner.cpp test/testsuite.h lib/errorlogger.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testrunner.o test/testrunner.cpp

test/testsettings.o: test/testsettings.cpp lib/settings.h test/testsuite.h lib/errorlogger.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testsettings.o test/testsettings.cpp

test/testsimplifytokens.o: test/testsimplifytokens.cpp test/testsuite.h lib/errorlogger.h lib/tokenize.h lib/classinfo.h lib/token.h lib/settings.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testsimplifytokens.o test/testsimplifytokens.cpp

test/teststl.o: test/teststl.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/checkstl.h lib/check.h lib/settings.h lib/errorlogger.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/teststl.o test/teststl.cpp

test/testsuite.o: test/testsuite.cpp test/testsuite.h lib/errorlogger.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testsuite.o test/testsuite.cpp

test/testthreadexecutor.o: test/testthreadexecutor.cpp lib/cppcheck.h lib/settings.h lib/errorlogger.h lib/checkunusedfunctions.h lib/check.h lib/token.h lib/tokenize.h lib/classinfo.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testthreadexecutor.o test/testthreadexecutor.cpp

test/testtoken.o: test/testtoken.cpp test/testsuite.h lib/errorlogger.h lib/tokenize.h lib/classinfo.h lib/token.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testtoken.o test/testtoken.cpp

test/testtokenize.o: test/testtokenize.cpp test/testsuite.h lib/errorlogger.h lib/tokenize.h lib/classinfo.h lib/token.h lib/settings.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testtokenize.o test/testtokenize.cpp

test/testunusedfunctions.o: test/testunusedfunctions.cpp lib/tokenize.h lib/classinfo.h lib/token.h test/testsuite.h lib/errorlogger.h lib/checkunusedfunctions.h lib/check.h lib/settings.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testunusedfunctions.o test/testunusedfunctions.cpp

test/testunusedprivfunc.o: test/testunusedprivfunc.cpp lib/tokenize.h lib/classinfo.h lib/token.h lib/checkclass.h lib/check.h lib/settings.h lib/errorlogger.h test/testsuite.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testunusedprivfunc.o test/testunusedprivfunc.cpp

test/testunusedvar.o: test/testunusedvar.cpp test/testsuite.h lib/errorlogger.h lib/tokenize.h lib/classinfo.h lib/token.h lib/checkother.h lib/check.h lib/settings.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/testunusedvar.o test/testunusedvar.cpp

test/tinyxml/tinystr.o: test/tinyxml/tinystr.cpp test/tinyxml/tinystr.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/tinyxml/tinystr.o test/tinyxml/tinystr.cpp

test/tinyxml/tinyxml.o: test/tinyxml/tinyxml.cpp test/tinyxml/tinyxml.h test/tinyxml/tinystr.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/tinyxml/tinyxml.o test/tinyxml/tinyxml.cpp

test/tinyxml/tinyxmlerror.o: test/tinyxml/tinyxmlerror.cpp test/tinyxml/tinyxml.h test/tinyxml/tinystr.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/tinyxml/tinyxmlerror.o test/tinyxml/tinyxmlerror.cpp

test/tinyxml/tinyxmlparser.o: test/tinyxml/tinyxmlparser.cpp test/tinyxml/tinyxml.h test/tinyxml/tinystr.h
	$(CXX) $(CXXFLAGS) -Ilib -Icli -c -o test/tinyxml/tinyxmlparser.o test/tinyxml/tinyxmlparser.cpp

