# Configuration
$serverName = "sql01"
$databaseName = "ezpay"
$dacpacFilePath = "C:\Users\User\dacpac\ezpayReference.dacpac"
$sqlPackagePath = "C:\Program Files\Microsoft SQL Server\160\DAC\bin\SqlPackage.exe"
$reportFilePath = "C:\Users\User\dacpac\deploy_report.xml"  # Output report file

# Build sqlpackage command
$sqlPackageArguments = @(
    "/Action:DeployReport",
    "/SourceFile:$dacpacFilePath",  # Use the DACPAC as source
    "/TargetServerName:$serverName",
    "/TargetDatabaseName:$databaseName",
    "/TargetTrustServerCertificate:True", # Use if needed for target
    "/p:CommandTimeout=60", # Adjust timeout as needed
    "/OutputPath:$reportFilePath"  # Specify output report file
)

# Execute sqlpackage
try {
    Write-Host "Generating deploy report for $dacpacFilePath..."
    & $sqlPackagePath $sqlPackageArguments
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Deploy report generated successfully at $reportFilePath"
    } else {
        Write-Error "Error: Failed to generate deploy report. Error code: $($LASTEXITCODE)"
    }
} catch {
    Write-Error $_
}