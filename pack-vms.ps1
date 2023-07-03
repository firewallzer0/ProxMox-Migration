# Written by David Trask
# https://davidrusseltrask.com/
# This script is designed to help with migrating from VMware to ProxMox
#
# Assumption is that you have this script in the same folder that the ovftool.exe lives in.
#
# Run this script third


$listOfVMs = @()

foreach ($line in Get-Content .\list.txt) {
    if ($line -notmatch "Error:") {
        $listOfVMs += $line.trim()
    }
}

foreach ($vm in $listOfVMs) {
    .\ovftool.exe V:\VMBackup\$vm.ovf V:\VMBackup\OVA\$vm.ova
}