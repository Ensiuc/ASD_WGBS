#!/bin/bash
#
#This script is for creat a symbolic link original fasta files
#SBATCH --time=5-00
#SBATCH --mem=5G# Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --partition=production # Partition to submit to
#SBATCH --output=slurmout/sym-%A-%a.out # File to which STDOUT will be written
#SBATCH --error=slurmout/sym-%A-%a.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=ehabibi@ucdavis.edu

file=$1  # allsamples list

start=`date +%s`
hostname

aklog
export baseP=/share/lasallelab/Ensi/
export fastqP=/share/lasallelab/data/2021_ASD_NDBS_ECHO_WGBS_Nova260_Jules/cytosine_reports_hg38/Females_Males/
export outP=${baseP}/cytosine_report_hg38/

if [ ! -d "${outP}" ]; then
mkdir ${outP} 
fi



file=$1
n=$(wc -l ${file} | awk '{print $1}')
x=1

while [ ${x} -le ${n} ] #This can be adjusted based on number of files
do

        string="sed -n ${x}p $file" #The file here represents whatever metadate file contains columns of barcodes and names
        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1,$2,$3,$4}')
        set -- $var
        c1=$1
        c2=$2
        c3=$3
        c4=$4

        #make a link to the original fastq files 

       ln -s ${fastqP}/${c1}_1_val_1_bismark_bt2_pe.deduplicated.bismark.cov.gz.CpG_report.txt.gz ./${c1}.CpG_report.txt.gz


        x=$(( $x + 1 )) #This will loop the file to the next line

