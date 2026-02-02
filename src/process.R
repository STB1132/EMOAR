#BiocManager::install("airway")
library(airway)
data(airway)
#BiocManager::install("scRNAseq")
# library(scRNAseq)
# sce <- ReprocessedAllenData() # e.g. mouse brain dataset
# install deps
#BiocManager::install(c("DESeq2", "pheatmap", "ggplot2", "tximport"))

# Load data
library(DESeq2); library(airway)
data(airway)
airway$dex <- relevel(airway$dex, "untrt")

# Build DESeq2 design
dds <- DESeqDataSet(airway, ~ dex)

# QC and filter
keep <- rowSums(counts(dds) >= 10) >= 4
dds <- dds[keep,]

# Run DE
dds <- DESeq(dds)
res <- results(dds)

# Visuals
library(ggplot2)
library(dplyr)

# Convert results to a data frame and handle NAs
res_df <- as.data.frame(res) %>%
  dplyr::mutate(
    gene = rownames(.),
    sig = case_when(
      padj < 0.05 & log2FoldChange > 1  ~ "Up",
      padj < 0.05 & log2FoldChange < -1 ~ "Down",
      TRUE ~ "NS"
    ),
    padj = ifelse(is.na(padj), 1, padj) # replace NA padj with 1
  )

# Custom volcano plot
volc <- ggplot(res_df, aes(x = log2FoldChange, y = -log10(padj), color = sig)) +
  geom_point(alpha = 0.6, size = 2) +
  scale_color_manual(values = c("Up" = "red", "Down" = "blue", "NS" = "grey")) +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "black") +  # FC thresholds
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "black") + # p-value threshold
  theme_minimal(base_size = 14) +
  ggtitle("Bulk RNA-seq Volcano Plot") +
  xlab("Log2 Fold Change") +
  ylab("-Log10 Adjusted P-value") +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.title = element_blank(),
    legend.position = "bottom"
  ) +
  geom_text(
    data = res_df %>% filter(padj < 0.01 & abs(log2FoldChange) > 2),
    aes(label = gene),
    vjust = -0.5,
    size = 3.5
  )

volc


# PCA
vsd <- vst(dds)
pca_data <- plotPCA(vsd, intgroup="dex", returnData=TRUE)
pca_plot <- ggplot(pca_data, aes(PC1, PC2, color=dex, label=name)) +
  geom_point(size=5, alpha = 0.5) +
  
  ggtitle("PCA of Bulk RNA-seq Samples") +
  geom_text(vjust=-1.5, size=3) +
  theme_minimal()
pca_plot
