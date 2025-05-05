# Formatting and Mounting external disk

```shell
leonard in 🌐 dotomics-modelv0-swedencentral-02-gpu-train in ~ 
❯ lsblk # list all block device
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda       8:0    0    1T  0 disk # <-- this is the one we are interested in.
                                 # Notice that the block point does not contain any partition yet, we will need to take care ot this!
sdb       8:16   0    1T  0 disk 
├─sdb1    8:17   0 1023G  0 part /
├─sdb14   8:30   0    4M  0 part 
├─sdb15   8:31   0  106M  0 part /boot/efi
└─sdb16 259:0    0  913M  0 part /boot
sdc       8:32   0  256G  0 disk 
└─sdc1    8:33   0  256G  0 part /mnt
nvme0n1 259:1    0  3.5T  0 disk 
nvme1n1 259:2    0  3.5T  0 disk 

leonard in 🌐 dotomics-modelv0-swedencentral-02-gpu-train in ~ 
❯ sudo mkdir /mnt/data # create mount point

leonard in 🌐 dotomics-modelv0-swedencentral-02-gpu-train in ~ 
❯ sudo chmod 777 /mnt/data/ # handle permission at mount point

leonard in 🌐 dotomics-modelv0-swedencentral-02-gpu-train in ~ 
❯ sudo fdisk /dev/sda # Start partition process

Welcome to fdisk (util-linux 2.39.3).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS (MBR) disklabel with disk identifier 0xa1010cf8.

Command (m for help): n # create new partition
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p # create primary one
Partition number (1-4, default 1): 
First sector (2048-2147483647, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-2147483647, default 2147483647): 

Created a new partition 1 of type 'Linux' and of size 1024 GiB.

Command (m for help): w # exit paritition process
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.


leonard in 🌐 dotomics-modelv0-swedencentral-02-gpu-train in ~ took 27s 
❯ lsblk # check if partition has been created
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda       8:0    0    1T  0 disk 
└─sda1    8:1    0 1024G  0 part 
sdb       8:16   0    1T  0 disk 
├─sdb1    8:17   0 1023G  0 part /
├─sdb14   8:30   0    4M  0 part 
├─sdb15   8:31   0  106M  0 part /boot/efi
└─sdb16 259:0    0  913M  0 part /boot
sdc       8:32   0  256G  0 disk 
└─sdc1    8:33   0  256G  0 part /mnt
nvme0n1 259:1    0  3.5T  0 disk 
nvme1n1 259:2    0  3.5T  0 disk 

leonard in 🌐 dotomics-modelv0-swedencentral-02-gpu-train in ~ 
❯ sudo mkfs.ext4 /dev/sda1 # format partition
mke2fs 1.47.0 (5-Feb-2023)
Discarding device blocks: done                            
Creating filesystem with 268435200 4k blocks and 67108864 inodes
Filesystem UUID: 0d265e91-fad1-4dd5-a69c-2e113808a338
Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
        4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968, 
        102400000, 214990848

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (262144 blocks): done
Writing superblocks and filesystem accounting information: done     


leonard in 🌐 dotomics-modelv0-swedencentral-02-gpu-train in ~ took 5s 
❯ sudo mount /dev/sda1 /mnt/data/ # mount external disk on mount point

leonard in 🌐 dotomics-modelv0-swedencentral-02-gpu-train in ~ 
❯ sudo chown $USER:$USER /mnt/data/ # give user the right permission to write on mounted disk 

leonard in 🌐 dotomics-modelv0-swedencentral-02-gpu-train in ~ 
❯ cd /mnt/data/

leonard in 🌐 dotomics-modelv0-swedencentral-02-gpu-train in /mnt/data 
❯ touch test.txt # verify that you can create a file!

leonard in 🌐 dotomics-modelv0-swedencentral-02-gpu-train in /mnt/data 
❯ ls
lost+found  test.txt

leonard in 🌐 dotomics-modelv0-swedencentral-02-gpu-train in /mnt/data 
❯ rm test.txt 

```