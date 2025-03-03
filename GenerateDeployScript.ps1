# Configuration
$serverName = "sql01"
$databaseName = "ezpay"
$dacpacFilePath = "C:\Users\User\dacpac\ezpayReference.dacpac"
$sqlPackagePath = "C:\Program Files\Microsoft SQL Server\160\DAC\bin\SqlPackage.exe"
$publishScriptPath = "C:\Users\User\dacpac\deploy_script.sql"  # Output script file

# Build sqlpackage command
$sqlPackageArguments = @(
    "/Action:Script",  # Generate a publish script
    "/SourceFile:$dacpacFilePath",  # Use the DACPAC as source
    "/TargetServerName:$serverName",
    "/TargetDatabaseName:$databaseName",
    "/TargetTrustServerCertificate:True", # Use if needed for target
    "/p:CommandTimeout=60", # Adjust timeout as needed
    "/DeployScriptPath:$publishScriptPath"  # Specify output script file
)

# Execute sqlpackage
try {
    Write-Host "Generating publish script for $dacpacFilePath..."
    & $sqlPackagePath $sqlPackageArguments
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Publish script generated successfully at $publishScriptPath"
    } else {
        Write-Error "Error: Failed to generate publish script. Error code: $($LASTEXITCODE)"
    }
} catch {
    Write-Error $_
}