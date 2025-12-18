# R Package Version Conflict Fix

## Error Description

```
Error in loadNamespace(...) :
  namespace 'xfun' 0.52 is already loaded, but >= 0.54 is required
```

This error occurs when an older version of the `xfun` package is loaded in your R session, but the analysis requires a newer version.

## Solution Options

### Option 1: Quick Fix (Recommended)

1. **Restart your R session completely**
   - In RStudio: `Session > Restart R` or `Ctrl+Shift+F10`
   - In terminal: Exit R and start a new session

2. **Update the xfun package:**
   ```r
   install.packages("xfun")
   ```

3. **Update related packages:**
   ```r
   install.packages(c("knitr", "rmarkdown"))
   ```

4. **Run the analysis again**

### Option 2: Using the Fix Script

Run the provided R script:

```bash
Rscript fix_r_packages.R
```

Then restart R and run your analysis.

### Option 3: Manual Update in R Console

```r
# Remove old package if necessary
remove.packages("xfun")

# Install latest version
install.packages("xfun", repos = "https://cloud.r-project.org")

# Verify version
packageVersion("xfun")  # Should be >= 0.54

# Restart R session
.rs.restartR()  # In RStudio
```

## Prevention

To avoid this issue in the future:

1. **Always start with a clean R session** when running the analysis notebook
2. **Update packages regularly:**
   ```r
   update.packages(ask = FALSE)
   ```

3. **Use a clean environment:**
   ```r
   rm(list = ls())  # Already included in the notebook
   ```

## Alternative: Run Without Knitting

If you just want to run the analysis without knitting to HTML:

1. **Open the .Rmd file in RStudio**
2. **Run chunks individually** (Ctrl+Shift+Enter)
3. **Or source as R script:**
   ```r
   # Extract R code from Rmd
   knitr::purl("metabric_detailed.Rmd", output = "metabric_analysis.R")

   # Run the extracted script
   source("metabric_analysis.R")
   ```

## Verifying the Fix

After updating packages, verify versions:

```r
# Check xfun version
packageVersion("xfun")  # Should show >= 0.54

# Check other key packages
packageVersion("knitr")
packageVersion("rmarkdown")
packageVersion("tidyverse")
packageVersion("survival")
packageVersion("survminer")
packageVersion("pROC")
```

## Running the Analysis

Once packages are updated and R is restarted:

**In RStudio:**
```r
rmarkdown::render("metabric_detailed.Rmd")
```

**In terminal:**
```bash
Rscript -e "rmarkdown::render('metabric_detailed.Rmd')"
```

## System Information

To check your current R setup:

```r
# R version
R.version.string

# Installed packages and versions
installed.packages()[c("xfun", "knitr", "rmarkdown"), c("Package", "Version")]

# Library paths
.libPaths()
```

## If Issues Persist

1. **Update R itself** to the latest version
2. **Update RStudio** if using RStudio
3. **Clear package cache:**
   ```r
   # Remove all packages and reinstall
   lib <- .libPaths()[1]
   pkgs <- installed.packages()[, "Package"]
   remove.packages(pkgs, lib)

   # Then reinstall required packages
   ```

4. **Check for conflicting package installations:**
   ```r
   # Look for duplicate installations
   find.package("xfun", lib.loc = .libPaths())
   ```

## Contact

If you continue to experience issues, please provide:
- R version: `R.version.string`
- xfun version: `packageVersion("xfun")`
- Operating system
- Error message (full output)
