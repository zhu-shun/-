#!/usr/bin/env Rscript
#
# Test Script for cor_halfheat_network Function
#
# This script performs basic validation tests on the function
#

# Source the main function
source("R/cor_halfheat_network.R")

cat("Running validation tests...\n\n")

# Test 1: Check that required packages can be loaded
cat("Test 1: Checking package requirements...\n")
required_packages <- c("ggplot2", "gridExtra", "grid")
missing_packages <- c()

for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    missing_packages <- c(missing_packages, pkg)
  }
}

if (length(missing_packages) > 0) {
  cat("  ⚠ Missing packages:", paste(missing_packages, collapse = ", "), "\n")
  cat("  Install with: install.packages(c('", paste(missing_packages, collapse = "', '"), "'))\n", sep = "")
} else {
  cat("  ✓ All required packages are available\n")
}

# Test 2: Create sample data and run the function
cat("\nTest 2: Running function with sample data...\n")
set.seed(123)
n <- 100

test_data <- data.frame(
  Y1 = rnorm(n),
  Y2 = rnorm(n),
  X1 = rnorm(n),
  X2 = rnorm(n),
  X3 = rnorm(n),
  X4 = rnorm(n)
)

# Add correlations
test_data$Y1 <- test_data$Y1 + 0.6 * test_data$X1 + 0.3 * test_data$X2
test_data$Y2 <- test_data$Y2 - 0.5 * test_data$X3
test_data$X2 <- test_data$X2 + 0.4 * test_data$X1

tryCatch({
  # Test basic functionality
  plots <- cor_halfheat_network(
    data = test_data,
    dependent_vars = "Y1",
    independent_vars = c("X1", "X2", "X3", "X4"),
    cor_method = "pearson",
    show_values = TRUE,
    value_digits = 2
  )
  
  if (is.list(plots) && length(plots) == 1 && "Y1" %in% names(plots)) {
    cat("  ✓ Function executed successfully\n")
    cat("  ✓ Returned a named list with 1 plot\n")
  } else {
    cat("  ✗ Function returned unexpected output structure\n")
  }
  
  # Test multiple dependent variables
  plots_multi <- cor_halfheat_network(
    data = test_data,
    dependent_vars = c("Y1", "Y2"),
    independent_vars = c("X1", "X2", "X3"),
    cor_method = "spearman"
  )
  
  if (is.list(plots_multi) && length(plots_multi) == 2) {
    cat("  ✓ Multiple dependent variables handled correctly\n")
  } else {
    cat("  ✗ Multiple dependent variables not handled correctly\n")
  }
  
}, error = function(e) {
  cat("  ✗ Error occurred:", e$message, "\n")
})

# Test 3: Parameter validation
cat("\nTest 3: Testing parameter validation...\n")

# Test invalid correlation method
tryCatch({
  plots <- cor_halfheat_network(
    data = test_data,
    dependent_vars = "Y1",
    independent_vars = c("X1", "X2"),
    cor_method = "invalid_method"
  )
  cat("  ✗ Failed to catch invalid correlation method\n")
}, error = function(e) {
  if (grepl("cor_method must be", e$message)) {
    cat("  ✓ Invalid correlation method caught correctly\n")
  }
})

# Test missing variables
tryCatch({
  plots <- cor_halfheat_network(
    data = test_data,
    dependent_vars = "Y1",
    independent_vars = c("X1", "NonExistent"),
    cor_method = "pearson"
  )
  cat("  ✗ Failed to catch missing variables\n")
}, error = function(e) {
  if (grepl("not found in the data", e$message)) {
    cat("  ✓ Missing variables caught correctly\n")
  }
})

# Test 4: Save function
cat("\nTest 4: Testing save_cor_plots function...\n")

tryCatch({
  # Create a temporary directory for testing
  temp_dir <- tempdir()
  test_output_dir <- file.path(temp_dir, "cor_plots_test")
  
  plots <- cor_halfheat_network(
    data = test_data,
    dependent_vars = "Y1",
    independent_vars = c("X1", "X2", "X3"),
    cor_method = "pearson"
  )
  
  save_cor_plots(
    plot_list = plots,
    output_dir = test_output_dir,
    width = 10,
    height = 6,
    format = "png"
  )
  
  # Check if file was created
  expected_file <- file.path(test_output_dir, "cor_halfheat_network_Y1.png")
  if (file.exists(expected_file)) {
    cat("  ✓ save_cor_plots function works correctly\n")
    cat("  ✓ Output file created at:", expected_file, "\n")
    # Clean up
    unlink(test_output_dir, recursive = TRUE)
  } else {
    cat("  ✗ Expected output file not created\n")
  }
  
}, error = function(e) {
  cat("  ✗ Error in save_cor_plots:", e$message, "\n")
})

cat("\n")
cat("=", rep("=", 60), "\n", sep = "")
cat("Validation tests completed!\n")
cat("=", rep("=", 60), "\n", sep = "")
cat("\nTo run the examples:\n")
cat("  Rscript examples/quick_start.R\n")
cat("  Rscript examples/example_usage.R\n")
