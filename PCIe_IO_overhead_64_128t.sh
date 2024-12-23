#!/bin/bash

cd minimap2

# Indexing
./minimap2 -d /mnt/pciessd/mdietz/ref.mmi /mnt/pciessd/mdietz/ref.fa
# Evict the relevant files from page cache
cd ..
vmtouch -e /mnt/pciessd/mdietz/read_set.fastq
vmtouch -e /mnt/pciessd/mdietz/ref.mmi
cd minimap2

# Run minimap2 with files from pciessd on 128 threads and redirect the output of /usr/bin/time -v to exec_time.txt in /home/mdietz (overwrite mode)
/usr/bin/time -v -o /home/mdietz/pcie_exec_time.txt ./minimap2 -t 128 /mnt/pciessd/mdietz/ref.mmi /mnt/pciessd/mdietz/read_set.fastq > /dev/null
# Run it a second time with files from pagecache and redirect the output of /usr/bin/time -v to exec_time.txt in /home/mdietz (append mode)
/usr/bin/time -v -o /home/mdietz/pcie_exec_time.txt -a ./minimap2 -t 128 /mnt/pciessd/mdietz/ref.mmi /mnt/pciessd/mdietz/read_set.fastq > /dev/null

# Evict the relevant files from page cache
cd ..
vmtouch -e /mnt/pciessd/mdietz/read_set.fastq
vmtouch -e /mnt/pciessd/mdietz/ref.mmi
cd minimap2

# Run minimap2 with files from pciessd on 64 threads and redirect the output of /usr/bin/time -v to exec_time.txt in /home/mdietz (append mode)
/usr/bin/time -v -o /home/mdietz/pcie_exec_time.txt -a ./minimap2 -t 64 /mnt/pciessd/mdietz/ref.mmi /mnt/pciessd/mdietz/read_set.fastq > /dev/null
# Run it a second time with files from pagecache and redirect the output of /usr/bin/time -v to exec_time.txt in /home/mdietz (append mode)
/usr/bin/time -v -o /home/mdietz/pcie_exec_time.txt -a ./minimap2 -t 64 /mnt/pciessd/mdietz/ref.mmi /mnt/pciessd/mdietz/read_set.fastq > /dev/null