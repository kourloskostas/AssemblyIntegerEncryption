	.data
		give_number: .asciiz "Give a 4-digit number:\n" 
		invalid_input: .asciiz "Invalid Input!:\n" 
		encrypted_number: .asciiz "Encrypted Number!:\n" 
		CRLF: .asciiz "\n"
	
	.text
	.globl main
	
				
main:

	# Print "Give a 4-digit number" 
    	la $a0, give_number                     # Load address of string stored
                                            	# in memory
    	li $v0, 4                               # Load the syscall value (number
                                            	# indicating which syscall to make)
    	syscall                                 # Perform the specified syscall
                                            	# with the given argument ($a0)
                                            	
                                            	
                                            	
	# Read a number
	li $v0, 5				# Load the syscall value (number
                                            	# indicating which syscall to make)
	syscall
	
        # If input not (1000--9999)  
        blt $v0, 1000, invalid_branch		# If <1000 , goto invalid branch
        bgt $v0, 9999, invalid_branch		# If >9999 , goto invalid branch                                	
	
	move $t0 , $v0				# Move input to $t0
	
	# Get each digit on $t1-$t4
	div $t1, $t0, 1000 			# $t1 - Digit 1
	mfhi $t5	# temp for the mod
	
	div $t2, $t5, 100 			# $t2 - Digit 2
	mfhi $t6	# temp for the mod
	
	div $t3, $t6, 10 			# $t3 - Digit 3
	mfhi $t4				# $t4 - Digit 4
	
	
	
	# Encryption Part
	
	addi $t1,$t1,7	# add 7 to $t1
	addi $t2,$t2, 7	# add 7 to $t2
	addi $t3,$t3, 7	# add 7 to $t3
	addi $t4,$t4, 7	# add 7 to $t4
	
	# $tx = ($tx+7)mod10
	
	
	div $t1, $t1, 10	
	mfhi $t1
	div $t2, $t2, 10
	mfhi $t2
	div $t3, $t3, 10
	mfhi $t3
	div $t4, $t4, 10
	mfhi $t4
	
	# Multiply each digit by x and add them together
	
	mul $t1, $t1, 1000 	# $t1*1000
	mul $t2, $t2, 100 	# $t1*100
	mul $t3, $t3, 10 	# $t1*10
	mul $t4, $t4, 1 	# $t1*1 - ignore

	add $t1, $t1, $t2 	# t1 = t1 + t2 
	add $t2 ,$t3, $t4	# t2 =t3 + t4 
	add $t1 ,$t1, $t2	# t1 = t1 + t2 
	

	la $a0 ,encrypted_number	# Print the prompt  
	li $v0, 4
	syscall
	
	move $a0, $t1		# Print the encrypted number 
	li $v0, 1
	syscall
	

	li $v0, 10		#Exit
	syscall
	
	
	# Goes here if a wrong number is given
invalid_branch:

	# Print "Invalid Input!" 
    	la $a0, invalid_input                   # Load address of string stored
                                            	# in memory
    	li $v0, 4                               # Load the syscall value (number
                                            	# indicating which syscall to make)
    	syscall                                 # Perform the specified syscall
                                            	# with the given argument ($a0)
                                     	
        j main		# Jump to main and ask again
	


