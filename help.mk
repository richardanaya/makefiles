PROJECT_NAME        ?= 
PROJECT_DESCRIPTION ?= 

.PHONY : help
.DEFAULT_GOAL=help
help   : Makefile
	@# Only print out project name if its non-empty.
	@test "$(PROJECT_NAME)" && printf "%s\n" "$(PROJECT_NAME)" || true
	
	@# Only print out project description if its non-empty.
	@test "$(PROJECT_DESCRIPTION)" && printf "%s\n\n" "$(PROJECT_DESCRIPTION)" || true
	
	@# Print out help command description.
	@printf "help - Show commands for this makefile\n"
	
	@# Print out every command in Makefile that has ##<some text> right above it.
	@sed -n 's/^##//p' $<
