# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2026-02-03

### Added
- Initial implementation of `cor_halfheat_network()` function
- Support for Pearson and Spearman correlation methods
- Lower triangle heatmap visualization
- Network plot showing predictor-outcome relationships
- Red-White-Blue color scheme for correlation strength
- Customizable node colors (purple for dependent, blue for independent)
- Line width proportional to correlation strength
- Helper function `save_cor_plots()` for saving plots to files
- Multiple dependent variables support in a single call
- Comprehensive documentation:
  - README.md (English)
  - README_CN.md (Chinese)
  - INSTALLATION.md (setup guide)
  - VISUAL_GUIDE.md (plot explanation)
  - FAQ.md (troubleshooting)
- Example scripts:
  - examples/quick_start.R (minimal example)
  - examples/example_usage.R (comprehensive examples)
- Test script: tests/test_function.R
- .gitignore for excluding output files

### Features
- No significance testing (pure correlation coefficients)
- Configurable correlation value display (on/off, decimal places)
- Variable ordering options
- Custom color palettes
- Support for different output formats (PNG, PDF, JPEG, TIFF)
- Handles missing data with pairwise complete observations
- Flexible layout options (upper/lower triangle)

### Documentation
- Full API documentation in function comments
- Usage examples for common scenarios
- Visual guide explaining plot components
- FAQ covering common questions and issues
- Installation guide for different platforms

## Future Enhancements (Potential)

These features could be added in future versions:
- [ ] Hierarchical clustering of variables
- [ ] Interactive plots using plotly
- [ ] Additional correlation methods (Kendall's tau)
- [ ] Partial correlation support
- [ ] Confidence intervals visualization (optional)
- [ ] Export to various statistical formats
- [ ] Integration with tidyverse workflows
- [ ] Support for very large correlation matrices (>50 variables)
- [ ] Automatic variable selection based on correlation strength
- [ ] Theme presets (publication, presentation, etc.)
