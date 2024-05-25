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
		
		foreach ($DestFolder in $DestFolders) {
			# Check if desination folder exists	
			CheckDestFolder -DestFolder $DestFolder

			# Join the destination folder with the child file
			$destFilePath = Join-Path -Path $DestFolder -ChildPath (Get-Item $SrcFile).Name

			# Copy and paste
            Copy-Item -Path $SrcFile -Destination $destFilePath -Force
            Write-Host "Copied $SrcFile to $destFilePath"

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

# Execute the copy operation.
$executionTime = Measure-Command {
	Copy-Files -SrcFiles $SourceFiles -DestFolders $DestinationFolders
}
Write-Host "Execution Time: $($executionTime.TotalSeconds) seconds"

