# Get the current directory where the script is located
$currentDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition

if (-not $currentDirectory) {
    $currentDirectory = Get-Location
}

# Define the paths to the EBP installers
$installers = @(
    "EBP_2024_Comptabilite_ELITE_23_6_0_11594.exe",
    "EBP_2024_Etats_Financiers_PRO_23_3_0_4261.exe",
    "EBP_2024_Gestion_ELITE_23_1_1_9182.exe",
    "EBP_2024_Immobilisations_ELITE_23_2_0_4002.exe",
    "EBPOL_2022_Classic_BusinessPlan_14_0_0_2005.exe",
    "EBPOL_2024_Autonome_Paie_13_28_4_14901.exe",
    "EBPOL_2024_CRM_ELITE_16_0_0_1312.exe"
)

# Log file
$logFile = "installation_ebp_log.txt"

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

foreach ($installer in $installers) {
    $installerPath = Join-Path $currentDirectory $installer

    # Check if the installer exists
    if (Test-Path $installerPath) {
        Log-Output "EBP installer $installer found. Starting installation..."

        # Run the EBP installer
        $process = Start-Process -FilePath $installerPath -ArgumentList "/silent" -PassThru
        $process.WaitForExit()

        if ($process.ExitCode -eq 0) {
            Log-Output "EBP application $installer installation completed successfully."
        } else {
            Log-Output "EBP application $installer installation failed with exit code $($process.ExitCode)."
            exit $process.ExitCode
        }
    } else {
        Log-Output "EBP installer $installer not found at path: $installerPath"
    }
}

# Copy License XML
$licenseSource = Join-Path -Path $currentDirectory -ChildPath "license.xml"
$licenseDestination = "C:\ProgramData\ebp\license.xml"

if (Test-Path -Path $licenseSource) {
    Copy-Item -Path $licenseSource -Destination $licenseDestination -Force
    if ($LASTEXITCODE -ne 0) {
        Log-Output "Install Failed on : $env:COMPUTERNAME"
        exit $LASTEXITCODE
    } else {
        Log-Output "License file copied successfully."
    }
} else {
    Log-Output "License file not found: $licenseSource"
    exit 1
}

Log-Output "All EBP applications installed."