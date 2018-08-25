PROJECT_OUTPUT_DIR ?= dist

terraform__init : 
	cd $(PROJECT_OUTPUT_DIR) && terraform init

terraform__plan : terraform__init
	cd $(PROJECT_OUTPUT_DIR) && terraform plan
	
terraform__apply : terraform__init
	cd $(PROJECT_OUTPUT_DIR) && terraform apply