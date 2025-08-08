#!/bin/bash

tree=$1

mkdir ../Results
mkdir ../Results/Descendants

chmod +x PhyloTags.R
Rscript PhyloTags.R "${tree}"

mv Node* ../Results/Descendants
mv labeled_tree.nwk ../Results
mv labeled_tree.png ../Results
