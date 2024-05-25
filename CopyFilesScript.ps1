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
		# Resolve full path for the source path, if necessary
		$fullSrcPath = Resolve-Path -Path $SrcFile
		
		foreach ($DestFolder in $DestFolders) {
			$fullDestFolder = Resolve-Path -Path $DestFolder
			# Check if desination folder exists	
			CheckDestFolder -DestFolder $fullDestFolder

			# Copy and paste
			CopyPaste -SrcFile $fullSrcPath -DestFolder $fullDestFolder
		}
	}
}
function CheckSourceFile {
	param (
		[string]$SrcFile
	)
	# Check if source folder exists
	if (-not (Test-Path -Path $SrcFile)) {
		Write-Host "Source file does not exist: $SrcFile"
		continue
	}
}
function CheckDestFolder {
	param (
		[string]$DestFolder
	)
	# Check if desination folder exists	
	if (-not (Test-Path -Path $DestFolder)) {
		New-Item -ItemType Directory -Path $DestFolder -Force
		Write-Host "Created destination folder: $DestFolder"
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
		if (-not (Test-Path -Path $DestFolderPath)) {
			New-Item -ItemType Directory -Path $DestFolderPath -Force
		}
		Copy-Item -Path $SrcFile\* -Destination $DestFolderPath -Recurse -Force
		Write-Host "Copied contents of folder $SrcFile to $DestFolderPath"
	}
	else {
		# Source is a file.
		$destFilePath = Join-Path -Path $DestFolder -ChildPath (Get-Item $SrcFile).Name
		Copy-Item -Path $SrcFile -Destination $destFilePath -Force
		Write-Host "Copied file $SrcFile to $destFilePath"
	}
}

# Execute the copy operation.
$executionTime = Measure-Command {
	Copy-Files -SrcFiles $SourceFiles -DestFolders $DestinationFolders
}
Write-Host "Execution Time: $($executionTime.TotalSeconds) seconds"

