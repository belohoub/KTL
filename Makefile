TARGET=envi
BUILD=./build/

OPTIMIZE = -Os
LDFLAGS  =
CFLAGS   = $(OPTIMIZE)

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

.PHONY: all clean print rh temp both

$(BUILD)%.o: %.c
	@echo Compiling $<
	@$(CC) -c $(CFLAGS) $(INCLUDE) $< -o $@

print:
	@echo $(SRCS)
	@echo $(OBJS)

$(TARGET): $(OBJS)
	@echo Linking $(TARGET)
	$(LD) $(OBJS) $(LDFLAGS) -o $(TARGET)
	
rh:   CFLAGS  += -DMODULE_RH
rh:    $(TARGET)

temp: CFLAGS  += -DMODULE_TEMP
temp:  $(TARGET)

all:  CFLAGS  += -DMODULE_RH
all:  CFLAGS  += -DMODULE_TEMP
all:   $(TARGET)

both:
	$(MAKE) clean
	$(MAKE) rh
	mv envi envi_rh
	$(MAKE) clean
	$(MAKE) temp
	mv envi envi_temp

clean:
	-rm -f $(BUILD)*.o $(TARGET) $(TARGET)_*
