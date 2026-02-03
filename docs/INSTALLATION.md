# Installation and Setup Guide

This guide will help you set up and use the correlation half heatmap + network visualization tool.

## Prerequisites

### 1. R Installation

You need R installed on your system. If you don't have R:

#### Windows
1. Download R from https://cran.r-project.org/bin/windows/base/
2. Run the installer
3. Follow the installation wizard

#### macOS
1. Download R from https://cran.r-project.org/bin/macosx/
2. Open the .pkg file
3. Follow the installation wizard

Alternatively, use Homebrew:
```bash
brew install r
```

#### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install r-base
```

#### Linux (Fedora/Red Hat)
```bash
sudo dnf install R
```

### 2. RStudio (Optional but Recommended)

RStudio provides a nice IDE for R:
- Download from https://posit.co/download/rstudio-desktop/
- Install following the wizard

## Installation Steps

### Step 1: Clone or Download the Repository

```bash
# Using git
git clone https://github.com/zhu-shun/-
cd ./-  # Note: repository is named "-" so use ./-

# Or download the ZIP file from GitHub and extract it
```

### Step 2: Install Required R Packages

Open R or RStudio and run:

```r
# Install required packages
install.packages(c("ggplot2", "gridExtra"))

# Verify installation
library(ggplot2)
library(gridExtra)
```

If you encounter any issues, try:
```r
# Install with dependencies
install.packages(c("ggplot2", "gridExtra"), dependencies = TRUE)
```

### Step 3: Test the Installation

```r
# Set working directory to the repository
setwd("path/to/your/repository")

# Source the function
source("R/cor_halfheat_network.R")

# Run a quick test
set.seed(123)
test_data <- data.frame(
  Y = rnorm(100),
  X1 = rnorm(100),
  X2 = rnorm(100),
  X3 = rnorm(100)
)

plots <- cor_halfheat_network(
  data = test_data,
  dependent_vars = "Y",
  independent_vars = c("X1", "X2", "X3")
)

print(plots[[1]])
```

If you see a plot, installation was successful!

## Quick Start

### 1. Prepare Your Data

Your data should be in a data.frame with:
- One or more dependent (outcome) variables
- Multiple independent (predictor) variables
- Numeric values (continuous or ordinal)

Example:
```r
# Load your data
df <- read.csv("your_data.csv")

# Or create sample data
df <- data.frame(
  outcome = rnorm(100),
  pred1 = rnorm(100),
  pred2 = rnorm(100),
  pred3 = rnorm(100)
)
```

### 2. Source the Function

```r
source("R/cor_halfheat_network.R")
```

### 3. Generate Plots

```r
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = "outcome",
  independent_vars = c("pred1", "pred2", "pred3"),
  cor_method = "pearson"
)

# View the plot
print(plots[[1]])
```

### 4. Save the Plot

```r
save_cor_plots(
  plot_list = plots,
  output_dir = "my_figures",
  format = "png"
)
```

## Running the Examples

### Example 1: Quick Start
```r
setwd("path/to/repository")
source("examples/quick_start.R")
```

### Example 2: Comprehensive Examples
```r
source("examples/example_usage.R")
```

### Example 3: Run Tests
```r
source("tests/test_function.R")
```

## Common Setup Issues

### Issue: "could not find function 'cor_halfheat_network'"
**Solution**: Make sure you've sourced the function file:
```r
source("R/cor_halfheat_network.R")
```

### Issue: "there is no package called 'ggplot2'"
**Solution**: Install the missing package:
```r
install.packages("ggplot2")
```

### Issue: "Error in setwd(...): cannot change working directory"
**Solution**: Use the correct path to your repository:
```r
# Find your current directory
getwd()

# Set to correct directory
setwd("/full/path/to/repository")
```

### Issue: Cannot install packages
**Solution**: Try these alternatives:
```r
# Install from a different mirror
install.packages("ggplot2", repos = "https://cloud.r-project.org")

# Install from source
install.packages("ggplot2", type = "source")

# Or use the R GUI package installer
```

## Using in Your Workflow

### In an R Script
```r
# my_analysis.R
source("R/cor_halfheat_network.R")

# Your analysis code
df <- read.csv("data.csv")
plots <- cor_halfheat_network(...)
save_cor_plots(plots, "figures")
```

### In R Markdown
````markdown
```{r setup}
source("R/cor_halfheat_network.R")
```

```{r correlation-plot, fig.width=12, fig.height=8}
plots <- cor_halfheat_network(
  data = my_data,
  dependent_vars = "outcome",
  independent_vars = c("x1", "x2", "x3")
)
print(plots[[1]])
```
````

### In RStudio
1. Open RStudio
2. Set working directory: Session → Set Working Directory → Choose Directory
3. Open a new R script: File → New File → R Script
4. Source the function and use it
5. Use the Plots pane to view and export

## Customizing Your Setup

### Create a Project-Specific Script
```r
# my_project_plots.R

# Source the function
source("R/cor_halfheat_network.R")

# Define your standard settings
my_palette <- c("navy", "white", "darkred")
my_width <- 14
my_height <- 10

# Create a wrapper function
my_cor_plot <- function(data, dep_vars, indep_vars) {
  plots <- cor_halfheat_network(
    data = data,
    dependent_vars = dep_vars,
    independent_vars = indep_vars,
    palette = my_palette,
    cor_method = "spearman"
  )
  
  save_cor_plots(plots, 
                output_dir = "figures",
                width = my_width, 
                height = my_height)
  
  return(plots)
}
```

### Create an R Package (Advanced)

If you want to turn this into a proper R package:

1. Install devtools:
```r
install.packages("devtools")
```

2. Add package structure:
```r
devtools::create("corHeatNet")
```

3. Move files to appropriate locations
4. Add documentation
5. Build and install:
```r
devtools::document()
devtools::install()
```

## Next Steps

1. Read the [Visual Guide](docs/VISUAL_GUIDE.md) to understand the plot components
2. Check the [FAQ](docs/FAQ.md) for common questions
3. Explore the [examples](examples/) directory
4. Customize colors and layout for your needs

## Getting Help

- **Documentation**: See README.md and docs/
- **Examples**: Check the examples/ directory
- **Issues**: Open an issue on GitHub
- **R Help**: Use `?cor_halfheat_network` after sourcing the function

## System Requirements

- **R Version**: 3.5.0 or higher recommended
- **RAM**: 4GB minimum (more for large datasets)
- **Disk Space**: Minimal (< 100MB including packages)
- **Display**: Any (plots are resolution-independent)

## Package Versions

This tool has been tested with:
- R 4.0.0+
- ggplot2 3.3.0+
- gridExtra 2.3+

Older versions may work but are not guaranteed.
