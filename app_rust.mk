CARGO                    ?= cargo
PROJECT_OUTPUT_DIR       ?= dist
APP_RUST__OUTPUT_DIR     ?= $(PROJECT_OUTPUT_DIR)
APP_RUST__DIR             = $(PROJECT_SOURCES_DIR)/$(PROJECT_NAME)
APP_RUST__OUTPUT          = $(APP_RUST__OUTPUT_DIR)/$(PROJECT_NAME)
APP_RUST__RUST_FILES      = $(shell find $(APP_RUST__DIR) -type f -regex ".*\.rs")
APP_RUST__RUST_LOCK       = $(APP_RUST__DIR)/Cargo.lock
APP_RUST__RUST_TOML       = $(APP_RUST__DIR)/Cargo.toml
APP_RUST__ALL_FILES       = $(APP_RUST__RUST_FILES) $(APP_RUST__RUST_LOCK) $(APP_RUST__RUST_TOML)

app_rust__build_pre:
	@$(call log, "app_rust", "Building")

app_rust__build: app_rust__build_pre $(APP_RUST__OUTPUT)
	
$(APP_RUST__OUTPUT): $(APP_RUST__ALL_FILES)
	@cd $(APP_RUST__DIR)$* && $(CARGO) build --release
	@mkdir -p $(APP_RUST__OUTPUT_DIR)
	@cp $(APP_RUST__DIR)/target/release/$(PROJECT_NAME) $(APP_RUST__OUTPUT)
	
$(APP_RUST__ALL_FILES):;

app_rust__clean:
	@rm -rf $(APP_RUST__OUTPUT)
	
app_rust__setup:
	@mkdir -p $(PROJECT_SOURCES_DIR)
	@cd $(PROJECT_SOURCES_DIR) && $(CARGO) new $(PROJECT_NAME)