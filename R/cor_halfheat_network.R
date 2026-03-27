#' Correlation Half Heatmap with Network Plot
#'
#' This function creates a combined visualization with a lower triangle correlation
#' heatmap on the left and a network plot on the right showing connections between
#' independent variables and a dependent variable node.
#'
#' @param data A data.frame containing the variables
#' @param dependent_vars Character vector of dependent variable column names
#' @param independent_vars Character vector of independent variable column names
#' @param cor_method Correlation method: "pearson" (default) or "spearman"
#' @param palette Color palette for correlation values. Default is c("blue", "white", "red")
#' @param show_values Logical, whether to show correlation values on heatmap. Default is TRUE
#' @param value_digits Number of decimal places for correlation values. Default is 2
#' @param network_node_color Color for dependent variable node. Default is "purple"
#' @param indep_node_color Color for independent variable nodes. Default is "steelblue"
#' @param triangle_type Type of triangle: "lower" (default) or "upper"
#' @param var_order Character vector specifying order of independent variables. Default is NULL (use as provided)
#' @param line_width_by_cor Logical, whether line width should be proportional to |r|. Default is TRUE
#' @param cor_breaks Breaks for categorizing |r| values. Default is c(0, 0.2, 0.4, 1)
#' @param title Optional title for the plot
#'
#' @return A list of ggplot objects, one for each dependent variable
#'
#' @examples
#' # Create sample data
#' set.seed(123)
#' df <- data.frame(
#'   Y1 = rnorm(100),
#'   X1 = rnorm(100),
#'   X2 = rnorm(100),
#'   X3 = rnorm(100)
#' )
#' 
#' # Generate plot
#' plots <- cor_halfheat_network(
#'   data = df,
#'   dependent_vars = "Y1",
#'   independent_vars = c("X1", "X2", "X3"),
#'   cor_method = "pearson"
#' )
#' 
#' # Display the plot
#' print(plots[[1]])
#'
#' @export
cor_halfheat_network <- function(data,
                                   dependent_vars,
                                   independent_vars,
                                   cor_method = "pearson",
                                   palette = c("blue", "white", "red"),
                                   show_values = TRUE,
                                   value_digits = 2,
                                   network_node_color = "purple",
                                   indep_node_color = "steelblue",
                                   triangle_type = "lower",
                                   var_order = NULL,
                                   line_width_by_cor = TRUE,
                                   cor_breaks = c(0, 0.2, 0.4, 1),
                                   title = NULL) {
  
  # Load required packages
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required but not installed.")
  }
  if (!requireNamespace("gridExtra", quietly = TRUE)) {
    stop("Package 'gridExtra' is required but not installed.")
  }
  if (!requireNamespace("grid", quietly = TRUE)) {
    stop("Package 'grid' is required but not installed.")
  }
  
  library(ggplot2)
  library(gridExtra)
  library(grid)
  
  # Validate inputs
  if (!all(dependent_vars %in% colnames(data))) {
    stop("Some dependent variables are not found in the data.")
  }
  if (!all(independent_vars %in% colnames(data))) {
    stop("Some independent variables are not found in the data.")
  }
  if (!cor_method %in% c("pearson", "spearman")) {
    stop("cor_method must be 'pearson' or 'spearman'.")
  }
  
  # Apply variable ordering if specified
  if (!is.null(var_order)) {
    independent_vars <- var_order[var_order %in% independent_vars]
  }
  
  # Initialize list to store plots
  plot_list <- list()
  
  # Create a plot for each dependent variable
  for (dep_var in dependent_vars) {
    # Calculate correlations between independent variables (for heatmap)
    cor_matrix <- cor(data[, independent_vars], 
                      use = "pairwise.complete.obs",
                      method = cor_method)
    
    # Calculate correlations with dependent variable (for network)
    cor_with_dep <- cor(data[, independent_vars], 
                        data[, dep_var, drop = FALSE],
                        use = "pairwise.complete.obs",
                        method = cor_method)[, 1]
    
    # Prepare heatmap data (lower triangle only)
    n_vars <- length(independent_vars)
    heatmap_data <- data.frame()
    
    for (i in 1:n_vars) {
      for (j in 1:n_vars) {
        if (triangle_type == "lower" && i > j) {
          heatmap_data <- rbind(heatmap_data, data.frame(
            Var1 = independent_vars[i],
            Var2 = independent_vars[j],
            value = cor_matrix[i, j]
          ))
        } else if (triangle_type == "upper" && i < j) {
          heatmap_data <- rbind(heatmap_data, data.frame(
            Var1 = independent_vars[i],
            Var2 = independent_vars[j],
            value = cor_matrix[i, j]
          ))
        }
      }
    }
    
    # Set factor levels to control order
    heatmap_data$Var1 <- factor(heatmap_data$Var1, levels = independent_vars)
    heatmap_data$Var2 <- factor(heatmap_data$Var2, levels = independent_vars)
    
    # Create heatmap plot
    p_heatmap <- ggplot(heatmap_data, aes(x = Var2, y = Var1, fill = value)) +
      geom_tile(color = "white", size = 0.5) +
      scale_fill_gradientn(colors = palette,
                          limits = c(-1, 1),
                          name = "Correlation\nCoefficient (r)",
                          breaks = seq(-1, 1, 0.5)) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        axis.text.y = element_text(hjust = 1),
        axis.title = element_blank(),
        panel.grid = element_blank(),
        legend.position = "right",
        plot.margin = margin(5, 5, 5, 5)
      ) +
      coord_fixed()
    
    # Add correlation values if requested
    if (show_values) {
      heatmap_data$label <- sprintf(paste0("%.", value_digits, "f"), heatmap_data$value)
      p_heatmap <- p_heatmap +
        geom_text(aes(label = label), color = "black", size = 3)
    }
    
    # Prepare network data
    network_data <- data.frame(
      var = independent_vars,
      correlation = cor_with_dep,
      x_start = 1,  # Starting x position for independent variables
      y_start = seq(n_vars, 1, length.out = n_vars),  # Y positions
      x_end = 2.5,  # Ending x position (dependent variable)
      y_end = (n_vars + 1) / 2  # Center y position for dependent variable
    )
    
    # Categorize correlation strength
    network_data$cor_abs <- abs(network_data$correlation)
    network_data$cor_category <- cut(network_data$cor_abs,
                                      breaks = cor_breaks,
                                      labels = FALSE,
                                      include.lowest = TRUE)
    
    # Create network plot
    p_network <- ggplot(network_data) +
      # Draw lines from independent to dependent variable
      geom_segment(aes(x = x_start, y = y_start, 
                      xend = x_end, yend = y_end,
                      color = correlation,
                      size = if(line_width_by_cor) cor_abs else 1),
                  alpha = 0.6) +
      # Independent variable nodes
      geom_point(aes(x = x_start, y = y_start), 
                color = indep_node_color, size = 4) +
      # Dependent variable node
      geom_point(aes(x = 2.5, y = (n_vars + 1) / 2), 
                color = network_node_color, size = 8) +
      # Variable labels
      geom_text(aes(x = x_start - 0.15, y = y_start, label = var),
               hjust = 1, size = 3.5) +
      annotate("text", x = 2.5, y = (n_vars + 1) / 2 + 0.3,
              label = dep_var, size = 4.5, fontface = "bold") +
      scale_color_gradientn(colors = palette,
                           limits = c(-1, 1),
                           name = "Correlation\nCoefficient (r)",
                           breaks = seq(-1, 1, 0.5)) +
      scale_size_continuous(range = c(0.5, 2), guide = "none") +
      xlim(0, 3) +
      ylim(0, n_vars + 1) +
      theme_void() +
      theme(legend.position = "none",
            plot.margin = margin(5, 5, 5, 5))
    
    # Combine plots using gridExtra
    combined_plot <- gridExtra::grid.arrange(
      p_heatmap, p_network,
      ncol = 2,
      widths = c(2, 1),
      top = if(!is.null(title)) {
        textGrob(title, gp = gpar(fontsize = 14, fontface = "bold"))
      } else {
        textGrob(paste("Correlation Analysis:", dep_var),
                gp = gpar(fontsize = 14, fontface = "bold"))
      }
    )
    
    plot_list[[dep_var]] <- combined_plot
  }
  
  return(plot_list)
}


