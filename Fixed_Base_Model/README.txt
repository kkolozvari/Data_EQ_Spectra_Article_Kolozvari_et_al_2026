update 
	analysis_steps.tcl to update time and recorder name if applicable
		# duration and initial time step
		set total_duration 1.0
		set initial_num_incr 1

		update_duration_for_current_input # ADD THIS !!!
	
	update definitions.tcl to include -factor $SF