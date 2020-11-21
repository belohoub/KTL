TARGET=envi
BUILD=./build/

OPTIMIZE = -Os
LDFLAGS  =
CFLAGS   = $(OPTIMIZE) -DMODULE_RH -DMODULE_TEMP

CC=gcc
LD=gcc

INC_DIRS = ./src/
INCLUDE  = $(addprefix -I, $(INC_DIRS))

SRCS  = ./src/main.c 
SRCS += ./src/temp.c
SRCS += ./src/rh.c
OBJS  = $(addprefix $(BUILD),$(notdir $(SRCS:.c=.o)))

# PATH to search in pattern matching rules
SRCPATHS = $(sort $(dir $(SRCS)))
VPATH = $(SRCPATHS)

.PHONY: all clean print

$(BUILD)%.o: %.c
	@echo Compiling $<
	@$(CC) -c $(CFLAGS) $(INCLUDE) $< -o $@

print:
	@echo $(SRCS)
	@echo $(OBJS)

all: $(OBJS)
	$(LD) $(OBJS) $(LDFLAGS) -o $(TARGET)

clean:
	-rm -f $(BUILD)*.o $(TARGET)
