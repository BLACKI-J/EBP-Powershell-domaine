# Define the path to the SQL Server Express installer
$sqlInstallerPath = ".\SQL2019-SSEI-Expr.exe"

# Log file
$logFile = "installation_sql_log.txt"

# Function to log output
function Log-Output {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    Write-Output $logMessage
    $logMessage | Out-File -FilePath $logFile -Append
}

# Step 1: Install SQL Server Express 2019
Log-Output "Starting SQL Server Express 2019 installation..."
$process = Start-Process -FilePath $sqlInstallerPath -ArgumentList "/ACTION=INSTALL /UIMODE=AutoAdvance /IACCEPTSQLSERVERLICENSETERMS" -PassThru
$process.WaitForExit()

if ($process.ExitCode -eq 0) {
    Log-Output "SQL Server Express 2019 installation completed successfully."
} else {
    Log-Output "SQL Server Express 2019 installation failed with exit code $($process.ExitCode)."
    exit $process.ExitCode
}