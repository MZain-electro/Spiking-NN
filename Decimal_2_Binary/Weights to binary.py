#!/usr/bin/env python
# coding: utf-8

# In[52]:


import numpy as np
import math
import array


# In[53]:


# Python3 program to convert fractional
# decimal to binary number

# Function to convert decimal to binary
# upto k-precision after decimal point
def decimalToBinary(num, k_prec) :

	binary = ""

	# Fetch the integral part of
	# decimal number
	Integral = int(num)

	# Fetch the fractional part
	# decimal number
	fractional = num - Integral

	# Conversion of integral part to
	# binary equivalent
	while (Integral) :
		
		rem = Integral % 2

		# Append 0 in binary
		binary += str(rem);

		Integral //= 2
	
	# Reverse string to get original
	# binary equivalent
	binary = binary[ : : -1]

	# Append point before conversion
	# of fractional part
	binary += '.'

	# Conversion of fractional part
	# to binary equivalent
	while (k_prec) :
		
		# Find next bit in fraction
		fractional *= 2
		fract_bit = int(fractional)

		if (fract_bit == 1) :
			
			fractional -= fract_bit
			binary += '1'
			
		else :
			binary += '0'

		k_prec -= 1

	return binary

# Driver code

# This code is contributed by Ryuga


# In[12]:





# In[56]:


import csv
tup1=[]
with open('Weight1.csv', 'r') as file:
    reader = csv.reader(file)
    for row in reader:
        for values in row:
            a=float(values)
            if a<0:
                a=a*(-1)
                temp=str(100000)+decimalToBinary(a, 26)
            else:
                temp=decimalToBinary(a, 26)
            tup1.append(temp)
print(tup1)


            #print(tup1)
            #if(a<0):
#n=n.append()
 #               a=a*(-1)
            #print(values, "the converted value is", DtoB(a,32,26))
            
  #          print(values, "the new value is",decimalToBinary(a, 26))
            


# In[57]:


import csv

# open the file in the write mode
f = open('weights_binary_1', 'w')

# create the csv writer
writer = csv.writer(f)

# write a row to the csv file
writer.writerow(tup1)

# close the file
f.close()


# In[ ]:





# In[ ]:




