#!/bin/bash
# Written by David Trask
# https://davidrusseltrask.com/
# This script is designed to help with migrating from VMware to ProxMox
#
# Check the bottom of the script for the clean up phase
# Run this script forth

#This is for the starting VMID of the imported machines
vmid=1500

# Name of the storage you want to put the VMs on
storage="NFS-VMS"

# Disk format; can be raw, qcow2, or vmdk. Highly recommend against vmdk, use raw if your filesystem handles snapshots and qcow2 if it doesn't
format="raw"

#Enter your working folders here
ovafolder="/mnt/pve/NFS-VMS/OVAs"
workingfolder="/mnt/pve/NFS-VMS/temp"

for ova in $(ls $ovafolder/*.ova); do
  vmname=$(basename $ova .ova)
  echo "Starting work on $vmname..."
  echo "Current VMID is $vmid..."
  echo "Creating folder..."
  mkdir -p $workingfolder/$vmname
  echo "Extracting the OVA files..."
  tar -xvf $ova -C $workingfolder/$vmname
  echo "Starting to import the VM..."
  qm importovf $vmid $workingfolder/$vmname/$vmname.ovf $storage --format $format
  echo "Import of $vmname completed, check for errors above."
  vmid=$(($vmid+1))
  echo "Next VMID is $vmid..."
done


echo "Completed import of all VMs, cleaning up the working folder in 15 seconds..."
echo "Press Control + C to cancel the clean up"
sleep 15
# Commented out be default to make sure you don't lose your files uncomment this if you want the script to clean your temp files afterwards.
#rm -Rvf $workingfolder
echo "Clean up complete!"