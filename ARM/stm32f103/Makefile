PROJECT  = test

AS       = arm-none-eabi-gcc -x assembler-with-cpp
CC       = arm-none-eabi-gcc
CPP      = arm-none-eabi-g++
LD       = arm-none-eabi-ld
OBJCOPY  = arm-none-eabi-objcopy
SZ       = arm-none-eabi-size
RM       = rm

C_FLAGS += -mcpu=cortex-m3 -mthumb
C_FLAGS += -Og
C_FLAGS += -g3
C_FLAGS += -std=gnu11 -MMD -MP
#C_FLAGS += -DMDR1986VE9x=1 
C_FLAGS += -DDEBUG_ON
C_FLAGS += -DHSE_VALUE=8000000
C_FLAGS += -DF_CPU=80000000
C_FLAGS += -DF_OSC=8000000

CPP_FLAGS += -mcpu=cortex-m3 -mthumb 
CPP_FLAGS += -Og
CPP_FLAGS += -g3
CPP_FLAGS += -std=gnu++11 -fabi-version=0 -MMD -MP
#CPP_FLAGS += -DMDR1986VE9x=1
CPP_FLAGS += -DDEBUG_ON
CPP_FLAGS += -DHSE_VALUE=8000000
CPP_FLAGS += -DF_CPU=80000000
CPP_FLAGS += -DF_OSC=8000000

LD_SCRIPT = ld/STM32F103XB_FLASH.ld

INCLUDE_PATHS += .
INCLUDE_PATHS += include
SOURCES_DIR += src
SOURCES_DIR += startup

#SOURCES_CPP_WILDCARDS += $(addsuffix /*.cpp,$(SOURCES_DIR))
#SOURCES_C_WILDCARDS += $(addsuffix /*.c,$(SOURCES_DIR))
#SOURCES_S_WILDCARDS += $(addsuffix /*.S,$(SOURCES_DIR))
#SOURCES_S_WILDCARDS += $(addsuffix /*.s,$(SOURCES_DIR))

SOURCES_C_WILDCARDS += src/main.c
SOURCES_S_WILDCARDS += startup/startup_stm32f103xb.s

OBJDIR = build
OBJS += $(notdir $(patsubst %.cpp, %.o, $(wildcard $(SOURCES_CPP_WILDCARDS))))
OBJS += $(notdir $(patsubst %.c, %.o, +$(wildcard $(SOURCES_C_WILDCARDS))))
#OBJS += $(notdir $(patsubst %.S, %.o, $(wildcard $(SOURCES_S_WILDCARDS))))
OBJS += $(notdir $(patsubst %.s, %.o, $(wildcard $(SOURCES_S_WILDCARDS))))
OBJECTS = $(addprefix $(OBJDIR)/, $(OBJS))

PROJECT_DEBUGS = $(patsubst %.o,%.d,$(OBJECTS))

#LD_FLAGS = -nostartfiles -Wl,-Map,"$(PROJECT).map" --specs=nano.specs

VPATH = $(SOURCES_DIR)

all: $(PROJECT).elf size

clean:
	$(RM) -rf $(PROJECT).elf $(PROJECT).map $(OBJECTS) $(PROJECT_DEBUGS)

upload:
	openocd -f interface/stlink.cfg -f board/st_nucleo_f103rb.cfg -c "init; reset halt; flash write_image erase $(PROJECT).elf; verify_image $(PROJECT).elf; reset; exit"


$(OBJDIR)/%.o: %.S
	$(AS) $(C_FLAGS) $(AS_FLAGS) -c -o $@ $<

$(OBJDIR)/%.o: %.s
	$(AS) $(C_FLAGS) $(AS_FLAGS) -c -o $@ $<

$(OBJDIR)/%.o: %.c
	$(CC) $(C_FLAGS) $(addprefix -I, $(INCLUDE_PATHS)) $(GCC_INCLUDES) -c -o $@ $<

$(OBJDIR)/%.o: %.cpp
	$(CPP) $(CPP_FLAGS) $(addprefix -I, $(INCLUDE_PATHS)) $(GCC_INCLUDES) -c -o $@ $<

$(PROJECT).elf: $(OBJECTS)
	$(LD) -T$(LD_SCRIPT) $(LD_FLAGS) -o "$@" $^

size:
	$(SZ) $(PROJECT).elf
