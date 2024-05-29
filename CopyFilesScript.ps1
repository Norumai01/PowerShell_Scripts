param (
    [string[]]$SourceFiles,
    [string[]]$DestinationFolders
)

# Function to create directory
function Copy-Files {
    param (
        [string[]]$SrcFiles,
        [string[]]$DestFolders
    )
    
    foreach ($SrcFile in $SrcFiles) {
        # Check if source folder exists
        CheckSourceFile -SrcFile $SrcFile
        # Reference with full link, instead of shorten.
        $fullSrcFile = Resolve-Path -Path $SrcFile
        
        foreach ($DestFolder in $DestFolders) {
            # Check if destination folder exists    
            CheckDestFolder -DestFolder $DestFolder
			# Reference with full link, instead of shorten.
            $fullDestFolder = Resolve-Path -Path $DestFolder
            
			# Copy and paste
            CopyPaste -SrcFile $fullSrcFile -DestFolder $fullDestFolder
        }
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
    # Check if destination folder exists    
    if (-not (Test-Path -Path $DestFolder)) {
        New-Item -ItemType Directory -Path $DestFolder -Force | Out-Null
        Write-Host "Created destination folder: " -NoNewline
        Write-Host "$DestFolder" -ForegroundColor Blue -NoNewline
        Write-Host "."
    }
}

function CopyPaste {
    param (
        [string]$SrcFile,
        [string]$DestFolder
    )
    # Copy and paste file either a file or files in folder.
    if (Test-Path -Path $SrcFile -PathType Container) {
        # Source is a folder.
        $DestFolderPath = Join-Path -Path $DestFolder -ChildPath (Get-Item $SrcFile).Name
		# Check if any subfolder needs to be created.
		CheckDestFolder -DestFolder $DestFolderPath

        Copy-Item -Path $SrcFile\* -Destination $DestFolderPath -Recurse -Force | Out-Null
        Write-Host "Copied contents of folder " -NoNewline 
        Write-Host "$SrcFile " -ForegroundColor Blue -NoNewline
        Write-Host "to " -NoNewline
        Write-Host "$DestFolderPath" -ForegroundColor Blue -NoNewline
        Write-Host "."
    } else {
        # Source is a file.
        $destFilePath = Join-Path -Path $DestFolder -ChildPath (Get-Item $SrcFile).Name
        Copy-Item -Path $SrcFile -Destination $destFilePath -Force | Out-Null
        Write-Host "Copied file " -NoNewline   
        Write-Host "$SrcFile " -ForegroundColor Blue -NoNewline
        Write-Host "to " -NoNewline
        Write-Host "$destFilePath" -ForegroundColor Blue -NoNewline
        Write-Host "."
    }
}

# Execute the copy operation.
$executionTime = Measure-Command {
    Copy-Files -SrcFiles $SourceFiles -DestFolders $DestinationFolders
}
Write-Host "Execution Time: $($executionTime.TotalSeconds) seconds"


