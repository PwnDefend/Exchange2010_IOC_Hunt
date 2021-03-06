function Get-FileHash{
    param (
    [string]
    $Path
    )

     $HashAlgorithm = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider;
     $Hash = [System.BitConverter]::ToString($hashAlgorithm.ComputeHash([System.IO.File]::ReadAllBytes($Path)));
     $Ret = @{'Algorithm' = 'SHA256';
              'Path' = $Path;
              'Hash' = $Hash.Replace('-', '');
               };
     return $Ret;
}

#get all the hashes from the inetput folder (recursive so we get all subfolders and files)

Get-ChildItem -Path C:\inetpub\wwwroot -Recurse

#lets put that into varaible in memory

$files = Get-ChildItem -Path C:\inetpub\wwwroot -Recurse

#now let's loop through each file
foreach($file in $files){

#do something
write-host $file
write-host $file.name
write-host $file.FullName
try{Get-FileHash $file.FullName}
Catch
{
Write-host "Unable to generate hash for $file.FullName" -ForegroundColor Red
}

}

#find any aspx files on the c:\ drive

( Get-ChildItem -Path C:\ -filter *.aspx -Recurse | ? {$_.CreationTime -ge (Get-Date).AddDays(-7)})

#find any aspx files on the c:\ drive and couunt them :)

( Get-ChildItem -Path C:\ -filter *.aspx -Recurse | ? {$_.CreationTime -ge (Get-Date).AddDays(-7)}).Count



$ips = Get-Content .\ips.txt

foreach($ip in $ips){
write-host $ip

}

$paths = Get-Content paths.txt

foreach($path in $paths){
write-host $path


$iislogs = Get-ChildItem $path -Include *.log, *.txt -recurse
foreach($log in $iislogs)
{
write-host $log
$logcontents = get-content -path $log.FullName

#ok we now have each log in memory
#now let's check if any of our IOCS (ips in this instance are in the logs)
foreach($ip in $ips){
write-host "seraching for $ip" -ForegroundColor Cyan
$iocfind = $logcontents | select-string -pattern $ip

if($iocfind) {

#write-host $iocfind -ForegroundColor Yellow

write-host "Found IOC in $log.FullName" -ForegroundColor Red

}
else
{
write-host "No IOC Found in $log.FullName" -Foregroundcolor Green
}
}



}

}