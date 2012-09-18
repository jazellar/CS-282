#########################################
#	CS-282 Fall Semester 2012
# 	Author: Jeff Zellar
#	Due: 9/11/12
#########################################
#
#	This program is to generate the GCD of two numbers that a user enters.  The user is prompted to enter two numbers,
#	if user wants to end program, he/she needs to enter aero for both numbers.
#puesdo code:
#	int a, b
#	"Enter a number: "
#	"Enter another number: "
#	cin >> a
#	cin >> b
#		GCD Calulations
#		gcd(a, b):
#			while True{
#				if a == 0:
#					print b
#					break
#				else if b == 0:
#					print a
#					break
#				if a > b:
#					a -= b
#				else:
#					b -= a
#				}

				.data
startlabel1:		.asciiz		"This is a program that will calculate the GCD of two numbers.\n"
startlabel2:		.asciiz		"To end the program enter zero for both numbers.\n"
prompt1:			.asciiz		"Please enter a number: "
prompt2:			.asciiz		"Please enter another number: "
answer:			.asciiz		"The gcd of these two numbers is: "
				.globl		main
				.text
			
main:
		li		$v0, 4			#print string
		la		$a0, startlabel1	#print first  welcome line.
		syscall
		
		li		$v0, 4			#print string
		la		$a0, startlabel2	#print  second welcome line.
		syscall
		
		li		$v0, 4			#print string
		la		$a0, prompt1		#print -- Please enter a number:
		syscall
		li		$v0, 5			#read in number
		syscall
		move	$t0, $v0			# first integer --> t0  (a)
		
		li		$v0, 4			#print string
		la		$a0, prompt2		#print -- Please enter another number: 
		syscall
		li		$v0, 5			#read in number
		syscall
		move	$t1, $v0			# second integer  --> t1 (b)
		

gcd:		beqz		$t0, printb		#	if a == 0:  print b
		beqz		$t1, printa		#	else if b == 0:  print a	
		bge 		$t0, $t1, suba		#	if a > b: jump to suba funct
								#	else:
		sub 		$t1, $t1, $t0		#	b -= a		
		j gcd						#jump back to top of gcd function

printa:	li		$v0, 4			#print string
		la		$a0, answer		#print answer messege.
		syscall
		li		$v0, 1			#print number
		move	$a0, $t0			#print first number
		syscall
		li		$v0, 11			#print char
		li		$a0, '\n'			#add new line
		syscall
		j main					#jump to end
		
		
printb:	beqz		$t1, exit			#if a == 0 and b == 0, jump to done
		li		$v0, 4			#print string
		la		$a0, answer		#print answer messege.
		syscall
		li 		$v0, 1			#print number
		move	$a0, $t1			#print second number
		syscall
		li		$v0, 11			#print char
		li		$a0, '\n'			#add new line
		syscall
		j main					#start program over
		
		
suba:	sub 		$t0, $t0, $t1		#a -= b
		j gcd						#jump back to top of gcd function
	


exit: 		li		$v0, 10			#graceful exit
		syscall
		
