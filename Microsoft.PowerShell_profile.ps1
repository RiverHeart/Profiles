# Overrides default behaviour of the Powershell prompt
# Reference: get-help about_prompt
function prompt {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    $userIsAdmin = $principal.isInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

    if ($userIsAdmin) { write-host "[ADMIN] " -ForeGround Red -NoNewLine }

    write-host "Powershell >>" -ForeGround Green -NoNewLine
    $host.ui.rawui.windowtitle = Get-Location
    return ' '  # Return space in place of PS>
}

function Get-Uptime {
    return (	
        (Get-Date)-(Get-CimInstance Win32_OperatingSystem).lastbootuptime
    )
}

import-module cowsay
$env:fortune = "~\Documents\WindowsPowershell\modules\cowsay\fortunes.txt"
fortune | cowsay
