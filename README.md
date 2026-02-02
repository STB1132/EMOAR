# EMOAR (End-to-End Multi-Omics Analysis with Reproducible HTML Reporting)

This repository contains interactive HTML reports generated from R for both bulk RNA-seq and single-cell RNA-seq (scRNA-seq) analyses. The purpose of these reports is to provide a fast, visually appealing showcase of R analysis, visualization, and HTML reporting skills, suitable for portfolio and CV presentation.


---

## Reports

1. **Simple Bulk RNA-seq Report**

   * HTML file: `../results/bulk_rnaseq_showcase.html`
   * Includes:

     * Quality control and filtering
     * Differential expression analysis
     * PCA plot of samples
     * Volcano plot of DE genes (interactive with Plotly)
     * Interactive and browsable tables of results using `DT`

2. **Simple Single-Cell RNA-seq Report**

   * HTML file: `../results/scRNAseq_showcase.html`
   * Includes:

     * Cell QC and filtering
     * Normalization and HVG selection
     * PCA and UMAP visualizations
     * Interactive marker volcano-like plots (example)
     * Interactive and browsable tables of cell metadata using `DT`

---

## Purpose

These reports are **designed for quick demonstration purposes**:

* Showcase the ability to process and visualize omics data in R
* Produce clean, interactive HTML outputs
* Highlight portfolio/CV presentation style

For **full-scale, production-ready RNA-seq analysis pipelines**, including batch correction, advanced normalization, and comprehensive differential expression workflows, please refer to the **RNA-seq pipeline** repository/documentation.
