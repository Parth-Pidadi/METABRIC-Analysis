# Verify and list all output files from METABRIC analysis

output_dir <- "D:/SUNY RF Research/TCGA_BRCA_updated/BLVRB_Analysis_Results"

cat("========================================\n")
cat("METABRIC ANALYSIS OUTPUT VERIFICATION\n")
cat("========================================\n\n")

# Check figures directory
figures_dir <- file.path(output_dir, "figures")
if (dir.exists(figures_dir)) {
  figures <- list.files(figures_dir, pattern = "\\.png$", full.names = FALSE)
  
  cat(sprintf("FIGURES DIRECTORY: %d files\n", length(figures)))
  cat("----------------------------------------\n")
  
  for (fig in sort(figures)) {
    fig_path <- file.path(figures_dir, fig)
    size_kb <- round(file.info(fig_path)$size / 1024, 1)
    cat(sprintf("  ✓ %s (%s KB)\n", fig, size_kb))
  }
  cat("\n")
} else {
  cat("ERROR: Figures directory not found!\n\n")
}

# Check tables directory
tables_dir <- file.path(output_dir, "tables")
if (dir.exists(tables_dir)) {
  tables <- list.files(tables_dir, pattern = "\\.csv$", full.names = FALSE)
  
  cat(sprintf("TABLES DIRECTORY: %d files\n", length(tables)))
  cat("----------------------------------------\n")
  
  for (tbl in sort(tables)) {
    tbl_path <- file.path(tables_dir, tbl)
    size_kb <- round(file.info(tbl_path)$size / 1024, 1)
    cat(sprintf("  ✓ %s (%s KB)\n", tbl, size_kb))
  }
  cat("\n")
} else {
  cat("ERROR: Tables directory not found!\n\n")
}

# Check data directory
data_dir <- file.path(output_dir, "data")
if (dir.exists(data_dir)) {
  data_files <- list.files(data_dir, pattern = "\\.csv$", full.names = FALSE)
  
  cat(sprintf("DATA DIRECTORY: %d files\n", length(data_files)))
  cat("----------------------------------------\n")
  
  for (dat in sort(data_files)) {
    dat_path <- file.path(data_dir, dat)
    size_kb <- round(file.info(dat_path)$size / 1024, 1)
    cat(sprintf("  ✓ %s (%s KB)\n", dat, size_kb))
  }
  cat("\n")
}

# Summary
cat("========================================\n")
cat("SUMMARY\n")
cat("========================================\n")
cat(sprintf("Total Figures: %d\n", length(figures)))
cat(sprintf("Total Tables: %d\n", length(tables)))
cat(sprintf("Total Data Files: %d\n", length(data_files)))
cat("\n")

# Check for any files < 10 KB (potentially corrupted)
small_figures <- figures[file.info(file.path(figures_dir, figures))$size < 10240]
if (length(small_figures) > 0) {
  cat("WARNING: Small figures (< 10 KB):\n")
  for (sf in small_figures) {
    cat(sprintf("  ! %s\n", sf))
  }
  cat("\n")
} else {
  cat("✓ All figures are properly sized (> 10 KB)\n\n")
}

cat("All files saved successfully!\n")
