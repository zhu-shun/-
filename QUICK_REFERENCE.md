# Quick Reference Card

## One-Minute Guide to cor_halfheat_network()

### What It Does
Creates a combined correlation visualization with:
- **Left**: Lower triangle heatmap (correlations between predictors)
- **Right**: Network plot (correlations with outcome)

### Essential Code
```r
source("R/cor_halfheat_network.R")
plots <- cor_halfheat_network(
  data = your_data,
  dependent_vars = "outcome",
  independent_vars = c("x1", "x2", "x3")
)
print(plots[[1]])
```

### Visual Layout
```
┌────────────────────────────────────────────────┐
│         Correlation Analysis: Y1               │
├────────────────────────┬───────────────────────┤
│   HEATMAP (left)       │   NETWORK (right)     │
│                        │                       │
│     X1   X2   X3       │   X1 ●───┐           │
│                        │   X2 ●───┤           │
│ X2  0.45               │   X3 ●───┼───→ ◉ Y1  │
│ X3 -0.32 0.12          │   X4 ●───┤           │
│ X4  0.67 0.23 -0.15    │   X5 ●───┘           │
│ X5  0.11 -0.41 0.56    │                       │
│                        │   Blue nodes = X      │
│ Legend: -1 to +1       │   Purple node = Y     │
│ ■■■■■■■■■■■■■          │   Line color = r      │
│ Blue → White → Red     │   Line width = |r|    │
└────────────────────────┴───────────────────────┘
```

### Color Meaning
- **Red**: Positive correlation (move together)
- **White**: No correlation
- **Blue**: Negative correlation (move opposite)

### Key Parameters

| Parameter | Default | Options |
|-----------|---------|---------|
| `cor_method` | "pearson" | "pearson", "spearman" |
| `palette` | blue-white-red | Any color vector |
| `show_values` | TRUE | TRUE, FALSE |
| `value_digits` | 2 | Any integer |
| `triangle_type` | "lower" | "lower", "upper" |
| `line_width_by_cor` | TRUE | TRUE, FALSE |

### Common Use Cases

#### 1. Basic Analysis
```r
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = "Y",
  independent_vars = c("X1", "X2", "X3")
)
```

#### 2. Multiple Outcomes
```r
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = c("Y1", "Y2", "Y3"),
  independent_vars = c("X1", "X2", "X3")
)
for (p in plots) print(p)
```

#### 3. Custom Colors
```r
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = "Y",
  independent_vars = c("X1", "X2", "X3"),
  palette = c("darkblue", "white", "darkred"),
  network_node_color = "purple",
  indep_node_color = "steelblue"
)
```

#### 4. Save to File
```r
plots <- cor_halfheat_network(...)
save_cor_plots(plots, 
               output_dir = "figures",
               width = 12, 
               height = 8,
               format = "png")
```

### What's Different?

✅ **What This Tool DOES:**
- Pure correlation coefficients (r values)
- Color shows correlation strength
- Line width shows |r|
- Focus on effect size

❌ **What This Tool DOES NOT:**
- No p-values
- No significance stars
- No solid/dashed distinctions
- No hypothesis testing

### Quick Troubleshooting

**Problem**: "could not find function"  
**Fix**: `source("R/cor_halfheat_network.R")`

**Problem**: "Package not found"  
**Fix**: `install.packages(c("ggplot2", "gridExtra"))`

**Problem**: "Variable not found"  
**Fix**: Check spelling of variable names in `colnames(data)`

**Problem**: Plot too small  
**Fix**: Use `save_cor_plots()` with larger `width` and `height`

### File Locations

- **Main function**: `R/cor_halfheat_network.R`
- **Quick example**: `examples/quick_start.R`
- **Full examples**: `examples/example_usage.R`
- **Tests**: `tests/test_function.R`
- **Docs**: `docs/` directory

### Need Help?

1. Check `README.md` - Full documentation
2. Check `docs/FAQ.md` - Common questions
3. Check `docs/INSTALLATION.md` - Setup help
4. Run `examples/quick_start.R` - Working example

### Requirements

- R version 3.5.0+
- ggplot2 package
- gridExtra package

### Installation (First Time)

```r
# 1. Install packages
install.packages(c("ggplot2", "gridExtra"))

# 2. Source function
source("R/cor_halfheat_network.R")

# 3. Try it
source("examples/quick_start.R")
```

---

**Remember**: This tool focuses on correlation coefficients (effect sizes), not statistical significance. Perfect for exploratory analysis and publication-ready figures!
