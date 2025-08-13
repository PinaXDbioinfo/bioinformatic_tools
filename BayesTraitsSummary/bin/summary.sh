#!/bin/bash

cp summary.R ../data
cd ../data
chmod +x summary.R

temp_lista=$(ls | grep '.Log') 

for i in $(echo $temp_lista)
do
temp=${i}
tempdir="${temp%.*}"
mkdir ${tempdir}
Rscript summary.R "${temp}"
mv *_distribution.png ${tempdir}/
mv *_ReconstructionSummary.csv ${tempdir}/
mv *_traceplot.png ${tempdir}/
done

rm -r summary.R