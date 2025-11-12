# File runs IDA for single ground motion

#set AccLocation "ToF"; 
#set AccLocation "ToS"; 

# Total number of incrementss
set GMname(0) 1; 	set NumSteps(0) 9250;
set GMname(1) 2; 	set NumSteps(1) 4250;
set GMname(2) 3; 	set NumSteps(2) 4250;
set GMname(3) 4; 	set NumSteps(3) 2450;
set GMname(4) 5; 	set NumSteps(4) 1700;
set GMname(5) 6; 	set NumSteps(5) 4200;
set GMname(6) 7; 	set NumSteps(6) 3700;
set GMname(7) 8; 	set NumSteps(7) 1800;
set GMname(8) 9; 	set NumSteps(8) 6000;
set GMname(9) 10; 	set NumSteps(9) 5600;
set GMname(10) 11; 	set NumSteps(10) 3258;

set timeincr 0.02;

# END INPUT 

# Read Scale_Factors from the file
set fpSF [open "1_Scale_Factors_2.txt" r]
set SCALEFACT [read $fpSF]
close $fpSF

set Num_Scale_Factors [llength $SCALEFACT]

# Zero vector
for {set n 1} {$n < [expr ($Num_Scale_Factors) +1]} {incr n} {set AAA($n) [expr 0]}

set counter 0;

for { set index 0 }  { $index < [array size GMname] }  { incr index } {
	
	for {set caseSF 1} {$caseSF <= $Num_Scale_Factors} {incr caseSF} { # Scale Factors loop	
				
		set counter [expr $counter + 1];
			
		set SF [lindex $SCALEFACT [expr $caseSF - 1]]
					
		source main.tcl
		
		set conv "INCOMPLETE"
		
		if {[expr $STKO_VAR_time/$gmotion_duration] >= 0.95} {		
			set conv "COMPLETE"		
		} else {		
			set conv "INCOMPLETE"			
		}
		
		# clean OpenSees memory
		wipe all
		
		# write summary of analysis results in a text file
		set AAA([expr ($counter)]) "$SF $gmotion_duration $STKO_VAR_time $conv"
					
		if {$caseSF < $Num_Scale_Factors} {
			puts "EQ=$index with SF=$SF case is done, running the next one...";
		}
		
		# write the last completed GM for processing
		set completed [format "LastCompleted_%i.txt" $index]
		set arr1 [open $completed w];
		puts $arr1 "$SF"
		close $arr1
	}
}

set summary [format "RUNSummary_%i.txt" $index]
set arr [open $summary w];
for {set n 1} {$n < [expr ($Num_Scale_Factors) + 1]} {incr n} {puts $arr "$AAA($n)"}
close $arr

puts "ALL cases are DONE !";