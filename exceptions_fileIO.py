# exceptions_fileIO.py
""" Exceptions and File Input/Output.
Jaron Whittington

"""

from random import choice

def arithmagic():
    step_1 = input("Enter a 3-digit number where the first and last "
                                           "digits differ by 2 or more: ")
    if len(step_1) != 3: raise ValueError("number is not 3 digits!")
    if abs(int(step_1[0])-int(step_1[2])) <= 1: 
        raise ValueError("The number's first and last digits differ by less than 2!")
    step_2 = input("Enter the reverse of the first number, obtained "
                                              "by reading it backwards: ")
    if step_1[0] != step_2[2] or step_1[1] != step_2[1] or step_1[2] != step_2[0]:
        raise ValueError("second number is not a reverse of the first number!")
    
    step_3 = input("Enter the positive difference of these numbers: ")
    if int(step_3) != abs(int(step_1)-int(step_2)): 
        raise ValueError("not the correct difference!")
    step_4 = input("Enter the reverse of the previous result: ")
    if step_3[0] != step_4[2] or step_3[1] != step_4[1] or step_3[2] != step_4[0]:
        raise ValueError("fourth number is not reverse of third number!")
    print(str(step_3), "+", str(step_4), "= 1089 (ta-da!)")



def random_walk(max_iters=1e12):
    walk = 0
    directions = [1, -1]
    try:
        for i in range(int(max_iters)):
            walk += choice(directions)
    except KeyboardInterrupt:
        print("Process interrupted at iteration", i)
    else:
        print("Process completed")
    finally:
        return walk


class ContentFilter:

    def __init__(self, fileName):
        correct = False
        while correct == False:
            try:
                with open(fileName, 'r') as myfile:
                    contents = myfile.read().strip()
            except (FileNotFoundError, TypeError, OSError) as e:
                fileName = input("Please enter a valid file name: ")
            else:
                self.fileName = fileName
                self.contents = contents
                self.characters = len(contents)
                self.letters = sum(s.isalpha() for s in contents)
                self.nums = sum(s.isdigit() for s in contents)
                self.spaces = sum(s.isspace() for s in contents)
                self.numLines = len(contents.split('\n'))
                myfile.close()
                break
    def uniform(self, fileName, mode = 'w', case = "upper"):
        if mode != 'w' and mode != 'x' and mode != 'a':
            raise ValueError("mode is not correct!")
        with open(fileName, mode) as outfile:
            if case == "upper":
                outfile.write(self.contents.upper())
            elif case == "lower":
                outfile.write(self.contents.lower())
            else: 
                raise ValueError("case must be upper or lower")
    def reverse(self, fileName, mode = 'w', unit  = "line"):
        if mode != 'w' and mode != 'x' and mode != 'a':
            raise ValueError("mode is not correct!")
        with open(fileName, mode) as outfile:
            if unit == "line":
                writing = self.contents.split('\n')[::-1]
                for line in writing: outfile.write(line+"\n")
            elif unit == "word":
                writing = self.contents.split('\n')
                for line in writing:
                    words = line.split()[::-1]
                    outfile.write(" ".join(words) + "\n")
                    
            else:
                raise ValueError("unit must be line or word")
    def transpose(self, fileName, mode = 'w'):
        if mode != 'w' and mode != 'x' and mode != 'a':
            raise ValueError("mode is not correct!")
        with open(fileName, mode) as outfile:
            lines = self.contents.split('\n')
            result = []
            for n in range(len(lines[0].split())):
                tran = []
                for i in range(len(lines)):
                    tran.append(lines[i].split()[n])
                result.append(tran)
            for line in result:
                outfile.write(" ".join(line)+"\n")
                
                
                
                
    def __str__(self):
        return "Source file:\t\t"+self.fileName+"\nTotal characters:\t"+str(self.characters)+"\nAlphabetic characters:\t"+str(self.letters)+"\nNumerical characters:\t"+str(self.nums)+"\nWhitesapce characters:\t" + str(self.spaces)+"\nNumber of lines:\t"+str(self.numLines)
        
                
            
        
    








        
         
