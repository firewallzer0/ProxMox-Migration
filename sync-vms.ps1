# Written by David Trask
# https://davidrusseltrask.com/
# This script is designed to help with migrating from VMware to ProxMox
#
# Assumption is that you have this script in the same folder that the ovftool.exe lives in.
#
# Run this script second


$argumentsList = "--noSSLVerify"
$username = "root"
$password = "Passw0rd!"
$target_ip = "192.168.101.102"
$syntax = "vi://" + $username + ":" + $password + "@" + $target_ip

$listOfVMs = @()

foreach ($line in Get-Content .\list.txt) {
    if ($line -notmatch "Error:") {
        $listOfVMs += $line.trim()
    }
}

foreach ($vm in $listOfVMs) {
    .\ovftool.exe $argumentsList $syntax/$vm V:\VMBackup\$vm.ovf
}