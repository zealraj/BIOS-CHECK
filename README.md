# BIOS-CHECK
This powershell script will help to check the local BIOS information of your computer and also for the numbers of servers you wanted to 





BIOS INFO -SCRIPT WALK THROUGH
•	Line number 1 to 21 are part of script synopsis. It is a detailed information about how the script works. How it must be run. What input it will accept and what will be the output.
•	Line 23: $InputFile -> This is a variable to store the full path / relative path to input file. If you want, you can change the value of path according to your preference.
Example: At present vaue is $InputFile = “input.txt”. Bit if you want the script to read an input.txt from your desktop folder then you can assign it a value like:
$InputFile=”c:\users\16474\Desktop\input.txt”.
If you want that, this file should contains servernames , one server name in one line. If 2 servers then write them in 2 lines , 3 in 3 and so on.
•	Line 24: $outfile="Output.csv": This file contains output in the format instructed.
•	Line 27: $Servers=Get-Content $InputFile: This line reads your input.txt file and assigns it to a variable called $servers
•	Line 28 if ($Servers -eq $null) : This line to check if input file is empty then it will print stats for your local host otherwise it will print stats for remote servers.
•	Line 29 and 30 make use of CIM class cmdlet to get the BIOS and system information about a computer.
•	Line 34  foreach ( $Server in $Servers ) : This line will execute When input.txt file is not empty. This will read names of servers from input.txt one by one and get stats for them.
•	Line 42 $out=New-Object PSObject : Create a new output variable called $out.
•	Line 43 to 50 -> These lines are adding attributes to output object.
•	Line 51 adds the $out object to csv file.
•	Line 59 : It calls the function we created in line 26.
