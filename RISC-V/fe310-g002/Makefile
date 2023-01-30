PROJECT  = test

AS       = riscv64-unknown-elf-gcc -x assembler-with-cpp
CC       = riscv64-unknown-elf-gcc
CPP      = riscv64-unknown-elf-g++
LD       = riscv64-unknown-elf-gcc
OBJCOPY  = riscv64-unknown-elf-objcopy
SZ       = riscv64-unknown-elf-size
RM       = rm

C_FLAGS += -march=rv32imac
C_FLAGS += -mabi=ilp32
C_FLAGS += -mcmodel=medany
C_FLAGS += -nostdlib
C_FLAGS += -Og
C_FLAGS += -g3
C_FLAGS += -std=gnu11 -MMD -MP

CPP_FLAGS += -march=rv32imac
CPP_FLAGS += -mabi=ilp32
CPP_FLAGS += -mcmodel=medany
CPP_FLAGS += -nostdlib
CPP_FLAGS += -Og
CPP_FLAGS += -g3
CPP_FLAGS += -std=gnu++11 -fabi-version=0 -MMD -MP

LD_SCRIPT = ld/sifive.ld

INCLUDE_PATHS += .
INCLUDE_PATHS += include
SOURCES_DIR += src
SOURCES_DIR += startup

#SOURCES_CPP_WILDCARDS += $(addsuffix /*.cpp,$(SOURCES_DIR))
#SOURCES_C_WILDCARDS += $(addsuffix /*.c,$(SOURCES_DIR))
#SOURCES_S_WILDCARDS += $(addsuffix /*.S,$(SOURCES_DIR))
#SOURCES_S_WILDCARDS += $(addsuffix /*.s,$(SOURCES_DIR))

#SOURCES_C_WILDCARDS += src/main.s
SOURCES_S_WILDCARDS += src/main.s

OBJDIR = build
#OBJS += $(notdir $(patsubst %.cpp, %.o, $(wildcard $(SOURCES_CPP_WILDCARDS))))
#OBJS += $(notdir $(patsubst %.c, %.o, +$(wildcard $(SOURCES_C_WILDCARDS))))
#OBJS += $(notdir $(patsubst %.S, %.o, $(wildcard $(SOURCES_S_WILDCARDS))))
OBJS += $(notdir $(patsubst %.s, %.o, $(wildcard $(SOURCES_S_WILDCARDS))))
OBJECTS = $(addprefix $(OBJDIR)/, $(OBJS))

PROJECT_DEBUGS = $(patsubst %.o,%.d,$(OBJECTS))

#LD_FLAGS = -nostartfiles -Wl,-Map,"$(PROJECT).map" --specs=nano.specs
LD_FLAGS = -march=rv32imac -mabi=ilp32 -mcmodel=medany -nostdlib

VPATH = $(SOURCES_DIR)

all: $(PROJECT).elf size

clean:
	$(RM) -rf $(PROJECT).elf $(PROJECT).map $(OBJECTS) $(PROJECT_DEBUGS)

upload:
	openocd -f openocd/sparkfun-redv-thing.cfg -c "init; reset halt; flash write_image erase $(PROJECT).elf; verify_image $(PROJECT).elf; reset; exit"


$(OBJDIR)/%.o: %.S
	$(AS) $(C_FLAGS) $(AS_FLAGS) -c -o $@ $<

$(OBJDIR)/%.o: %.s
	$(AS) $(C_FLAGS) $(AS_FLAGS) -c -o $@ $<

$(OBJDIR)/%.o: %.c
	$(CC) $(C_FLAGS) $(addprefix -I, $(INCLUDE_PATHS)) $(GCC_INCLUDES) -c -o $@ $<

$(OBJDIR)/%.o: %.cpp
	$(CPP) $(CPP_FLAGS) $(addprefix -I, $(INCLUDE_PATHS)) $(GCC_INCLUDES) -c -o $@ $<

$(PROJECT).elf: $(OBJECTS)
	echo $(OBJECTS)
	$(LD) -T$(LD_SCRIPT) $(LD_FLAGS) -o "$@" $^

size:
	$(SZ) $(PROJECT).elf
