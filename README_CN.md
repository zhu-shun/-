# 相关系数半热图+网络图可视化

本仓库提供了一个R函数，用于创建组合相关性可视化图，包括：
- **下三角热图**：显示自变量之间的相关性
- **网络图**：显示自变量与因变量节点之间的连接

## 主要特点

- ✅ **无显著性检验**：仅显示相关系数（无p值）
- ✅ **红-白-蓝配色方案**：直观的渐变色，从负相关（蓝色）到正相关（红色）
- ✅ **灵活布局**：下三角热图，顶部和左侧显示变量名
- ✅ **网络可视化**：右侧因变量节点，带连接线
- ✅ **可自定义**：控制颜色、布局、相关方法等
- ✅ **多因变量支持**：一次为多个结果变量生成图

## 快速开始

```r
# 加载函数
source("R/cor_halfheat_network.R")

# 创建或加载数据
df <- data.frame(
  Y1 = rnorm(100),  # 因变量
  X1 = rnorm(100),  # 自变量
  X2 = rnorm(100),
  X3 = rnorm(100)
)

# 生成可视化图
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = "Y1",
  independent_vars = c("X1", "X2", "X3"),
  cor_method = "pearson",
  palette = c("blue", "white", "red")
)

# 显示图形
print(plots[[1]])
```

## 主要函数参数

```r
cor_halfheat_network(
  data,                    # 包含变量的数据框
  dependent_vars,          # 因变量名称的字符向量
  independent_vars,        # 自变量名称的字符向量
  cor_method = "pearson",  # "pearson" 或 "spearman"
  palette = c("blue", "white", "red"),  # 颜色渐变
  show_values = TRUE,      # 在热图上显示相关值
  value_digits = 2,        # 值的小数位数
  network_node_color = "purple",     # 因变量节点颜色
  indep_node_color = "steelblue",    # 自变量节点颜色
  triangle_type = "lower", # "lower" 或 "upper" 三角
  line_width_by_cor = TRUE,  # 线宽是否与|r|成比例
  title = NULL             # 可选的图标题
)
```

## 使用示例

### 示例1：基本用法

```r
source("R/cor_halfheat_network.R")

# 您的数据
df <- read.csv("mydata.csv")

# 生成图形
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = "结果变量",
  independent_vars = c("变量1", "变量2", "变量3", "变量4"),
  cor_method = "pearson"
)

# 查看图形
print(plots[[1]])
```

### 示例2：多个因变量

```r
# 为多个结果生成图形
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = c("结果1", "结果2", "结果3"),
  independent_vars = c("预测变量1", "预测变量2", "预测变量3"),
  cor_method = "spearman"
)

# 查看所有图形
for (var_name in names(plots)) {
  print(plots[[var_name]])
}
```

### 示例3：保存图形到文件

```r
# 生成图形
plots <- cor_halfheat_network(
  data = df,
  dependent_vars = c("Y1", "Y2"),
  independent_vars = c("X1", "X2", "X3")
)

# 保存所有图形
save_cor_plots(
  plot_list = plots,
  output_dir = "figures",
  width = 12,
  height = 8,
  dpi = 300,
  format = "png"
)
```

## 可视化说明

生成的图形包含两个主要部分：

### 左侧：下三角热图
- 显示**自变量之间**的相关性
- 仅显示下三角（避免冗余）
- 颜色表示相关强度：
  - 🔴 红色：正相关
  - ⚪ 白色：无相关（r ≈ 0）
  - 🔵 蓝色：负相关
- 变量名显示在顶部（x轴，45°角）和左侧（y轴，水平）
- 每个单元格显示相关值（默认2位小数）

### 右侧：网络图
- 显示**自变量与因变量**之间的相关性
- 每个自变量用蓝色节点表示
- 因变量用更大的紫色节点表示在右侧
- 线条连接每个自变量到因变量
- 线条颜色表示相关强度（与热图相同的配色方案）
- 线条宽度与|r|成比例（默认）

### 颜色图例
- 右侧显示单个图例，显示-1到1的相关系数刻度
- 无显著性指标（无p值、无星号、无实线/虚线区分）

## 设计理念

此可视化工具的设计原则：

1. **关注效应大小**：直接显示相关系数，不进行显著性检验
2. **综合视图**：结合预测变量内部相关性（热图）和预测变量-结果相关性（网络）
3. **清晰直观**：红-白-蓝配色方案易于理解
4. **可重复**：所有参数都可以程序化控制

## 文件结构

```
.
├── R/
│   └── cor_halfheat_network.R    # 主函数
├── examples/
│   ├── quick_start.R             # 最小工作示例
│   └── example_usage.R           # 综合示例
├── tests/
│   └── test_function.R           # 验证测试
└── README.md                      # 说明文档
```

## 注意事项

- **无显著性检验**：此工具**不**计算p值或执行显著性检验。所有可视化都纯粹基于相关系数。
- **缺失数据**：函数使用`pairwise.complete.obs`处理缺失数据，使用所有可用的观测对计算相关性。
- **相关方法**：支持Pearson（参数）和Spearman（非参数）相关。
- **自定义**：几乎所有视觉方面都可以通过函数参数自定义。

## 所需R包

```r
install.packages(c("ggplot2", "gridExtra"))
```

完整的英文文档请参见 README.md。
