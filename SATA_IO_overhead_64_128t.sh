#!/bin/bash

cd minimap2
# SATA SSD I/O-overhead analysis
# Indexing
./minimap2 -d /mnt/satassd/mdietz/ref.mmi /mnt/satassd/mdietz/ref.fa

# Evict the relevant files from page cache
cd ..
vmtouch-e /mnt/satassd/mdietz/read_set.fastq
vmtouch-e /mnt/satassd/mdietz/ref.mmi

cd minimap2

# Run minimap2 with files from satassd on 128 threads and redirect the output of /usr/bin/time -v to exec_time.txt in /home/mdietz (overwrite mode)
/usr/bin/time -v -o /home/mdietz/exec_time.txt ./minimap2 -a -t 128 /mnt/satassd/mdietz/ref.mmi /mnt/satassd/mdietz/read_set.fasta > /dev/null
# Run it a second time with files from pagecache and redirect the output of /usr/bin/time -v to exec_time.txt in /home/mdietz (append mode)
/usr/bin/time -v -o /home/mdietz/exec_time.txt -a ./minimap2 -a -t 128 /mnt/satassd/mdietz/ref.mmi /mnt/satassd/mdietz/read_set.fasta > /dev/null

# Evict the relevant files from page cache
cd ..
vmtouch-e /mnt/satassd/mdietz/read_set.fastq
vmtouch-e /mnt/satassd/mdietz/ref.mmi
cd minimap2

# Run minimap2 with files from satassd on 64 threads and redirect the output of /usr/bin/time -v to exec_time.txt in /home/mdietz (append mode)
/usr/bin/time -v -o /home/mdietz/exec_time.txt -a ./minimap2 -a -t 64 /mnt/satassd/mdietz/ref.mmi /mnt/satassd/mdietz/read_set.fasta > /dev/null
# Run it a second time with files from pagecache and redirect the output of /usr/bin/time -v to exec_time.txt in /home/mdietz (append mode)
/usr/bin/time -v -o /home/mdietz/exec_time.txt -a ./minimap2 -a -t 64 /mnt/satassd/mdietz/ref.mmi /mnt/satassd/mdietz/read_set.fasta > /dev/null