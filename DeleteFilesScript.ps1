param (
    [string[]]$SourceFiles
)
function Delete-Files {
    param(
        [string[]]$SrcFiles
    )
    foreach($SrcFile in $SrcFiles) {
        # Check if source folder exists
        CheckSourceFile -SrcFile $SrcFile
        # Reference with full link, instead of shorten
        $fullSrcFile = Resolve-Path -Path $SrcFile

        # Delete operation
        DeleteItems -SrcFile $fullSrcFile
    }
}
function CheckSourceFile {
    param (
        [string]$SrcFile
    )
    # Check if source folder exists
    if (-not (Test-Path -Path $SrcFile)) {
        Write-Host "Source file does not exist: " -NoNewline 
        Write-Host "$SrcFile" -ForegroundColor Blue -NoNewline
        Write-Host "."
        continue
    }
}
function DeleteItems {
    param(
        [string]$SrcFile
    )
    # Source file is a folder
    if (Test-Path -Path $SrcFile -PathType Container) {
        Remove-Item -Path $SrcFile -Recurse -Force | Out-Null
        Write-Host "Deleted folder: " -NoNewline
        Write-Host "$SrcFile" -ForegroundColor Blue -NoNewline
        Write-Host "."
    }
    # Source file is a file
    else {
        Remove-Item -Path $SrcFile -Force | Out-Null
        Write-Host "Deleted file: " -NoNewline
        Write-Host "$SrcFile" -ForegroundColor Blue -NoNewline
        Write-Host "."
    }
}
# Run script and measure time taken.
$executionTime = Measure-Command {
    Delete-Files -SrcFiles $SourceFiles
}
Write-Host "Execution Time: $($executionTime.TotalSeconds) seconds"