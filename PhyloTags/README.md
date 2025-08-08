# PhyloTags. Automatic internal node labeling and descendant extraction from a phylogenetic tree

## Description

PhyloTags is a lightweight and practical tool designed to label the internal nodes of a phylogenetic tree and identify their 
descendant species. It processes a tree file and generates:

A Newick tree with labeled internal nodes.
A PNG image of the tree with visible internal node labels.
A text file listing the descendant species for each internal node.

This tool is especially useful for:

Preparing labeled trees for downstream analyses.
Identifying clades or subtrees based on node descendants.
Enabling customized node tracking or trait aggregation at internal nodes.
Teaching or visualizing evolutionary relationships with labeled nodes.
Write the taggs for analyses in BayesTraits

Example files are available in the example_data directory.
To run the example, move the tree.nex file into the data directory as follows:

mv example_data/tree.nex data/tree.nex

bin/ → Contains the scripts needed to run PhyloTags.
data/ → Place your input tree file here.
Results/ → All generated output files will be saved here.

---

## Example Image
![Example](example_plot.png)

#example of a .txt file that containt the descendants of Node 13
[`Node13.txt`]

---

## Requirements
- R (>= 4.0)
- Packages:
  - ape
---

## How to Run

The first step is move tour tree in nexus format to the data directory. After that change your working directory to the bin directory and run this script as follows:

PhyloTags.sh name_of_your_tree.nex

Author: José Emilio Ramírez Piña
