function Setup-TestParameters {
    param (
        [string]$ScriptRoot
    )
    # Parameters Setup
    $testSourceFolder = Join-Path -Path $ScriptRoot -ChildPath "TestSrc"
    $testDestFolder = Join-Path -Path $ScriptRoot -ChildPath "TestDest"
    $testFile1 = Join-Path -Path $testSourceFolder -ChildPath "TestFile1.txt"
    $testFile2 = Join-Path -Path $testSourceFolder -ChildPath "TestFile2.txt"
    $testFolder1 = Join-Path -Path $testSourceFolder -ChildPath "TestFolder1"
    $testFolder2 = Join-Path -Path $testSourceFolder -ChildPath "TestFolder2"

    New-Item -Path $testSourceFolder -ItemType Directory -Force | Out-Null
    New-Item -Path $testDestFolder -ItemType Directory -Force | Out-Null
    New-Item -Path $testFile1 -ItemType File -Force | Out-Null
    New-Item -Path $testFile2 -ItemType File -Force | Out-Null
    New-Item -Path $testFolder1 -ItemType Directory -Force | Out-Null
    New-Item -Path $testFolder2 -ItemType Directory -Force | Out-Null

    return @{
        testSourceFolder = $testSourceFolder
        testDestFolder = $testDestFolder
        testFile1 = $testFile1
        testFile2 = $testFile2
        testFolder1 = $testFolder1
        testFolder2 = $testFolder2
    }
}
function Clear-TestParameters {
    param (
        [string]$paths
    )
    foreach ($path in $paths) {
        Remove-Item -Path $path -Recurse -Force | Out-Null
    }
}
