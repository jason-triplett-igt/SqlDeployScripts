# Configuration
$serverName = "sql01"
$databaseName = "ezpay"
$dacpacFilePath = "C:\Users\User\dacpac\ezpayReference.dacpac"
$sqlPackagePath = "C:\Program Files\Microsoft SQL Server\160\DAC\bin\SqlPackage.exe" # Adjust as needed

# Build connection string
$connectionString = "Server=$serverName;Database=$databaseName;Integrated Security=True" #or replace with SQL auth

# Build sqlpackage command
$sqlPackageArguments = @(
    "/Action:Extract",
    "/SourceServerName:$serverName",
    "/SourceDatabaseName:$databaseName",
    "/TargetFile:$dacpacFilePath",
    "/SourceTrustServerCertificate:True", # Use if needed
    "/p:VerifyExtraction=False"
)

# Execute sqlpackage
try {
    Write-Host "Extracting DACPAC from $serverName\$databaseName to $dacpacFilePath..."
    & $sqlPackagePath $sqlPackageArguments
    if ($LASTEXITCODE -eq 0) {
        Write-Host "DACPAC extraction completed successfully."
    } else {
        Write-Error "Error: DACPAC extraction failed. Error code: $($LASTEXITCODE)."
    }
} catch {
    Write-Error $_
}