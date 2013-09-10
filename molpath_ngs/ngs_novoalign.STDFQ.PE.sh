#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -M stephen.newhouse@kcl.ac.uk
#$ -m beas
#$ -l h_vmem=3G
#$ -p -0.99999999999999999999999999999999999999999999999999
#$ -pe multi_thread 8
#$ -V

####################
## Call Novoalign ##
####################

N_CPU=8
fastq_prefix=${1}
sample_name=${2}
sample_dir=${3}

cd ${sample_dir}


## start novo 
echo "----------------------------------------------------------------------------------------" 
echo " Fastq prefix" ${1}
echo " Sample Name" ${2}
echo " Output dir" ${3}
echo "starting novoalign " 
echo " number of cpus " $N_CPU
echo "----------------------------------------------------------------------------------------" 

cd ${sample_dir}

${ngs_novo}/novoalign \
-d ${reference_genome_novoindex} \
-f ${fastq_dir}/${fastq_prefix}_1.fastq  ${fastq_dir}/${fastq_prefix}_2.fastq  \
-F STDFQ \
--Q2Off \
--3Prime  \
-g 65 \
-x 7 \
-r All \
-i PE 300,150 \
-c ${N_CPU} \
-k -K ${sample_dir}/${sample_name}.novoalign.K.stats \
-o SAM > ${sample_dir}/${sample_name}.aln.sam;

echo "end novoalign"

echo "----------------------------------------------------------------------------------------" 

ls -l 

echo "----------------------------------------------------------------------------------------" 

samtools view -hS ${sample_dir}/${sample_name}.aln.sam | head -500
 























