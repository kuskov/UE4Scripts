. $PSScriptRoot\packageconfig.ps1

function Get-Uproject-Filename {
    param (
        [string]$srcfolder,
        [PackageConfig]$config
    )

    $projfile = ""
    if ($config.ProjectFile) {
        if (-not [System.IO.Path]::IsPathRooted($config.ProjectFile)) {
            $projfile = Join-Path $srcfolder $config.ProjectFile
        } else {
            $projfile = Resolve-Path $config.ProjectFile
        }

        if (-not (Test-Path $projfile)) {
            throw "Invalid ProfileFile setting, $($config.ProjectFile) does not exist."
        }

    } else {
        # can return multiple results, pick the first one
        $matchedfile = @(Get-ChildItem -Path $srcfolder -Filter *.uproject)[0]
        $projfile = Join-Path $srcfolder $matchedfile
    }

    # Resolve to absolute (do it here and not in join so missing file is friendlier error)
    return Resolve-Path $projfile
}

