param (
	[string[]]$Paths
)
# Function to create directory
function CreateDirectory {
	param (
		[string]$DirPath
	)
	# If folder doesn't exist, create it.
	if (-not (Test-Path -Path $DirPath)) {
		New-Item -ItemType Directory -Path $DirPath -Force
		Write-Host "Created directory: $DirPath"
	}
	else {
		Write-Host "Directory already exists: $DirPath"
	}
}
# Able to create multiple directories
$executionTime = Measure-Command {
	foreach ($Path in $Paths) {
		CreateDirectory -DirPath $Path
	}
}
Write-Host "Execution Time: $($executionTime.TotalSeconds) seconds"