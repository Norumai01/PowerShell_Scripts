Import-Module Pester

# Set up test data (create temporary test files and folders)
BeforeAll {
    # Linking the script file
    . "..\MoveFilesScript.ps1"

    $testSourceFolder = Join-Path -Path $PSScriptRoot -ChildPath "TestSource"
    $testDestFolder = Join-Path -Path $PSScriptRoot -ChildPath "TestDestination"
    $testFile1 = Join-Path -Path $testSourceFolder -ChildPath "TestFile1.txt"
    $testFile2 = Join-Path -Path $testSourceFolder -ChildPath "TestFile2.txt"
    $testFolder1 = Join-Path -Path $testSourceFolder -ChildPath "TestFolder1"

    New-Item -Path $testSourceFolder -ItemType Directory -Force | Out-Null
    New-Item -Path $testDestFolder -ItemType Directory -Force | Out-Null
    New-Item -Path $testFile1 -ItemType File -Force | Out-Null
    New-Item -Path $testFile2 -ItemType File -Force | Out-Null
    New-Item -Path $testFolder1 -ItemType Directory -Force | Out-Null
}

# Clean up test data (remove temporary test files and folders)
AfterAll {
    Remove-Item -Path $testSourceFolder -Recurse -Force | Out-Null
    Remove-Item -Path $testDestFolder -Recurse -Force | Out-Null
}

Describe "Move-Files Function" {
    Context "Moving Test starts" {
        It "Moves files and folders to destination" {
            # Define source paths and destination folder
            $SourceFiles = @($testFile1, $testFile2, $testFolder1)
            $destinationFolder = $testDestFolder

            # Call the function.
            Move-Files -SrcFiles $SourceFiles -DestFolder $DestinationFolder

            # Verify the items were moved.
            foreach ($src in $SourceFiles) {
                $destinationPath = Join-Path -Path $destinationFolder -ChildPath (Split-Path -Leaf $src)
                Write-Host "$destinationPath"
                Test-Path -Path $destinationPath | Should -Be $true
            }
        }
    }
}
