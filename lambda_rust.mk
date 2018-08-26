CARGO                    ?= cargo
PROJECT_OUTPUT_DIR       ?= dist
LAMBDA_RUST__OUTPUT_DIR  ?= $(PROJECT_OUTPUT_DIR)/lambdas/
LAMBDA_RUST__LAMBDAS_BASE = $(PROJECT_SOURCES_DIR)/lambdas/
LAMBDA_RUST__LAMBDAS_DIRS = $(notdir $(wildcard $(LAMBDA_RUST__LAMBDAS_BASE)*))
LAMBDA_RUST__LAMBDAS      = $(addprefix $(LAMBDA_RUST__OUTPUT_DIR), $(LAMBDA_RUST__LAMBDAS_DIRS))
LAMBDA_RUST__RUST_ROOTS   = $(addprefix $(LAMBDA_RUST__LAMBDAS_BASE), $(LAMBDA_RUST__LAMBDAS_DIRS))/src
LAMBDA_RUST__RUST_FILES   = $(shell find $(LAMBDA_RUST__RUST_ROOTS) -type f -regex ".*\.rs")
LAMBDA_RUST__RUST_LOCKS   = $(addprefix $(LAMBDA_RUST__LAMBDAS_BASE), $(LAMBDA_RUST__LAMBDAS_DIRS))/Cargo.lock

lambda_rust__build_pre:
	@$(call log, "lambda_rust", "Building")

lambda_rust__build: lambda_rust__build_pre $(LAMBDA_RUST__LAMBDAS)
	
$(LAMBDA_RUST__OUTPUT_DIR)%: $(LAMBDA_RUST__RUST_FILES) $(LAMBDA_RUST__RUST_LOCKS)
	echo $(LAMBDA_RUST__RUST_FILES)
	@cd $(LAMBDA_RUST__LAMBDAS_BASE)$* && cargo build --release
	@mkdir -p $(LAMBDA_RUST__OUTPUT_DIR)
	@cp $(LAMBDA_RUST__LAMBDAS_BASE)$*/target/release/$* $(LAMBDA_RUST__OUTPUT_DIR)$*

lambda_rust__clean:
	@rm -rf $(LAMBDA_RUST__OUTPUT_DIR)