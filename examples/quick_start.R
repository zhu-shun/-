#!/usr/bin/env Rscript
#
# Quick Start Example
#
# This script provides a minimal example to quickly get started
# with the cor_halfheat_network function.
#

# Source the function
source("R/cor_halfheat_network.R")

# Install packages if needed
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("gridExtra", quietly = TRUE)) install.packages("gridExtra")

# Create sample data
set.seed(123)
n <- 100

df <- data.frame(
  # Dependent variable
  Y1 = rnorm(n),
  
  # Independent variables
  X1 = rnorm(n),
  X2 = rnorm(n),
  X3 = rnorm(n),
  X4 = rnorm(n),
  X5 = rnorm(n)
)

# Add some realistic correlations
df$Y1 <- df$Y1 + 0.6 * df$X1 + 0.4 * df$X2 - 0.3 * df$X3
df$X2 <- df$X2 + 0.5 * df$X1
df$X3 <- df$X3 + 0.4 * df$X1
df$X4 <- df$X4 - 0.3 * df$X2

# Generate the visualization
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = "Y1",  # Can be a vector: c("Y1", "Y2")
  independent_vars = c("X1", "X2", "X3", "X4", "X5"),
  cor_method = "pearson",  # or "spearman"
  palette = c("blue", "white", "red"),  # Red-White-Blue gradient
  show_values = TRUE,  # Show correlation values on heatmap
  value_digits = 2,  # Two decimal places
  network_node_color = "purple",  # Color for dependent variable node
  indep_node_color = "steelblue",  # Color for independent variable nodes
  line_width_by_cor = TRUE  # Line width proportional to |r|
)

# Display the plot
print(plots[[1]])

# Save to file (optional)
# save_cor_plots(plots, output_dir = "figures", format = "png")

cat("\nVisualization generated successfully!\n")
cat("Features:\n")
cat("  - Lower triangle heatmap showing correlations between independent variables\n")
cat("  - Red-White-Blue color scheme (red = positive, blue = negative)\n")
cat("  - Network on the right showing connections to dependent variable\n")
cat("  - No significance testing (pure correlation coefficients)\n")
