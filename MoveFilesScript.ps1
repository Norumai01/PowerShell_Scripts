param (
    [string[]]$SourceFiles,
    [string]$DestinationFolder
)
# Function to create directory
function Move-Files {
    param (
        [string[]]$SrcFiles,
        [string]$DestFolder
    )
    foreach ($SrcFile in $SrcFiles) {
        # Check if source folder exists
        CheckSourceFile -SrcFile $SrcFile
        # Reference with full link, instead of shorten.
        $fullSrcFile = Resolve-Path -Path $SrcFile
        
        # Check if destination folder exists    
        CheckDestFolder -DestFolder $DestFolder
		# Reference with full link, instead of shorten.
        $fullDestFolder = Resolve-Path -Path $DestFolder 
		# Move
        MoveFile -SrcFile $fullSrcFile -DestFolder $fullDestFolder
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
function CheckDestFolder {
    param (
        [string]$DestFolder
    )
    try {
        # Check if destination folder exists    
        if (-not (Test-Path -Path $DestFolder)) {
            New-Item -ItemType Directory -Path $DestFolder -Force | Out-Null
            Write-Host "Created destination folder: " -NoNewline
            Write-Host "$DestFolder" -ForegroundColor Blue -NoNewline
            Write-Host "."
        }
    }
    catch {
        Write-Host "On function CheckDestFolder(), $DestFolder. Error: $_"
    }
}
function MoveFile {
    param (
        [string]$SrcFile,
        [string]$DestFolder
    )
    try {
        # Check if any subfolder needs to be created.
	    CheckDestFolder -DestFolder $DestFolder
        # Move Item
        Move-Item -Path $SrcFile -Destination $DestFolder -Force | Out-Null
        Write-Host "Moved file " -NoNewline   
        Write-Host "$SrcFile " -ForegroundColor Blue -NoNewline
        Write-Host "to " -NoNewline
        Write-Host "$DestFolder" -ForegroundColor Blue -NoNewline
        Write-Host "."
    }
    catch {
        Write-Host "Failed to move $SrcFile to $DestFolder. Error: $_"
    }
}

# Execute the copy operation.
$executionTime = Measure-Command {
    Move-Files -SrcFiles $SourceFiles -DestFolder $DestinationFolder
}
Write-Host "Execution Time: $($executionTime.TotalSeconds) seconds"


