TERRAFORM          ?= terraform
PROJECT_OUTPUT_DIR ?= dist

terraform__init : 
	cd $(PROJECT_OUTPUT_DIR) && $(TERRAFORM) init

terraform__plan : terraform__init
	cd $(PROJECT_OUTPUT_DIR) && $(TERRAFORM) plan
	
terraform__apply : terraform__init
	cd $(PROJECT_OUTPUT_DIR) && $(TERRAFORM) apply