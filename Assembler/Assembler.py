# from curses.ascii import isspace
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
        output1_filename = re.sub(".asm", "Data.mem", input_filename)
        output2_filename = re.sub(".asm", "Instruction.mem", input_filename)
        file_path = re.split(input_filename, input_file_path).pop(0)
        output1_file_path = file_path + output1_filename
        print(output1_file_path)
        output2_file_path = file_path + output2_filename
        print(output2_file_path)

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
        if uncommented:  # and not uncommented.isspace():
            commands.insert(list_count, uncommented)
            list_count += 1



    # ------------------------------------------------------------------------Data .mem file----------------------------------------
    # Opens/Creates output file name
    output1_file = open(output1_file_path, "w")
    output1_file.write("// memory data file (do not edit the following line - required for mem load use)\n")
    output1_file.write("// instance=/datamemory/ram\n")
    output1_file.write("/// format=mti addressradix=d dataradix=b version=1.0 wordsperline=1n\n")
    output1_file.flush()

    memory_location1 = 0
    # Assembler Code
    for command in commands:
        if memory_location1 == 4:
            break;
        new_command = re.sub(",", " ", command)
        sub_commands = re.split("\s+", new_command.lower())
        operation = sub_commands.pop(0)
        # ***************ORG COMMAND***************
        if operation == ".org":
            org_location = sub_commands.pop(0)
            while org_location != str(memory_location1):
                output1_file.write(str(memory_location1) + ": ")
                output1_file.write("0000000000000000\n")
                memory_location1 += 1
        else:
            try:
                hexa = bin(int(operation, 16))[2:].zfill(16)
                output1_file.write(str(memory_location1) + ": ")
                output1_file.write(hexa + "\n")
                memory_location1 += 1
            except ValueError:
                print("Cached Error in immediate instruction writing")

    # Prints zeroes in the rest of the memory locations
    while memory_location1 < 2047:
        output1_file.write(str(memory_location1) + ": ")
        output1_file.write("0000000000000000\n")
        memory_location1 += 1


    # ------------------------------------------------------------------------Instruction .mem file----------------------------------------
    # Opens/Creates output file name
    output2_file = open(output2_file_path, "w")
    output2_file.write("// memory data file (do not edit the following line - required for mem load use)\n")
    output2_file.write("// instance=/fu_instruction_memory/ram\n")
    output2_file.write("/// format=mti addressradix=d dataradix=b version=1.0 wordsperline=1n\n")
    output2_file.flush()
    memory_location2 = 0

    # Assembler Code
    for command in commands:

        # ----------------------One Operand assembler------------------------------
        new_command = re.sub(",", " ", command)
        sub_commands = re.split("\s+", new_command.lower())
        operation = sub_commands.pop(0)
        # ***************ORG COMMAND***************
        if operation == ".org":
            org_location = sub_commands.pop(0)
            while org_location != str(memory_location2):
                output2_file.write(str(memory_location2) + ": ")
                output2_file.write("0000000000000000\n")
                memory_location2 += 1
        # ***************SETC OPERATION***************
        elif operation == "setc":
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0000001000000000\n")
            memory_location2 += 1
        # ***************NOP OPERATION***************
        elif operation == "nop":
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0000000000000000\n")
            memory_location2 += 1
        # ***************CLRC OPERATION***************
        elif operation == "clrc":
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0000010000000000\n")
            memory_location2 += 1
        # ***************NOT OPERATION***************
        elif operation == "not":
            rdst = sub_commands.pop(0)
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0001101000000" + registers_dic[rdst] + "\n")
            memory_location2 += 1
        # ***************INC OPERATION***************
        elif operation == "inc":
            rdst = sub_commands.pop(0)
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0000011000000" + registers_dic[rdst] + "\n")
            memory_location2 += 1
        # ***************IN OPERATION***************
        elif operation == "in":
            rdst = sub_commands.pop(0)
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0000110000000" + registers_dic[rdst] + "\n")
            memory_location2 += 1
        # ***************DEC OPERATION***************
        elif operation == "dec":
            rdst = sub_commands.pop(0)
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0000100000000" + registers_dic[rdst] + "\n")
            memory_location2 += 1
        # ***************OUT OPERATION***************
        elif operation == "out":
            rdst = sub_commands.pop(0)
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0000101000000" + registers_dic[rdst] + "\n")
            memory_location2 += 1
        # ***************IADD OPERATION***************
        elif operation == "iadd":
            rsrc1 = sub_commands.pop(0)
            rdst = sub_commands.pop(0)
            immediate_value = sub_commands.pop(0)
            hexa = bin(int(immediate_value, 16))[2:].zfill(16)
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("1000000" + registers_dic[rsrc1] + "000" + registers_dic[rdst] + "\n")
            memory_location2 += 1
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write(hexa + "\n")
            memory_location2 += 1
        # ***************ADD OPERATION***************
        elif operation == "add":
            rsrc1 = sub_commands.pop(0)
            rsrc2 = sub_commands.pop(0)
            rdst = sub_commands.pop(0)
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0001001" + registers_dic[rsrc1] + registers_dic[rsrc2] + registers_dic[rdst] + "\n")
            memory_location2 += 1
        # ***************SUB OPERATION***************
        elif operation == "sub":
            rsrc1 = sub_commands.pop(0)
            rsrc2 = sub_commands.pop(0)
            rdst = sub_commands.pop(0)
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0001010" + registers_dic[rsrc1] + registers_dic[rsrc2] + registers_dic[rdst] + "\n")
            memory_location2 += 1
        # ***************AND OPERATION***************
        elif operation == "and":
            rsrc1 = sub_commands.pop(0)
            rsrc2 = sub_commands.pop(0)
            rdst = sub_commands.pop(0)
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0001011" + registers_dic[rsrc1] + registers_dic[rsrc2] + registers_dic[rdst] + "\n")
            memory_location2 += 1
        # ***************OR OPERATION***************
        elif operation == "or":
            rsrc1 = sub_commands.pop(0)
            rsrc2 = sub_commands.pop(0)
            rdst = sub_commands.pop(0)
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0001011" + registers_dic[rsrc1] + registers_dic[rsrc2] + registers_dic[rdst] + "\n")
            memory_location2 += 1
        # ***************SHL OPERATION***************
        elif operation == "shl":
            rdst = sub_commands.pop(0)
            shift_value = sub_commands.pop(0)
            hexa = bin(int(shift_value, 16))[2:].zfill(5)
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0001110" + hexa + "0" + registers_dic[rdst] + "\n")
            memory_location2 += 1
        # ***************SHR OPERATION***************
        elif operation == "shr":
            rdst = sub_commands.pop(0)
            shift_value = sub_commands.pop(0)
            hexa = bin(int(shift_value, 16))[2:].zfill(5)
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0001111" + hexa + "0" + registers_dic[rdst] + "\n")
            memory_location2 += 1
        # ***************SWAP OPERATION***************
        elif operation == "swap":
            rsrc1 = sub_commands.pop(0)
            rdst = sub_commands.pop(0)
            output2_file.write(str(memory_location2) + ": ")
            output2_file.write("0001000" + registers_dic[rsrc1] + "000" + registers_dic[rdst] + "\n")
            memory_location2 += 1
        else:
            try:
                hexa = bin(int(operation, 16))[2:].zfill(16)
                output2_file.write(str(memory_location2) + ": ")
                output2_file.write("0000000000000000\n")
                memory_location2 += 1
            except ValueError:
                print("ORG of data mem")

    # Prints zeroes in the rest of the memory locations
    while memory_location2 < 2047:
        output2_file.write(str(memory_location2) + ": ")
        output2_file.write("0000000000000000\n")
        memory_location2 += 1

    input_file.close()
    output2_file.flush()
    output2_file.close()
    output1_file.flush()
    output1_file.close()
except KeyboardInterrupt | Exception:
    print("Program Stopped by user or an exception occurred")
