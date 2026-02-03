# Correlation Half Heatmap + Network Visualization

This repository provides an R function for creating combined correlation visualizations that include:
- A **lower triangle heatmap** showing correlations between independent variables
- A **network plot** showing connections between independent variables and a dependent variable node

## Features

- ✅ **No significance testing**: Pure correlation coefficients (no p-values)
- ✅ **Red-White-Blue color scheme**: Intuitive gradient from negative (blue) to positive (red)
- ✅ **Flexible layout**: Lower triangle heatmap with variable names on top and left
- ✅ **Network visualization**: Dependent variable node on the right with connecting lines
- ✅ **Customizable**: Control colors, layout, correlation method, and more
- ✅ **Multiple dependent variables**: Generate plots for multiple outcomes at once

## Installation

This is not a formal R package, so you simply source the main function file:

```r
source("R/cor_halfheat_network.R")
```

### Required R Packages

```r
install.packages(c("ggplot2", "gridExtra"))
```

## Quick Start

```r
# Source the function
source("R/cor_halfheat_network.R")

# Create or load your data
df <- data.frame(
  Y1 = rnorm(100),  # Dependent variable
  X1 = rnorm(100),  # Independent variables
  X2 = rnorm(100),
  X3 = rnorm(100)
)

# Generate the visualization
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = "Y1",
  independent_vars = c("X1", "X2", "X3"),
  cor_method = "pearson",
  palette = c("blue", "white", "red")
)

# Display the plot
print(plots[[1]])
```

See `examples/quick_start.R` for a complete working example.

## Function Documentation

### Main Function: `cor_halfheat_network()`

```r
cor_halfheat_network(
  data,                    # data.frame with your variables
  dependent_vars,          # character vector of dependent variable names
  independent_vars,        # character vector of independent variable names
  cor_method = "pearson",  # "pearson" or "spearman"
  palette = c("blue", "white", "red"),  # color gradient
  show_values = TRUE,      # show correlation values on heatmap
  value_digits = 2,        # decimal places for values
  network_node_color = "purple",     # color for dependent variable node
  indep_node_color = "steelblue",    # color for independent variable nodes
  triangle_type = "lower", # "lower" or "upper" triangle
  var_order = NULL,        # custom order for variables
  line_width_by_cor = TRUE,  # line width proportional to |r|
  cor_breaks = c(0, 0.2, 0.4, 1),  # breaks for categorizing |r|
  title = NULL             # optional plot title
)
```

**Returns**: A named list of ggplot objects, one for each dependent variable.

### Helper Function: `save_cor_plots()`

```r
save_cor_plots(
  plot_list,               # list of plots from cor_halfheat_network()
  output_dir = "output",   # directory to save plots
  width = 12,              # plot width in inches
  height = 8,              # plot height in inches
  dpi = 300,               # resolution
  format = "png"           # "png", "pdf", "jpeg", or "tiff"
)
```

## Examples

### Example 1: Basic Usage

```r
source("R/cor_halfheat_network.R")

# Your data
df <- read.csv("mydata.csv")

# Generate plot
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = "outcome_variable",
  independent_vars = c("var1", "var2", "var3", "var4"),
  cor_method = "pearson"
)

# View the plot
print(plots[[1]])
```

### Example 2: Multiple Dependent Variables

```r
# Generate plots for multiple outcomes
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = c("outcome1", "outcome2", "outcome3"),
  independent_vars = c("predictor1", "predictor2", "predictor3"),
  cor_method = "spearman"
)

# View all plots
for (var_name in names(plots)) {
  print(plots[[var_name]])
}
```

### Example 3: Customized Appearance

```r
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = "Y",
  independent_vars = c("X1", "X2", "X3", "X4", "X5"),
  cor_method = "pearson",
  palette = c("blue", "white", "red"),  # Custom colors
  show_values = TRUE,
  value_digits = 2,
  network_node_color = "purple",
  indep_node_color = "steelblue",
  line_width_by_cor = TRUE,
  title = "My Custom Analysis"
)

print(plots[[1]])
```

### Example 4: Save Plots to Files

```r
# Generate plots
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = c("Y1", "Y2"),
  independent_vars = c("X1", "X2", "X3")
)

# Save all plots
save_cor_plots(
  plot_list = plots,
  output_dir = "figures",
  width = 12,
  height = 8,
  dpi = 300,
  format = "png"
)
```

## Understanding the Visualization

The generated plot consists of two main components:

### Left: Lower Triangle Heatmap
- Shows correlations **between independent variables**
- Only the lower triangle is displayed (avoiding redundancy)
- Colors represent correlation strength:
  - 🔴 Red: Positive correlation
  - ⚪ White: No correlation (r ≈ 0)
  - 🔵 Blue: Negative correlation
- Variable names appear on top (x-axis, 45° angle) and left (y-axis, horizontal)
- Correlation values are displayed in each cell (by default, 2 decimal places)

### Right: Network Plot
- Shows correlations **between independent variables and the dependent variable**
- Each independent variable is represented by a blue node
- The dependent variable is represented by a larger purple node on the right
- Lines connect each independent variable to the dependent variable
- Line color indicates correlation strength (same color scheme as heatmap)
- Line width is proportional to |r| (by default)

### Color Legend
- A single legend appears on the right showing the correlation scale from -1 to 1
- No significance indicators (no p-values, no asterisks, no solid/dashed line distinctions)

## Design Philosophy

This visualization tool is designed with the following principles:

1. **Focus on effect size**: Shows correlation coefficients directly without significance testing
2. **Comprehensive view**: Combines within-predictor correlations (heatmap) and predictor-outcome correlations (network)
3. **Clean and intuitive**: Red-white-blue color scheme is universally understood
4. **Reproducible**: All parameters can be controlled programmatically

## File Structure

```
.
├── R/
│   └── cor_halfheat_network.R    # Main function
├── examples/
│   ├── quick_start.R             # Minimal working example
│   └── example_usage.R           # Comprehensive examples
└── README.md                      # This file
```

## Notes

- **No significance testing**: This tool does **not** calculate p-values or perform significance tests. All visualizations are based purely on correlation coefficients.
- **Missing data**: The function uses `pairwise.complete.obs` for handling missing data, which calculates correlations using all available pairs of observations.
- **Correlation methods**: Both Pearson (parametric) and Spearman (non-parametric) correlations are supported.
- **Customization**: Nearly all visual aspects can be customized through function parameters.

## Troubleshooting

### Package Installation Issues

If you encounter package installation issues:

```r
# Install from CRAN
install.packages(c("ggplot2", "gridExtra"), dependencies = TRUE)

# Or install from source if needed
install.packages("ggplot2", type = "source")
```

### Memory Issues with Large Datasets

For very large datasets, consider:
- Reducing the number of variables
- Using Spearman correlation (faster for large datasets)
- Not displaying values on the heatmap (`show_values = FALSE`)

## License

This code is provided as-is for research and educational purposes.

## Contributing

Feel free to submit issues or pull requests to improve this visualization tool.