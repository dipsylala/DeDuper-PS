$Source = 'c:\input'
$Destination = 'c:\output'
$Filter = '*.dll;*.pdb'

foreach ($File in Get-ChildItem -File $Source -Recurse) {
    $FileBaseName = $File.BaseName
    $Hash = (Get-FileHash $File -Algorithm MD5).Hash.ToLower()

    $FullDestinationDirectory = Join-Path $Destination $Hash.substring(0, 2) ($File.BaseName + ' - ' + $Hash)

    if(!(Test-Path $FullDestinationDirectory)){
        New-Item -ItemType "directory" -Path $FullDestinationDirectory | Out-Null
    }

    Copy-Item -Path $File.FullName -Destination $FullDestinationDirectory\$FileBaseName
}
