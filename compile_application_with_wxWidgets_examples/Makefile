##
## FILE: Makefile
##
## Date: 2009/08/28
##
## Author: Hao Tseng
##
## Descriptio: Makefile for DTP (Linux version)
##
##------------------------------------------------------------------------------

PROGRAM_NAME = wx_test
#OS_NAME =$(shell uname)
OS_NAME = WINNT

# |
# | WxWidget config settings for MSYS
# |
WXWIN = /d/wxWidgets-3.0.3
WX_LIB_PREFIX = $(WXWIN)/lib/gcc_lib
WX_INCFLAG = -I $(WXWIN)/include -I $(WXWIN)/lib/gcc_lib/mswu
WX_DEFINES = -D__WXMSW__ -D_UNICODE -DNDEBUG -DHAVE_WIN32API_H -mthreads
WX_LIBS_FLAG = -L$(WX_LIB_PREFIX) -mthreads       \
                                    -lwxmsw30u      \
                                    -lwxpng         \
                                    -lwxjpeg        \
                                    -lwxtiff        \
                                    -lwxzlib        \

# |
# | MinGW LIBs settings
# |
MINGW_LIBS_FLAG =   -static-libgcc  \
                    -static-libstdc++ \
                    -lkernel32      \
                    -luser32        \
                    -lgdi32         \
                    -lwinspool      \
                    -lcomdlg32      \
                    -ladvapi32      \
                    -lshell32       \
                    -lole32         \
                    -loleaut32      \
                    -luuid          \
                    -lcomctl32      \
                    -lwsock32       \
                    -lodbc32        \
                    -mwindows       \


# |
# | Object files
# |
OBJECTS =  \
	$(OBJ)/MainApp.cpp.o        \
	$(OBJ)/MainFrame.cpp.o      \

# |
# | Tool chain definition
# |

GNU_TOOLS_PREFIX = mingw32-
#GNU_TOOLS_PREFIX =
AS = $(GNU_TOOLS_PREFIX)as
CC = $(GNU_TOOLS_PREFIX)gcc
CXX = $(GNU_TOOLS_PREFIX)g++
AR = $(GNU_TOOLS_PREFIX)ar
LD = $(GNU_TOOLS_PREFIX)g++
OC = $(GNU_TOOLS_PREFIX)objcopy
NM = $(GNU_TOOLS_PREFIX)nm
OD = $(GNU_TOOLS_PREFIX)objdump
SZ = $(GNU_TOOLS_PREFIX)size
STRIP = $(GNU_TOOLS_PREFIX)strip


# | A special echo that prints prettily

E = @echo \\\# `date +%Y.%m.%d.%H:%M:%S` ---

# | Silence is golden... put "S=" (s equals nothing) on
# | the command line to get verbose output.

#S = @
S =

# |
# | directory for objects & other output files
# |

OBJ = ./obj
OUTPUT = ./output
ASMDIR = ./asm_output
DOC_OUTPUT_DIR      = ./doc

# |
# | And the source directory? Is right here.
# |

SRC = .

# |
# | Include Files
# |
AINCLUDES =
CINCLUDES =

# |
# | Include paths and such
# |
INCFLAGS =  \
            -I ./inc                \
            -I .                    \
            $(WX_INCFLAG)

DEFINES += $(WX_DEFINES)

# +------------------------------------
# | Switches for the compiler, the assembler,
# | and the linker
# |
ifeq "$(OS_NAME)"  "Linux"
  CXXFLAGS = -O2 -m32 -D__LINUX__ $(DEFINES)
  CFLAGS   = -O2 -m32 -D__LINUX__ $(DEFINES)
else
  CXXFLAGS = -O2 -m32 $(DEFINES)
  CFLAGS   = -O2 -m32 $(DEFINES)
endif
# +----------------------------------------
# | Rules
# +----------------------------------------
default :
	$(S)make clean
	$(S)make exe

$(OBJ)/%.c.o : $(SRC)/%.c $(CINCLUDES)
	$(E) Compiling $<
	$(S)$(CC) $(INCFLAGS) $(CFLAGS) $< -c -o $@

$(OBJ)/%.cpp.o : $(SRC)/%.cpp $(CINCLUDES)
	$(E) Compiling $<
	$(S)$(CXX) $(INCFLAGS) $(CXXFLAGS) $< -c -o $@

$(OBJ)/%.cxx.o : $(SRC)/%.cxx $(CINCLUDES)
	$(E) Compiling $<
	$(S)$(CXX) $(INCFLAGS) $(CXXFLAGS) $< -c -o $@

$(OBJ) :
	$(E) Making $@/ directory
	$(S)mkdir $@

$(OUTPUT) :
	$(E) Making $@/ directory
	$(S)mkdir $@

$(ASMDIR) :
	$(E) Making $@/ directory
	$(S)mkdir $@

clean : $(OBJ) $(OUTPUT) $(ASMDIR)
	$(E) Removing objects
	$(S)rm -rf $(OBJ)
	$(S)rm -rf $(OUTPUT)
	$(S)rm -rf $(ASMDIR)
	$(S) rm -rf $(DOC_OUTPUT_DIR)

# +-------------------------------------
# | Linking
# +-------------------------------------

LIBS = -lm
#LIBS = -L$(WXWIN)/lib/gcc_lib -lm
LFLAGS = -m32 $(WX_LIBS_FLAG) $(MINGW_LIBS_FLAG) $(LIBS)

$(OUTPUT)/$(PROGRAM_NAME) : $(OBJ) $(OBJECTS)  $(OUTPUT)
	$(E) Linking $@
	$(S)$(LD) -o $(OUTPUT)/$(PROGRAM_NAME) $(OBJECTS) $(LFLAGS)

# |
# | Handy auxilliary files
# |

$(OUTPUT)/$(PROGRAM_NAME).nm : $(OUTPUT)/$(PROGRAM_NAME)
	$(E) Making $(PROGRAM_NAME).nm
	$(S)$(NM) $(OUTPUT)/$(PROGRAM_NAME) | sort > $(OUTPUT)/$(PROGRAM_NAME).nm

$(OUTPUT)/$(PROGRAM_NAME).objdump : $(OUTPUT)/$(PROGRAM_NAME)
	$(E) Making $(PROGRAM_NAME).objdump
	$(S)$(OD) $(OUTPUT)/$(PROGRAM_NAME) -d -S > $(OUTPUT)/$(PROGRAM_NAME).objdump

# +-------------------------------------
# | Shortcut Targets
# |

aux : $(OUTPUT)/$(PROGRAM_NAME).nm $(OUTPUT)/$(PROGRAM_NAME).objdump
exe : $(OUTPUT)/$(PROGRAM_NAME)

doc :
	$(E) Generate the documents
	$(S) mkdir $(DOC_OUTPUT_DIR)

help :
	@echo
	@echo Program name: $(PROGRAM_NAME)
	@echo
	@echo Available makefile targets:
	@echo
	@echo "  make clean -- erase intermediate files"
	@echo "  make exe   -- only make the $(PROGRAM_NAME) file"
	@echo "  make       -- same as make clean exe"
	@echo "  make aux   -- generate .nm and .objdump files"
	@echo "  make doc   -- Generate the documents and put them into doc directory"
	@echo
	@echo Add the option "S=" for a more verbose output
	@echo

# end of file
