#!/bin/bash
#create variables
A="Srikanth"
B="Varadhi"

#Print variables
echo First name = $A
echo Last name = ${B}

#Printing Date
DATE=$(date +%D)
echo Today date is ${DATE}
#Printing Arithmatic
NETSAL=1500000
TAX=$(($NETSAL*0.3))
echo My tax deduction is ${TAX}

