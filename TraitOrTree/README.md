# TraitOrTree. Automatic filtering and pruning of a phylogenetic tree to match trait data

## Description

TraitOrTree is a lightweight tool designed to ensure consistency between a phylogenetic tree and a corresponding dataset of species 
traits. It checks which species are present in your trait data but missing from the phylogenetic tree, and vice versa. Based on this 
comparison, it generates:

A pruned tree containing only species with available trait data.
A filtered dataset containing only species present in the tree.

This tool is especially useful for preparing input files for phylogenetic programs that require a perfect match between the species 
in the tree and the dataset (e.g., BayesTraits).

To run the script you only need two files:
1. **A Nexus tree** with a taxa block.
2. **A tab-delimited `.txt` file** with:
   - The species names (matching those in the tree) in the first column.
   - The quantitative trait values in the second column.
   - No column names (headerless file).

You can find example files in the directory example data

## Requirements
- R (>= 4.0)
- Packages:
  - ape
---

## How to Run

### **From the terminal**

Rscript TraitOrTree_script.R tree.nex data.txt

tree.nex → Phylogenetic tree in Nexus format.

data.txt → Tab-delimited file with numeric trait values for each species.

### **From R**

You can also run the code in TraitOrTree_function.R directly within your R session.
Before using the function, load your data:

library(ape)
tree <- read.nexus("tree.nex")
data <- read.csv("data.txt", sep = "\t", header = FALSE)

Then call the function:

TraitOrTree(tree, data)

After running, the script will generate:

new_tree.nwk → a pruned Newick tree with matching species.
new_data.txt → a filtered trait file with only the matching species.

Author: José Emilio Ramírez Piña
