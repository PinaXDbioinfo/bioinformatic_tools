#!/bin/bash

tree=$1
data=$2
iterations=$3
sample=$4
burnin=$5
modelo=$6
div_ES=$7

chmod +x ML.R PhyloTags.R

mkdir ../Results/Descendants

#obtain each descendant
chmod +x PhyloTags.R
echo Obtaining each internaal node of the tree and his descendants
Rscript PhyloTags.R "${tree}"

mv Node* ../Results/Descendants
mv labeled_tree.nwk ../Results
mv labeled_tree.png ../Results

#make dir for each internal node
cd ../Results/Descendants
lista=$(ls *.txt | grep 'Node')

for i in $(echo $lista)
do
temp=${i}
temp="${temp%.*}"
mkdir ${temp}
mv ${temp}.txt ${temp}/
done

#obtain ancestral value for each internal node
echo obtaining ancestral traits values in each internal node by maximum likehood
lista=$(ls)
 
for i in $(echo $lista)
do
temp=${i}
cp ../../bin/ML.R ${temp}
cd ${temp}
Rscript ML.R ${data}
rm -r ML.R
cd ..
done

#write script
echo Making scripts for each ancestral node

lista=$(ls)
 
for i in $(echo $lista)
do
temp=${i}
cd ${temp}
Node=$(cut -d ' ' -f1 Node*)
descendants=$(ls Node*)
recval=$(cut -d ',' -f1 RecML.csv | tail -n1)
SE=$(cut -d ',' -f6 RecML.csv | tail -n1)
SE=$(echo "$SE / $div_ES " | bc -l)
RI=$(echo "$recval - $SE" | bc -l)
RS=$(echo "$recval + $SE" | bc -l)

echo $modelo > "${Node}"_script.txt
echo 2 >> "${Node}"_script.txt
echo PriorAll uniform $RI $RS >> "${Node}"_script.txt
echo Iterations $iterations >> "${Node}"_script.txt
burn=$(echo "$iterations * $burnin / 100" | bc)
echo Burnin $burn >> "${Node}"_script.txt
echo Sample $sample >> "${Node}"_script.txt
echo AddTag $(cat < $(echo $descendants)) >> "${Node}"_script.txt
echo AddMRCA trait $Node >> "${Node}"_script.txt
echo Run >> "${Node}"_script.txt
cd ..
done