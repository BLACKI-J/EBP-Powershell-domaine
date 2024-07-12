# Define the path to the SQL Server instance setup
$instanceSetupPath = "C:\SQL2019\Express_FRA\SETUP.EXE"

# Define credentials and instance details
$instanceName = "EBP"
$sqlSvcAccount = "STEPHENSON\ebp"
$sqlSvcPassword = "d&kD#ytsp?kETGzX6jix"
$saPassword = "d&kD#ytsp?kETGzX6jix"

# Log file
$logFile = "create_instance_log.txt"

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

# Step 2: Create SQL Server Instance
Log-Output "Creating SQL Server instance..."
$arguments = "/QS /ACTION=Install /IACCEPTSQLSERVERLICENSETERMS /INSTANCENAME=$instanceName /SQLSVCACCOUNT=$sqlSvcAccount /SQLSVCPASSWORD=$sqlSvcPassword /INDICATEPROGRESS /AGTSVCACCOUNT=$sqlSvcAccount /AGTSVCPASSWORD=$sqlSvcPassword /ASSVCACCOUNT=$sqlSvcAccount /ASSVCPASSWORD=$sqlSvcPassword /SECURITYMODE=SQL /SAPWD=$saPassword /ADDCURRENTUSERASSQLADMIN=True /SQLSVCSTARTUPTYPE=Automatic"

$process = Start-Process -FilePath $instanceSetupPath -ArgumentList $arguments -PassThru -Wait -NoNewWindow

if ($process.ExitCode -eq 0) {
    Log-Output "SQL Server instance created successfully."
} else {
    Log-Output "SQL Server instance creation failed with exit code $($process.ExitCode)."
    exit $process.ExitCode
}