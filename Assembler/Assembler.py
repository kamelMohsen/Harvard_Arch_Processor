#from curses.ascii import isspace
from tkinter import Tk
from tkinter.filedialog import askopenfilename
import re
import math

registers_dic = {"r0": "000", "r1": "001", "r2": "010", "r3": "011", "r4": "100", "r5": "101", "r6": "110", "r7": "111"}

# Choosing file from pc using simple GUI
Tk().withdraw()  # Keeps the root window from appearing
input_file_path = askopenfilename()  # Shows an "Open" dialog box and return the path to the selected file

# Extracting input file name and initializing output file name
try:
    input_filename_extractor = re.findall(r"[\w']+.asm", input_file_path)
    try:
        input_filename = input_filename_extractor.pop(0)
        output_filename = re.sub(".asm", ".mem", input_filename)
        file_path = re.split(input_filename, input_file_path).pop(0)
        output_file_path = file_path + output_filename
    except IndexError:
        print("Did not open file")
        exit(0)

    # Opening chosen file
    try:
        input_file = open(input_file_path, "r")
    except FileNotFoundError:
        print("Did not open file")
        exit(0)

    # Reading assembly code from the file without comments
    commands = []
    list_count = 0
    for line in input_file:
        regex_line = re.split("#", line)
        uncommented = regex_line.pop(0)
        if uncommented: #and not uncommented.isspace():
            commands.insert(list_count, uncommented)
            list_count += 1

        # Opens/Creates output file name
        output_file = open(output_file_path, "w")
        output_file.write("// memory data file (do not edit the following line - required for mem load use)\n")
        output_file.write("// instance=/fu_instruction_memory/ram\n")
        output_file.write("/// format=mti addressradix=d dataradix=h version=1.0 wordsperline=1n\n")
        output_file.flush()

    memory_location = 0
    # Assembler Code
    for command in commands:

        # ----------------------One Operand assembler------------------------------
        new_command = re.sub(",", " ", command)
        sub_commands = re.split("\s+", new_command.lower())
        operation = sub_commands.pop(0)
        # ***************ORG COMMAND***************
        if operation == ".org":
            org_location = sub_commands.pop(0)
            while org_location != str(memory_location):
                output_file.write(str(memory_location) + ": ")
                output_file.write("0000000000000000\n")
                memory_location += 1
        # ***************SETC OPERATION***************
        elif operation == "setc":
            output_file.write(str(memory_location) + ": ")
            output_file.write("0000001000000000\n")
            memory_location += 1
        # ***************NOP OPERATION***************
        elif operation == "nop":
            output_file.write(str(memory_location) + ": ")
            output_file.write("0000000000000000\n")
            memory_location += 1
        # ***************CLRC OPERATION***************
        elif operation == "clrc":
            output_file.write(str(memory_location) + ": ")
            output_file.write("0000010000000000\n")
            memory_location += 1
        # ***************NOT OPERATION***************
        elif operation == "not":
            rdst = sub_commands.pop(0)
            output_file.write(str(memory_location) + ": ")
            output_file.write("0001101000000" + registers_dic[rdst] + "\n")
            memory_location += 1
        # ***************INC OPERATION***************
        elif operation == "inc":
            rdst = sub_commands.pop(0)
            output_file.write(str(memory_location) + ": ")
            output_file.write("0000011000000" + registers_dic[rdst] + "\n")
            memory_location += 1
        # ***************IN OPERATION***************
        elif operation == "in":
            rdst = sub_commands.pop(0)
            output_file.write(str(memory_location) + ": ")
            output_file.write("0000110000000" + registers_dic[rdst] + "\n")
            memory_location += 1
        # ***************DEC OPERATION***************
        elif operation == "dec":
            rdst = sub_commands.pop(0)
            output_file.write(str(memory_location) + ": ")
            output_file.write("0000100000000" + registers_dic[rdst] + "\n")
            memory_location += 1
        # ***************OUT OPERATION***************
        elif operation == "out":
            rdst = sub_commands.pop(0)
            output_file.write(str(memory_location) + ": ")
            output_file.write("0000101000000" + registers_dic[rdst] + "\n")
            memory_location += 1
        # ***************IADD OPERATION***************
        elif operation == "iadd":
            rsrc1 = sub_commands.pop(0)
            rdst = sub_commands.pop(0)
            immediate_value = sub_commands.pop(0)
            hexa = bin(int(immediate_value, 16))[2:].zfill(16)
            output_file.write(str(memory_location) + ": ")
            output_file.write("1000000" + registers_dic[rsrc1] + "000" + registers_dic[rdst] + "\n")
            memory_location += 1
            output_file.write(str(memory_location) + ": ")
            output_file.write(hexa + "\n")
            memory_location += 1
        # ***************ADD OPERATION***************
        elif operation == "add":
            rsrc1 = sub_commands.pop(0)
            rsrc2 = sub_commands.pop(0)
            rdst = sub_commands.pop(0)
            output_file.write(str(memory_location) + ": ")
            output_file.write("0001001" + registers_dic[rsrc1] + registers_dic[rsrc2] + registers_dic[rdst] + "\n")
            memory_location += 1
        # ***************SUB OPERATION***************
        elif operation == "sub":
            rsrc1 = sub_commands.pop(0)
            rsrc2 = sub_commands.pop(0)
            rdst = sub_commands.pop(0)
            output_file.write(str(memory_location) + ": ")
            output_file.write("0001010" + registers_dic[rsrc1] + registers_dic[rsrc2] + registers_dic[rdst] + "\n")
            memory_location += 1
        # ***************AND OPERATION***************
        elif operation == "and":
            rsrc1 = sub_commands.pop(0)
            rsrc2 = sub_commands.pop(0)
            rdst = sub_commands.pop(0)
            output_file.write(str(memory_location) + ": ")
            output_file.write("0001011" + registers_dic[rsrc1] + registers_dic[rsrc2] + registers_dic[rdst] + "\n")
            memory_location += 1
        # ***************OR OPERATION***************
        elif operation == "or":
            rsrc1 = sub_commands.pop(0)
            rsrc2 = sub_commands.pop(0)
            rdst = sub_commands.pop(0)
            output_file.write(str(memory_location) + ": ")
            output_file.write("0001011" + registers_dic[rsrc1] + registers_dic[rsrc2] + registers_dic[rdst] + "\n")
            memory_location += 1
        # ***************SHL OPERATION***************
        elif operation == "shl":
            rdst = sub_commands.pop(0)
            shift_value = sub_commands.pop(0)
            hexa = bin(int(shift_value, 16))[2:].zfill(5)
            output_file.write(str(memory_location) + ": ")
            output_file.write("0001110" + hexa + "0" + registers_dic[rdst] + "\n")
            memory_location += 1
        # ***************SHR OPERATION***************
        elif operation == "shr":
            rdst = sub_commands.pop(0)
            shift_value = sub_commands.pop(0)
            hexa = bin(int(shift_value, 16))[2:].zfill(5)
            output_file.write(str(memory_location) + ": ")
            output_file.write("0001111" + hexa + "0" + registers_dic[rdst] + "\n")
            memory_location += 1
        # ***************SWAP OPERATION***************
        elif operation == "swap":
            rsrc1 = sub_commands.pop(0)
            rdst = sub_commands.pop(0)
            output_file.write(str(memory_location) + ": ")
            output_file.write("0001000" + registers_dic[rsrc1] + "000" + registers_dic[rdst] + "\n")
            memory_location += 1
        else:
            try:
                hexa = bin(int(operation, 16))[2:].zfill(16)
                output_file.write(str(memory_location) + ": ")
                output_file.write(hexa + "\n")
                memory_location += 1
            except ValueError:
                print("Cached Error in immediate instruction writing")

    # Prints zeroes in the rest of the memory locations
    while memory_location < 2047:
        output_file.write(str(memory_location) + ": ")
        output_file.write("0000000000000000\n")
        memory_location += 1

    input_file.close()
    output_file.flush()
    output_file.close()
except KeyboardInterrupt | Exception:
    print("Program Stopped by user or an exception occurred")

