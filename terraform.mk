TERRAFORM                   ?= terraform
YAML2JSON                   ?= yaml2json
PROJECT_OUTPUT_DIR          ?= dist
TERRAFORM__OUTPUT_DIR       ?= $(PROJECT_OUTPUT_DIR)/terraform/
TERRAFORM__ENVIRONMENT_DIR  ?= $(TERRAFORM__OUTPUT_DIR)
TERRAFORM__SRC              ?= $(PROJECT_SOURCES_DIR)/terraform/
TERRAFORM__SRC_FILES        ?= $(shell find $(TERRAFORM__SRC) -type f -regex ".*\.tf")
TERRAFORM__TARGET_FILES     ?= $(patsubst $(TERRAFORM__SRC)%,$(TERRAFORM__OUTPUT_DIR)%, $(TERRAFORM__SRC_FILES))

.PHONY : terraform__init terraform__plan terraform__apply terraform__build terraform__clean terraform__build_pre terraform__build

terraform__init : 
	@cd $(TERRAFORM__ENVIRONMENT_DIR) && $(TERRAFORM) init

terraform__plan : terraform__init
	@cd $(TERRAFORM__ENVIRONMENT_DIR) && $(TERRAFORM) plan
	
terraform__apply : terraform__init
	@cd $(TERRAFORM__ENVIRONMENT_DIR) && $(TERRAFORM) apply -auto-approve
	
terraform__destroy : terraform__init
	@cd $(TERRAFORM__ENVIRONMENT_DIR) && $(TERRAFORM) destroy -auto-approve

terraform__build_log:
	@$(call log, "terraform", "Copying TOML files")
	
terraform__build : terraform__build_log $(TERRAFORM__TARGET_FILES)
	
$(TERRAFORM__OUTPUT_DIR)%.tf: $(TERRAFORM__SRC)%.tf
	@mkdir -p $(dir $@)
	@cp $(patsubst $(TERRAFORM__OUTPUT_DIR)%, $(TERRAFORM__SRC)%, $@) $@
	
terraform__clean :
	@rm -rf $(TERRAFORM__OUTPUT_DIR)
	
terraform__setup :
	mkdir -p $(TERRAFORM__SRC)
	touch $(TERRAFORM__SRC)/main.tf
	