#' Save Correlation Half Heatmap Network Plots
#'
#' Helper function to save the generated plots to files
#'
#' @param plot_list List of plots returned by cor_halfheat_network
#' @param output_dir Directory to save plots. Default is "output"
#' @param width Plot width in inches. Default is 12
#' @param height Plot height in inches. Default is 8
#' @param dpi Resolution in dots per inch. Default is 300
#' @param format File format: "png" (default), "pdf", "jpeg", or "tiff"
#'
#' @return NULL (saves files to disk)
#'
#' @examples
#' plots <- cor_halfheat_network(data, "Y1", c("X1", "X2", "X3"))
#' save_cor_plots(plots, output_dir = "figures", format = "png")
#'
#' @export
save_cor_plots <- function(plot_list,
                           output_dir = "output",
                           width = 12,
                           height = 8,
                           dpi = 300,
                           format = "png") {
  
  # Create output directory if it doesn't exist
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  
  # Save each plot
  for (var_name in names(plot_list)) {
    filename <- file.path(output_dir, 
                         paste0("cor_halfheat_network_", var_name, ".", format))
    
    ggsave(filename, 
           plot = plot_list[[var_name]],
           width = width,
           height = height,
           dpi = dpi,
           device = format)
    
    message(paste("Saved plot to:", filename))
  }
}
