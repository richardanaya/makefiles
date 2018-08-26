CARGO                    ?= cargo
PROJECT_OUTPUT_DIR       ?= dist
LAMBDA_RUST__OUTPUT_DIR  ?= $(PROJECT_OUTPUT_DIR)/lambdas/
LAMBDA_RUST__LAMBDAS_BASE = $(PROJECT_SOURCES_DIR)/lambdas/
LAMBDA_RUST__LAMBDAS_DIRS = $(notdir $(wildcard $(LAMBDA_RUST__LAMBDAS_BASE)*))
LAMBDA_RUST__LAMBDAS      = $(addprefix $(LAMBDA_RUST__OUTPUT_DIR), $(LAMBDA_RUST__LAMBDAS_DIRS))
LAMBDA_RUST__RUST_ROOTS   = $(addprefix $(LAMBDA_RUST__LAMBDAS_BASE), $(LAMBDA_RUST__LAMBDAS_DIRS))/src
LAMBDA_RUST__RUST_FILES   = $(shell test -e $(LAMBDA_RUST__RUST_ROOTS) && find $(LAMBDA_RUST__RUST_ROOTS) -type f -regex ".*\.rs" || printf "")
LAMBDA_RUST__RUST_LOCKS   = $(addprefix $(LAMBDA_RUST__LAMBDAS_BASE), $(LAMBDA_RUST__LAMBDAS_DIRS))/Cargo.lock
LAMBDA_RUST__RUST_TOML   = $(addprefix $(LAMBDA_RUST__LAMBDAS_BASE), $(LAMBDA_RUST__LAMBDAS_DIRS))/Cargo.toml
LAMBDA_RUST__ALL_FILES   = $(LAMBDA_RUST__RUST_FILES) $(LAMBDA_RUST__RUST_LOCKS) $(LAMBDA_RUST__RUST_TOML)

lambda_rust__build_pre:
	@$(call log, "lambda_rust", "Building")

lambda_rust__build: lambda_rust__build_pre $(LAMBDA_RUST__LAMBDAS)
	
$(LAMBDA_RUST__OUTPUT_DIR)%: $(LAMBDA_RUST__ALL_FILES)
	@cd $(LAMBDA_RUST__LAMBDAS_BASE)$* && $(CARGO) build --release
	@mkdir -p $(LAMBDA_RUST__OUTPUT_DIR)
	@cp $(LAMBDA_RUST__LAMBDAS_BASE)$*/target/release/$* $(LAMBDA_RUST__OUTPUT_DIR)$*

$(LAMBDA_RUST__ALL_FILES):;

lambda_rust__clean:
	@rm -rf $(LAMBDA_RUST__OUTPUT_DIR)

lambda_rust__setup:
	mkdir -p $(LAMBDA_RUST__LAMBDAS_BASE)
	
lambda_rust__setup/%: lambda_rust__setup
	cd $(LAMBDA_RUST__LAMBDAS_BASE) && $(CARGO) new $*