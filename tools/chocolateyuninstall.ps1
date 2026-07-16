$packageName = 'servverse'
$softwareName = 'ServVerse*'

Uninstall-ChocolateyPackage -PackageName $packageName `
                            -SoftwareName $softwareName
