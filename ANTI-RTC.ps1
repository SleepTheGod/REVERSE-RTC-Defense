######################################################################################
                   We went through hell and back to get to here
######################################################################################
#Script Name      : ANTI-RTC.ps1
#Description      : Real-Time Communication Protocol Defense
#Type             : PowerShell
#Author           : Arya Ebrahami & Taylor Christian Newsome
#Contact          : Twitter OracleLuvsYou | Twitter ClumsyLulz
######################################################################################
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

$attackerIP = $null

while ($true) {
    try {
        $result = Test-NetConnection -ComputerName $communicationServer -InformationLevel Quiet

        if ($result) {
            Write-Host "Reverse RTC No Attack I am now safe brrr."
        } else {
            $attackerIP = (Test-NetConnection -ComputerName $communicationServer -InformationLevel Detailed).RemoteAddress
            Write-Host "Connection interrupted. Possible attack from IP: $attackerIP"
            $geolocation = (Invoke-RestMethod -Uri "https://ipinfo.io/$attackerIP/json")
            Write-Host "Attacker's IP Geolocation: $($geolocation.city), $($geolocation.region), $($geolocation.country)"
            # Log the attacker's IP address and geolocation for further analysis and response.
            # Consider using security incident and event management (SIEM) tools for centralized logging and analysis.
        }
    } catch {
        Write-Host "Error testing connection: $_"
        # Add error handling code if necessary
    }
######################################################################################

    Start-Sleep -Seconds 10
}
######################################################################################

######################################################################################
