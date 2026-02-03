# Frequently Asked Questions (FAQ)

## General Questions

### Q: What is this tool for?
A: This tool creates combined visualizations showing:
1. A lower triangle heatmap of correlations between independent variables
2. A network diagram showing correlations between independent variables and a dependent variable

It's designed for exploratory data analysis and presentation of correlation patterns without significance testing.

### Q: Why is there no significance testing?
A: This tool focuses on effect sizes (correlation coefficients) rather than p-values. This design choice:
- Avoids misleading interpretations based on sample size
- Encourages focus on practical significance
- Simplifies the visualization
- Prevents p-hacking and multiple comparison issues

### Q: Can I use this for my publication?
A: Yes! The plots are publication-ready. However, check with your field's standards:
- Some fields require p-values
- Some prefer effect sizes without p-values
- You may want to report both in text while showing only correlations in figures

### Q: What correlation methods are supported?
A: Two methods are supported:
- **Pearson**: For linear relationships between continuous variables
- **Spearman**: For monotonic relationships or ordinal data

## Usage Questions

### Q: How do I interpret the colors?
A: The color scheme is Red-White-Blue:
- **Red**: Positive correlation (variables move together)
- **White**: No correlation (no relationship)
- **Blue**: Negative correlation (variables move opposite)

The intensity indicates strength (lighter = weaker, darker = stronger).

### Q: What does the line width mean in the network plot?
A: By default, line width is proportional to the absolute value of the correlation (|r|):
- Thicker lines = stronger correlation (positive or negative)
- Thinner lines = weaker correlation

You can disable this with `line_width_by_cor = FALSE`.

### Q: Why only show the lower triangle?
A: Correlation matrices are symmetric (cor(X,Y) = cor(Y,X)), so showing both triangles would be redundant. The lower triangle:
- Saves space
- Reduces visual clutter
- Makes the plot cleaner and easier to read

### Q: Can I show the upper triangle instead?
A: Yes! Use `triangle_type = "upper"` in the function.

### Q: How do I handle many variables?
A: For many variables (>10), consider:
1. Creating multiple plots with different variable subsets
2. Increasing the plot size (`width` and `height` in `save_cor_plots()`)
3. Not showing values on the heatmap (`show_values = FALSE`)
4. Using variable selection/filtering before plotting

## Technical Questions

### Q: What R packages are required?
A: Only two packages:
- `ggplot2` - for creating plots
- `gridExtra` - for combining plots

Install with: `install.packages(c("ggplot2", "gridExtra"))`

### Q: How does it handle missing data?
A: The function uses `use = "pairwise.complete.obs"` in the `cor()` function, which:
- Uses all available pairs for each correlation
- Maximizes data usage
- May result in different sample sizes for different correlations

### Q: Can I save plots in different formats?
A: Yes! The `save_cor_plots()` function supports:
- PNG (default, good for presentations)
- PDF (good for publications)
- JPEG
- TIFF

### Q: How do I customize colors?
A: Use the `palette` parameter with a vector of colors:
```r
# Default
palette = c("blue", "white", "red")

# Custom
palette = c("#0000FF", "#FFFFFF", "#FF0000")
palette = c("navy", "white", "darkred")
```

### Q: Can I change node colors?
A: Yes! Use:
- `network_node_color` for the dependent variable (default: "purple")
- `indep_node_color` for independent variables (default: "steelblue")

## Troubleshooting

### Problem: Error "Package 'ggplot2' is required but not installed"
**Solution**: Install the required packages:
```r
install.packages(c("ggplot2", "gridExtra"))
```

### Problem: Plot is too small/crowded
**Solution**: Increase plot dimensions:
```r
save_cor_plots(plots, width = 16, height = 10)
```

### Problem: Variable names are overlapping
**Solution**: 
1. Use shorter variable names
2. Increase plot width
3. Reduce number of variables

### Problem: Can't see the correlation values
**Solution**: 
1. Increase plot size
2. Reduce number of variables
3. Adjust text size (you'll need to modify the function)

### Problem: Colors don't look right
**Solution**: Try different palettes:
```r
# More contrast
palette = c("darkblue", "white", "darkred")

# Different style
palette = c("#2166AC", "#F7F7F7", "#B2182B")
```

### Problem: Too many variables make the plot unreadable
**Solution**: 
1. Split into multiple plots with variable subsets
2. Use hierarchical clustering to group similar variables
3. Perform variable selection first

### Problem: I want to add p-values
**Solution**: This tool intentionally does not include p-values. If you need them:
1. Calculate correlations with `cor.test()` separately
2. Add them to a table in your manuscript
3. Consider whether you really need them (see "Why is there no significance testing?" above)

## Advanced Usage

### Q: Can I create plots for multiple dependent variables at once?
A: Yes! Pass a vector of variable names:
```r
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = c("outcome1", "outcome2", "outcome3"),
  independent_vars = c("pred1", "pred2", "pred3")
)
```

### Q: Can I control the order of variables?
A: Yes! Use the `var_order` parameter:
```r
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = "Y",
  independent_vars = c("X1", "X2", "X3"),
  var_order = c("X3", "X1", "X2")  # Custom order
)
```

### Q: Can I use this in an R Markdown document?
A: Yes! Just include the code in a code chunk:
```{r, fig.width=12, fig.height=8}
source("R/cor_halfheat_network.R")
plots <- cor_halfheat_network(...)
print(plots[[1]])
```

### Q: Can I modify the plots after creation?
A: The plots are ggplot objects, but they're wrapped in a grid arrangement. For modifications, you'll need to modify the source function directly.

## Best Practices

1. **Choose appropriate correlation method**:
   - Pearson for linear relationships
   - Spearman for monotonic relationships or ordinal data

2. **Check for outliers**: Correlations are sensitive to outliers

3. **Consider sample size**: Small samples (n<30) may show spurious correlations

4. **Don't over-interpret**: Remember correlation ≠ causation

5. **Use consistent color schemes** across related figures

6. **Label your axes clearly** with meaningful variable names

7. **Report the correlation method** used in figure captions

## Getting Help

If you encounter issues not covered here:
1. Check the function documentation (`?cor_halfheat_network`)
2. Review the example scripts in `examples/`
3. Open an issue on GitHub
4. Check R and package versions are up to date
