$packageName = 'servverse'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'https://github.com/vyuvaraj/servverse-repo/releases/download/v1.7.0/ServVerse-windows-setup.exe'

Install-ChocolateyPackage -PackageName $packageName `
                          -FileType $fileType `
                          -SilentArgs $silentArgs `
                          -Url $url
