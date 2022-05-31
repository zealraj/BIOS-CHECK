<#
Synopsis: The BIOS Version Check script will retrieve information about the current BIOS version of a computer system. System Administrators will use the script to identify systems with out of date BIOS images. Therefore, the script should be able to gather data on remote systems and generate a consolidated report.
Use Cases
• User specifies which remote computers to inspect
• User executes script to collect BIOS version information on remote computers
• User reads report on BIOS Versions for specified systems
Inputs
• The script should take a file with a computer name to be inspected on each line
Outputs
• The script should output a CSV file in the current directory that contains the BIOS version report
• Each row in the utilization report should include:
o Computer Name
o Manufacturer
o Model
o Serial Number
o BIOS Name
o BIOS System Major Version
o BIOS System Minor Version
o BIOS Release Date
*If no server in input file the script will generate local computer stats
#>

$InputFile="input.txt"
$outfile="Output.csv"

function Get-Stats {
    $Servers=Get-Content $InputFile
    if ($Servers -eq $null){
        $Bios=Get-CIMInstance -ClassName Win32_BIOS
        $ComputerInfo=Get-CIMInstance -ClassName Win32_ComputerSystem
        Write-to-CSV
    }
    else {
        foreach ( $Server in $Servers ){
            $Bios=Get-CIMInstance -ClassName Win32_BIOS -ComputerName $Server
            $ComputerInfo=Get-CIMInstance -ClassName Win32_ComputerSystem -ComputerName $Server
            Write-to-CSV
        }
    }
}
function Write-to-CSV{
    $out=New-Object PSObject
    $out | Add-Member -MemberType NoteProperty -Name "Servername" -Value $ComputerInfo.Name
    $out | Add-Member -MemberType NoteProperty -Name "Manufacturer" -Value $ComputerInfo.Manufacturer
    $out | Add-Member -MemberType NoteProperty -Name "Model" -Value $ComputerInfo.Model
    $out | Add-Member -MemberType NoteProperty -Name "SerialNUmber" -Value $Bios.SerialNumber
    $out | Add-Member -MemberType NoteProperty -Name "BIOSName" -Value $Bios.Name
    $out | Add-Member -MemberType NoteProperty -Name "BIOSSysMajorVersion" -Value $Bios.EmbeddedControllerMajorVersion
    $out | Add-Member -MemberType NoteProperty -Name "BIOSSysMinorVersion" -Value $Bios.EmbeddedControllerMinorVersion
    $out | Add-Member -MemberType NoteProperty -Name "BIOSReleaseDate" -Value $Bios.ReleaseDate
    $out |Select-Object -Property * | export-csv -path $outfile -force -NoTypeInformation 



}


try{
    Get-Stats
}
catch {
write-host "Exception is $_"
}




