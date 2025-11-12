# File runs IDA for single ground motion

# Total number of incrementss
#set DriftLimit 0.05; # Limit when to stop the analysis
# EQ tags from STKO model
# set EQtagsX(0) 13; 		set EQtagsY(0) 14; 	set NumSteps(0) 92500; 	set GMname(0) 1
# set EQtagsX(1) 15; 		set EQtagsY(1) 16;	set NumSteps(1) 42500; 	set GMname(1) 2
# set EQtagsX(2) 17; 		set EQtagsY(2) 18; 	set NumSteps(2) 42500; 	set GMname(2) 3
# set EQtagsX(3) 19; 		set EQtagsY(3) 20; 	set NumSteps(3) 24500; 	set GMname(3) 4
# set EQtagsX(4) 21; 		set EQtagsY(4) 22; 	set NumSteps(4) 17000;	set GMname(4) 5
# set EQtagsX(5) 23; 		set EQtagsY(5) 24; 	set NumSteps(5) 42000; 	set GMname(5) 6
# set EQtagsX(6) 25; 		set EQtagsY(6) 26; 	set NumSteps(6) 37000; 	set GMname(6) 7
# set EQtagsX(7) 27; 		set EQtagsY(7) 28; 	set NumSteps(7) 18000;  set GMname(7) 8
# set EQtagsX(8) 29; 		set EQtagsY(8) 30; 	set NumSteps(8) 60000; 	set GMname(8) 9
# set EQtagsX(9) 31; 		set EQtagsY(9) 32; 	set NumSteps(9) 56000; 	set GMname(9) 10
# set EQtagsX(10) 33; 		set EQtagsY(10) 34; set NumSteps(10) 32580; set GMname(10) 11

set Batch 2;

if {$Batch == 1} {			# Batch 1
	set EQtagsX(0) 21; 		set EQtagsY(0) 22; 	set NumSteps(0) 17000;	set GMname(0) 5
	set EQtagsX(1) 27; 		set EQtagsY(1) 28; 	set NumSteps(1) 18000;  set GMname(1) 8
	set EQtagsX(2) 19; 		set EQtagsY(2) 20; 	set NumSteps(2) 24500; 	set GMname(2) 4
	set EQtagsX(3) 13; 		set EQtagsY(3) 14; 	set NumSteps(3) 92500; 	set GMname(3) 1

} elseif {$Batch == 2} {	# Batch 2
	set EQtagsX(0) 25; 		set EQtagsY(0) 26; 	set NumSteps(0) 37000; 	set GMname(0) 7
	set EQtagsX(1) 23; 		set EQtagsY(1) 24; 	set NumSteps(1) 42000; 	set GMname(1) 6
	set EQtagsX(2) 15; 		set EQtagsY(2) 16;	set NumSteps(2) 42500; 	set GMname(2) 2
	set EQtagsX(3) 17; 		set EQtagsY(3) 18; 	set NumSteps(3) 42500; 	set GMname(3) 3
	
} else {					# Batch 3
	set EQtagsX(0) 33; 		set EQtagsY(0) 34;  set NumSteps(0) 32580;  set GMname(0) 11 
	set EQtagsX(1) 31; 		set EQtagsY(1) 32; 	set NumSteps(1) 56000; 	set GMname(1) 10
	set EQtagsX(2) 29; 		set EQtagsY(2) 30; 	set NumSteps(2) 60000; 	set GMname(2) 9
}

set timeincr 0.002;

# END INPUT ........................................................................

# Read Scale_Factors from the file
set fpSF [open "1_Scale_Factors_2.txt" r]
set SCALEFACT [read $fpSF]
close $fpSF

set Num_Scale_Factors [llength $SCALEFACT]

# Zero vector
for {set n 1} {$n < [expr ($Num_Scale_Factors) +1]} {incr n} {set AAA($n) [expr 0]}

set counter 0;

for { set index 0 }  { $index < [array size EQtagsX] }  { incr index } {
	
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