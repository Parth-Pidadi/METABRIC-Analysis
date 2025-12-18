#!/usr/bin/env Rscript

# Fix for xfun package version conflict
# This script updates the xfun package and other dependencies

cat("=====================================\n")
cat("Fixing R Package Dependencies\n")
cat("=====================================\n\n")

# First, detach xfun if it's loaded
if ("xfun" %in% loadedNamespaces()) {
  cat("Detaching currently loaded xfun package...\n")
  try(unloadNamespace("xfun"), silent = TRUE)
}

# Update xfun to latest version
cat("Updating xfun package...\n")
install.packages("xfun", repos = "https://cloud.r-project.org")

# Update other commonly needed packages
cat("\nUpdating related packages...\n")
packages_to_update <- c("knitr", "rmarkdown", "tinytex")

for (pkg in packages_to_update) {
  cat(sprintf("  - Updating %s...\n", pkg))
  install.packages(pkg, repos = "https://cloud.r-project.org")
}

cat("\n=====================================\n")
cat("Package Update Complete!\n")
cat("=====================================\n\n")

# Show installed versions
cat("Installed versions:\n")
for (pkg in c("xfun", "knitr", "rmarkdown")) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    version <- packageVersion(pkg)
    cat(sprintf("  - %s: %s\n", pkg, version))
  }
}

cat("\nPlease restart your R session before running the analysis.\n")
