# ScriptsBayesTraits. Automatic script generator for ancestral state reconstruction of quantitative trates for BayesTraits

## Description

ScriptsBayesTraits is a tool designed to simplify the creation of BayesTraits scripts for ancestral state reconstruction of 
quantitative traits. Its key feature is the ability to define uniform priors objectively, based on maximum likelihood estimations, 
rather than setting them arbitrarily. Additionally, the program generates scripts for each internal node of the phylogenetic tree, 
making it easier to select which nodes you want to reconstruct. This avoids the tedious process in BayesTraits where you must 
manually specify the descendants of a node to perform inference.

This tool is especially useful for:

Preparing labeled trees for downstream analyses.
Identifying clades or subtrees based on node descendants.
Enabling customized node tracking or trait aggregation at internal nodes.
Teaching or visualizing evolutionary relationships with labeled nodes.
Write the taggs for analyses in BayesTraits

## Input files

A phylogenetic tree in NEXUS format with taxa block
A tab-separated file containing the quantitative trait data without header

Example file are available in the data directory

bin/ → Contains the scripts needed to run PhyloTags.
data/ → Place your input tree file here.
Results/ → All generated output files will be saved here(this directory will be generated after run the script)

---

## Output example 

![Example](example_plot.png)

#example of a .txt file that containt the descendants of Node 13
[`Node13.txt`]

---

## Necessary programs and libraries
- R (>= 4.0)
- Packages from R:
  - ape
  - diversitree
---

## How to Run

The first step is move your tree in nexus format to the data directory. After that change your working directory to the bin directory and run this script as follows:

PhyloTags.sh name_of_your_tree.nex

Author: José Emilio Ramírez Piña
