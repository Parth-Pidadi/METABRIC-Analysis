# Quick Setup Instructions for Running Analysis

## Issue Summary
1. ✅ **Syntax errors fixed** - Removed malformed else block
2. ⚠️ **Dataset location** - Need to copy cleaned file to your working directory
3. ⚠️ **xfun package** - Still needs R restart

## Solution: 3 Easy Steps

### Step 1: Copy the Cleaned Dataset

Your R session is running in:
```
D:/SUNY RF Research/TCGA_BRCA_updated/
```

**Copy the cleaned dataset file there:**

**Option A - If you have access to both locations:**
```bash
# Copy from repo to your R working directory
cp METABRIC_BLVRB_merged_data_clean.csv "D:/SUNY RF Research/TCGA_BRCA_updated/"
```

**Option B - Download from your repository:**
1. The cleaned file is in your GitHub repository
2. Download `METABRIC_BLVRB_merged_data_clean.csv`
3. Place it in: `D:/SUNY RF Research/TCGA_BRCA_updated/`

**Option C - Use the original (not recommended):**
- The script will work with the original merged data (2,509 patients)
- But results will be less reliable due to missing data

### Step 2: Fix the xfun Package

**Close ALL R windows and start fresh:**

```r
# In a new R session:
remove.packages("xfun")
install.packages("xfun")
install.packages(c("knitr", "rmarkdown"))

# Verify
packageVersion("xfun")  # Should be >= 0.54
```

### Step 3: Run the Analysis

```r
# Make sure you're in the right directory
getwd()  # Should show: D:/SUNY RF Research/TCGA_BRCA_updated

# Run the analysis
rmarkdown::render("metabric_detailed.Rmd")
```

---

## What Got Fixed

### ✅ Syntax Error Fixed
- Removed duplicate else block in Phase 5
- Fixed "unexpected else" error
- Chemotherapy analysis will now run properly

### ✅ Improved File Finding
The script now searches for files in multiple locations:
1. Current working directory
2. Script directory
3. Output directory

### ✅ Better Error Messages
- Clear warnings when files not found
- Diagnostic messages for debugging

---

## Expected Behavior After Fix

When you run the notebook, you should see:

```r
PHASE 1: Loading and merging data...
  Found CLEANED merged data file (complete cases only)! Loading...
    - File: D:/SUNY RF Research/TCGA_BRCA_updated/METABRIC_BLVRB_merged_data_clean.csv
    - Loaded 1050 patients with 43 columns
    - Dataset contains ONLY complete cases (no NA values)
    - Patients with BLVRB expression: 1050
    - Chemotherapy data:
       NO  YES
      821  229
```

**Not this (original file):**
```r
    - Loaded 2509 patients with 43 columns  # <-- Wrong!
```

---

## If You Still Get xfun Error

The xfun error happens because the old version is loaded in memory.

**The ONLY solution:**
1. Close R completely (not just restart session)
2. Close RStudio completely
3. Reopen RStudio
4. Update packages (as shown above)
5. Try again

---

## Quick Test

Before running the full analysis, test if everything is set up:

```r
# Test 1: Check files exist
file.exists("METABRIC_BLVRB_merged_data_clean.csv")  # Should be TRUE

# Test 2: Quick load test
test_data <- read.csv("METABRIC_BLVRB_merged_data_clean.csv")
nrow(test_data)  # Should be 1050 (not 2509)

# Test 3: Check xfun version
packageVersion("xfun")  # Should be >= 0.54

# If all 3 tests pass, you're ready!
rmarkdown::render("metabric_detailed.Rmd")
```

---

## Alternative: Run from Linux/WSL Directory

If you're using WSL/Linux, you can run directly from the repository:

```bash
cd /home/user/METABRIC-Analysis/
Rscript -e "rmarkdown::render('metabric_detailed.Rmd')"
```

This will automatically use the cleaned dataset since it's in the same directory.

---

## Need Help?

If issues persist:
1. Check R version: `R.version.string`
2. Check working directory: `getwd()`
3. List files: `list.files(pattern = "*.csv")`
4. Verify cleaned file location

All fixes have been pushed to your repository!
