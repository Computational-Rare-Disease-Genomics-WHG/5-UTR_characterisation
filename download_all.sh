#!/bin/bash 


### Download MANE v1 ###
# To run
# bash download_mane --mane_v 0.95

mane_v=${mane_v:-0.93}

while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
        # echo $1 $2 // Optional to see the parameter:value result
   fi

  shift
done

# Base url
ftp_url="ftp://ftp.ncbi.nlm.nih.gov/refseq/MANE/MANE_human/release_${mane_v}/*"

# CD to script directory
cd $(dirname "$0")

# Create MANE directory if it doesn't exist
mkdir -p ../../data/pipeline/MANE/${mane_v}

# Download to directory
wget --no-parent $ftp_url -P ../../data/pipeline/MANE/${mane_v}

echo "Completed downloading MANE ${mane_v}"

### Download gnomAD LOEUF scores ###
# downloads constraint metrics from gnomad's public bucket
# and not the requester pays bucket

# ensure that gsutil / bgzip is installed

# Currently using exomes 2.1.1

# TODO : Update when the new constraint metrics will be out
cd $(dirname "$0")

cd ../../

# Paths to the public data buckets
gs_contraint_transcript="gs://gcp-public-data--gnomad/release/2.1.1/constraint/gnomad.v2.1.1.lof_metrics.by_transcript.txt.bgz"

# Download from the gnomad storage bucket
gsutil cp gs://gcp-public-data--gnomad/release/2.1.1/constraint/gnomad.v2.1.1.lof_metrics.by_transcript.txt.bgz data/pipeline/GNOMAD

# Unzip the files as the raw files a bgzipeed
bgzip -d data/pipeline/GNOMAD/gnomad.v2.1.1.lof_metrics.by_transcript.txt.bgz

### Download Developmental Disorder Gene List ###

### Download Cancer Gene lists ###