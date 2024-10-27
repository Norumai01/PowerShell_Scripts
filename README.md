# PowerShell Automation Scripts

A collection of useful PowerShell scripts for file and directory management automation.

## Scripts Overview

### 1. FolderSubCreatorScript.ps1
Creates directories at specified paths.

**Parameters:**
- `Paths` (string[]): Array of directory paths to create

**Features:**
- Creates multiple directories in a single execution
- Checks for existing directories to avoid duplicates
- Measures and reports execution time
- Provides feedback for each directory creation

**Usage Example:**
```powershell
.\FolderSubCreatorScript.ps1 -Paths @("C:\NewFolder1", "C:\NewFolder2\SubFolder")
```

### 2. CopyFilesScript.ps1
Copies files and folders to multiple destination locations.

**Parameters:**
- `SourceFiles` (string[]): Array of source file/folder paths
- `DestinationFolders` (string[]): Array of destination folder paths

**Features:**
- Supports copying multiple files to multiple destinations
- Handles both files and folders
- Creates destination directories if they don't exist
- Maintains folder structure when copying directories
- Provides colored console output for better visibility
- Reports execution time
- Supports recursive folder copying
- Includes force option to overwrite existing files

**Usage Example:**
```powershell
.\CopyFilesScript.ps1 -SourceFiles @("C:\source\file1.txt", "C:\source\folder1") -DestinationFolders @("D:\dest1", "E:\dest2")
```

### 3. MoveFilesScript.ps1
Moves files from source locations to a destination folder.

**Parameters:**
- `SourceFiles` (string[]): Array of source file paths
- `DestinationFolder` (string): Single destination folder path

**Features:**
- Moves multiple files in a single operation
- Creates destination directory if it doesn't exist
- Uses full path resolution for reliability
- Provides colored console output for better visibility
- Reports execution time
- Includes error handling for move operations
- Supports force move to handle existing files

**Usage Example:**
```powershell
.\MoveFilesScript.ps1 -SourceFiles @("C:\source\file1.txt", "C:\source\file2.txt") -DestinationFolder "D:\destination"
```

### 4. DeleteFilesScript.ps1
Deletes specified files and folders.

**Parameters:**
- `SourceFiles` (string[]): Array of file/folder paths to delete

**Features:**
- Deletes multiple files and folders in a single operation
- Supports both file and folder deletion
- Includes recursive deletion for folders
- Provides colored console output for better visibility
- Reports execution time
- Includes existence checking before deletion
- Uses force option for protected files

**Usage Example:**
```powershell
.\DeleteFilesScript.ps1 -SourceFiles @("C:\folder1", "C:\files\document.txt")
```

## Testing

Unit tests are included for the Move-Files script (MoveFilesScript.Tests.ps1) using Pester framework.

**Test Features:**
- Creates temporary test environment
- Tests file and folder movement
- Automatic cleanup after tests
- Verifies successful file transfers
- Uses BeforeAll and AfterAll hooks for setup/teardown

To run tests:
```powershell
Invoke-Pester .\MoveFilesScript.Tests.ps1
```

## Common Features Across All Scripts

- **Execution Time Measurement**: All scripts measure and report their execution time
- **Error Handling**: Built-in error checking and reporting
- **Path Validation**: Verification of source and destination paths
- **Colored Output**: Uses color-coded console output for better readability
- **Force Operations**: Supports overwriting existing files when necessary
- **Full Path Resolution**: Uses absolute paths for reliable operations

## Requirements

- PowerShell 5.1 or higher
- Administrator privileges may be required depending on the paths being accessed
- Pester module (for running tests)

## Notes

- All scripts use the `-Force` parameter for operations to handle existing files/folders
- Scripts provide detailed console output for monitoring progress
- Each operation is logged to the console with appropriate color coding
- Error handling is implemented for all critical operations