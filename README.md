# EBP Application Installation Scripts

This repository contains scripts to automate the installation of SQL Server 2019 Express and multiple EBP applications. The installation process is divided into three main steps, each executed by a batch script.

## Prerequisites

- Download the complete ZIP file from the repository.
- Ensure that the following files are present and decompressed in the same directory:
  - `1-install.bat`
  - `2-instance.bat`
  - `3-ebp.bat`
  - `install-SQL-1.ps1`
  - `instance-ebp-2.ps1`
  - `install-EBP-3.ps1`
  - `SQL2019-SSEI-Expr.exe`
  - The 7 EBP application executables:
    - `EBP_2024_Comptabilite_ELITE_23_6_0_11594.exe`
    - `EBP_2024_Etats_Financiers_PRO_23_3_0_4261.exe`
    - `EBP_2024_Gestion_ELITE_23_1_1_9182.exe`
    - `EBP_2024_Immobilisations_ELITE_23_2_0_4002.exe`
    - `EBPOL_2022_Classic_BusinessPlan_14_0_0_2005.exe`
    - `EBPOL_2024_Autonome_Paie_13_28_4_14901.exe`
    - `EBPOL_2024_CRM_ELITE_16_0_0_1312.exe`

## Installation Steps

Follow these steps to install SQL Server 2019 Express and the EBP applications:

### Step 1: Install SQL Server 2019 Express

Run the first batch script to install SQL Server 2019 Express.

```
.\1-install.bat
```
This script will execute install-SQL-1.ps1 to install SQL Server 2019 Express using SQL2019-SSEI-Expr.exe.

### Step 2: Install SQL Server Instance

Run the second batch script to configure the SQL Server instance.
```
.\2-instance.bat
```
This script will execute instance-ebp-2.ps1 to set up the necessary SQL Server instance.

### Step 3: Install EBP Applications

Run the third batch script to install all 7 EBP applications.
```
.\3-ebp.bat
```
This script will execute install-EBP-3.ps1 to sequentially install each EBP application and confirm successful installation.

Notes

	•	Make sure to run each script in the correct order: 1-install.bat, 2-instance.bat, and 3-ebp.bat.
	•	Ensure you have administrative privileges when running these scripts.
	•	If you encounter any issues during the installation, check the logs or output messages for more details.
