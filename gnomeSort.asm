##########################################################################
# CS 282 Fall 2012 Gnome Sort
# Author:  Jeff Zellar
# Modified 7 Sept. 2012 10:00am
#
##########################################################################
#
# Functional Description
#
# Generate a random array of 10 integers
# Print the elements of the array
# Sort the array by gnome sort
# Print the sorted elements
#
                	.data
A:              	.word 0: 10            # 10 ints
                	.globl main
                	.text

main:       la  		$s0, A               		 # cursor <-- &A[0]
               	addi 		$s1, $s0, 40       		# end <-- cursor + 40 ( 10 ints )
               	li		$v0, 30				# system time
               	syscall						# low order 32 bits --> $a0
                li   		$v0, 40               	 	# seed random number generator
                move 	$a1, $a0			 	# seed in $a1
                li   		$a0, 1                 		# generator #1              
                syscall                    		

generate:       
		beq  	$s0, $s1, gsort       		# while cursor != end
                li   		$v0, 41               		# random int
                li   		$a0, 1               		# generator #1
                syscall                    				# $a0 <-- random int
                sw   		$a0, ($s0)           		# store random number into array
                li   		$v0, 1                		# print int
                syscall                    				# $a0 already contans int to print
                li   		$v0, 11                		# print char
                li   		$a0, '\n'          			# skip to next line
                syscall                    			
                addi  	$s0, $s0, 4           		# next int
                j    generate              			# goto top of while loop
                
#***********************************************************************************************************
#Algorithm for Gnome Sort
#gnomeSort(a, n):
#
#   // sort array a of n ints in a[0], a[1], ?, a[n-1]
#  j <-- 1
#    k <--  2
#    while j < n:
# if a[j-1] <= a[j]:         
#           j <-- k            // move right
#           k += 1
#        else:
#           swap( a[j], a[j-1] )
#           j -= 1            // move left
#           if j == 0: j <-- 1
#
# Register Cross reference:
#
# $t0: cursor (A[j])
# $t1: cursor (A[k])
# 
# $t3: end (A[10])
# 
# $t5; start (&A[0])
#$t6; temp value (used for comapring size)
#$t7 temp value (used for comapring size)

##############################################################     
gsort:      	li   		$v0, 11                		# print char
                li   		$a0, '\n'          			# skip a line
                syscall
                li   		$v0, 11                		# print char
                li   		$a0, '\n'          			# skip a line
                syscall
                
                
                la    	 	$t0, A+4                		# cursor =  &A[1]
                la		$t1, A+8				# k = &A[2]              
                la		$t3, A+40               		 # end     = &A[10]
                la		$t5, A				 # start   = &A[0]
                
while:       beq     	$t0, $t3, print		    	# while cursor < end
                lw		$t6, -4($t0)                 	# loading A[j-1] = *cursor
                lw		$t7, ($t0)				#loading A[j] into temp
                ble		$t6, $t7, ifstat			# break to ifstat if A[j-1] <= A[j]
                               						
                               						#following two lines swap A[j-1] and A[j]
                sw 		$t6, ($t0)				#store the value of cursor in $t6
                sw		$t7, -4($t0)			#store the value of cursor - 4 in $t7
                
                subi		$t0, $t0, 4			#decrement cursor by 1
                beq		$t0, $t5, gsort			#if cursor equals start, run sort again
 		j while
 		
ifstat:	move	$t0, $t1				#change k to j
		addi		$t1, $t1,4				#incrementing k
                j while						#jump back to while

                
# Print the sorted array
# Register Cross reference:
#
# $t0: cursor ( &A[i] )
# $t1: temp    ( A[i] )
# $t2: end   (&A[n] )

print:	la	 	$t0, A				# cursor = &A[0]
		la	 	$t2, A+40				# end = &A[10]
loop:		beq		$t0, $t2, exit			# while cursor < end
		li		$v0, 1				# print int
		lw		$a0, ($t0)				# print *curosor
		syscall
		addi  	$t0, $t0, 4			#	cursor += 1
		 li   		$v0, 11                		# print char
                 li   		$a0, '\n'          			# skip to next line
                 syscall                    			
		b		loop
                   
exit:         li   		$v0, 10               		# terminate run and
                syscall                    				# return control to OS
                




