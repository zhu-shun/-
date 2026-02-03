#!/usr/bin/env Rscript
#
# Example Script: Using cor_halfheat_network Function
#
# This script demonstrates how to use the cor_halfheat_network function
# to create combined correlation heatmap and network visualizations.
#

# Source the main function
source("R/cor_halfheat_network.R")

# Install required packages if not already installed
required_packages <- c("ggplot2", "gridExtra")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

# ============================================================================
# Example 1: Basic Usage with Simulated Data
# ============================================================================

cat("Example 1: Basic Usage\n")
cat("=" , rep("=", 50), "\n", sep = "")

# Create sample data
set.seed(123)
n <- 100

# Generate correlated data
df_example1 <- data.frame(
  Y1 = rnorm(n),
  X1 = rnorm(n),
  X2 = rnorm(n),
  X3 = rnorm(n),
  X4 = rnorm(n)
)

# Add some correlations
df_example1$Y1 <- df_example1$Y1 + 0.5 * df_example1$X1 + 0.3 * df_example1$X2
df_example1$X2 <- df_example1$X2 + 0.4 * df_example1$X1
df_example1$X3 <- df_example1$X3 + 0.6 * df_example1$X1

# Generate plot
plots1 <- cor_halfheat_network(
  data = df_example1,
  dependent_vars = "Y1",
  independent_vars = c("X1", "X2", "X3", "X4"),
  cor_method = "pearson",
  show_values = TRUE,
  value_digits = 2
)

# Display the plot
print(plots1[[1]])

cat("\nPlot generated successfully!\n\n")


# ============================================================================
# Example 2: Multiple Dependent Variables
# ============================================================================

cat("Example 2: Multiple Dependent Variables\n")
cat("=", rep("=", 50), "\n", sep = "")

# Create data with multiple dependent variables
df_example2 <- data.frame(
  Y1 = rnorm(n),
  Y2 = rnorm(n),
  X1 = rnorm(n),
  X2 = rnorm(n),
  X3 = rnorm(n)
)

# Add correlations
df_example2$Y1 <- df_example2$Y1 + 0.7 * df_example2$X1 - 0.4 * df_example2$X2
df_example2$Y2 <- df_example2$Y2 - 0.5 * df_example2$X2 + 0.6 * df_example2$X3

# Generate plots for multiple dependent variables
plots2 <- cor_halfheat_network(
  data = df_example2,
  dependent_vars = c("Y1", "Y2"),
  independent_vars = c("X1", "X2", "X3"),
  cor_method = "pearson"
)

# Display plots
for (dep_var in names(plots2)) {
  cat("\nPlot for dependent variable:", dep_var, "\n")
  print(plots2[[dep_var]])
}

cat("\nAll plots generated successfully!\n\n")


# ============================================================================
# Example 3: Customized Appearance
# ============================================================================

cat("Example 3: Customized Appearance\n")
cat("=", rep("=", 50), "\n", sep = "")

# Generate plot with custom colors
plots3 <- cor_halfheat_network(
  data = df_example1,
  dependent_vars = "Y1",
  independent_vars = c("X1", "X2", "X3", "X4"),
  cor_method = "spearman",  # Using Spearman correlation
  palette = c("blue", "white", "red"),  # Red-White-Blue color scheme
  show_values = TRUE,
  value_digits = 2,
  network_node_color = "purple",  # Purple for dependent variable
  indep_node_color = "steelblue",  # Blue for independent variables
  line_width_by_cor = TRUE,  # Line width proportional to |r|
  title = "Custom Correlation Analysis"
)

print(plots3[[1]])

cat("\nCustomized plot generated successfully!\n\n")


# ============================================================================
# Example 4: Saving Plots to Files
# ============================================================================

cat("Example 4: Saving Plots\n")
cat("=", rep("=", 50), "\n", sep = "")

# Generate plots
plots4 <- cor_halfheat_network(
  data = df_example1,
  dependent_vars = "Y1",
  independent_vars = c("X1", "X2", "X3", "X4"),
  cor_method = "pearson"
)

# Save plots to files
save_cor_plots(
  plot_list = plots4,
  output_dir = "output",
  width = 12,
  height = 8,
  dpi = 300,
  format = "png"
)

cat("\nPlots saved to 'output' directory!\n\n")


# ============================================================================
# Example 5: Real-World Usage Pattern
# ============================================================================

cat("Example 5: Real-World Usage Pattern\n")
cat("=", rep("=", 50), "\n", sep = "")

# Suppose you have a dataset with measurements
# Here's how you would typically use this function:

# 1. Load your data
# df <- read.csv("your_data.csv")

# 2. Define your variables
# dependent_vars <- c("outcome1", "outcome2")
# independent_vars <- c("predictor1", "predictor2", "predictor3", "predictor4", "predictor5")

# 3. Generate plots
# plots <- cor_halfheat_network(
#   data = df,
#   dependent_vars = dependent_vars,
#   independent_vars = independent_vars,
#   cor_method = "pearson",
#   palette = c("blue", "white", "red"),
#   show_values = TRUE,
#   value_digits = 2
# )

# 4. View and save plots
# for (var_name in names(plots)) {
#   print(plots[[var_name]])
# }
# save_cor_plots(plots, output_dir = "figures", format = "png")

cat("\nSee comments in this section for typical usage pattern.\n")

cat("\n")
cat("=", rep("=", 70), "\n", sep = "")
cat("All examples completed successfully!\n")
cat("=", rep("=", 70), "\n", sep = "")
