# Visual Guide: Correlation Half Heatmap + Network Plot

This document describes the visual components of the generated plots.

## Plot Layout

The plot is divided into two main sections arranged horizontally:

```
┌─────────────────────────────────────────────────────────────┐
│                   Plot Title (Optional)                      │
├──────────────────────────────────┬──────────────────────────┤
│                                  │                          │
│     LOWER TRIANGLE HEATMAP       │      NETWORK PLOT        │
│                                  │                          │
│  Shows correlations between      │  Shows correlations      │
│  independent variables           │  with dependent variable │
│                                  │                          │
│         X1    X2    X3           │      X1 ──┐             │
│   X2   [r]                       │      X2 ──┤             │
│   X3   [r]   [r]                 │      X3 ──┼──→ (Y)      │
│   X4   [r]   [r]   [r]           │      X4 ──┤             │
│   X5   [r]   [r]   [r]   [r]     │      X5 ──┘             │
│                                  │                          │
│  Legend: Correlation (-1 to 1)   │                          │
│  ■■■■■■■■■■■■■■■                 │                          │
│  -1    0    +1                   │                          │
│  Blue White Red                  │                          │
└──────────────────────────────────┴──────────────────────────┘
```

## Left Side: Lower Triangle Heatmap

### Purpose
Shows the correlation matrix between all independent variables in a compact, non-redundant format.

### Visual Elements
1. **Tiles/Cells**: Each cell represents the correlation between two variables
2. **Colors**: 
   - Red shades: Positive correlation (0 to +1)
   - White: No correlation (near 0)
   - Blue shades: Negative correlation (0 to -1)
3. **Text Labels**: Correlation coefficients (e.g., "0.75", "-0.32")
4. **Axes**:
   - X-axis (top): Variable names at 45° angle
   - Y-axis (left): Variable names horizontal

### Lower Triangle Layout
Only the lower triangle is shown to avoid redundancy since correlation matrices are symmetric.

Example for 5 variables:
```
        X1    X2    X3    X4    X5
X1      --    
X2     0.45   --
X3    -0.32  0.12   --
X4     0.67  0.23 -0.15   --
X5     0.11 -0.41  0.56  0.08   --
```

## Right Side: Network Plot

### Purpose
Shows how each independent variable correlates with the dependent variable.

### Visual Elements
1. **Independent Variable Nodes**:
   - Small circles (default: steelblue/blue)
   - Positioned vertically on the left side
   - Labels appear to the left of nodes

2. **Dependent Variable Node**:
   - Larger circle (default: purple)
   - Positioned on the right side, vertically centered
   - Label appears above the node

3. **Connecting Lines**:
   - Connect each independent variable to the dependent variable
   - Color indicates correlation strength (same color scale as heatmap)
   - Width is proportional to |r| (absolute correlation value)
   - Alpha/transparency shows strength

### Example Layout
```
Variable Labels    Nodes     Lines        Target Node

X1                  ●  ─────────────┐
X2                  ●  ─────────────┤
X3                  ●  ─────────────┼─────→  ◉  Y1
X4                  ●  ─────────────┤
X5                  ●  ─────────────┘

Blue nodes          Lines vary in:  Purple node
(independent)       - Color (r)     (dependent)
                    - Width (|r|)
```

## Color Scheme

### Gradient (Red-White-Blue)
```
Strong Negative     No Correlation     Strong Positive
    ← ─────────────────────────── →
    -1      -0.5       0      +0.5      +1
    ■■■■    ■■■■      □□□□    ■■■■     ■■■■
    Blue    Light     White   Light     Red
            Blue               Red
```

### Interpretation
- **Red (Positive)**: As one variable increases, the other increases
- **White (Zero)**: No linear relationship
- **Blue (Negative)**: As one variable increases, the other decreases

## Legend

A single color legend appears on the right side of the heatmap showing:
- Scale from -1 to +1
- Color gradient from blue through white to red
- Label: "Correlation Coefficient (r)"

## Key Features

### What's Included ✓
- Correlation coefficients only (no significance testing)
- Clean, intuitive visualization
- Lower triangle heatmap (no redundancy)
- Network showing predictor-outcome relationships
- Customizable colors and layout

### What's NOT Included ✗
- No p-values or significance stars
- No distinction between "significant" and "non-significant"
- No solid/dashed line variations for significance
- No upper triangle (to avoid redundancy)
- No diagonal (all correlations with self = 1)

## Customization Options

Users can customize:
1. **Colors**: Change the palette (default: blue-white-red)
2. **Node colors**: Different colors for independent and dependent nodes
3. **Line width**: Make it proportional to |r| or constant
4. **Value display**: Show/hide correlation values on heatmap
5. **Decimal places**: Control precision (default: 2 decimals)
6. **Triangle direction**: Use upper or lower triangle
7. **Variable order**: Custom sorting of variables
8. **Title**: Add custom plot titles

## Use Cases

This visualization is ideal for:
1. Exploring relationships in your data
2. Identifying multicollinearity among predictors
3. Showing predictor-outcome relationships
4. Publication-ready figures without p-value clutter
5. Presentations focused on effect sizes
