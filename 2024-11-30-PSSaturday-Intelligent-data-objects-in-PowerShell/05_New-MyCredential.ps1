function New-MyCredential {
    param(
        [string]$Message,
        [string]$UserName,
        [securestring]$SecurePassword,
        [string]$KeepassUrl
    )
    
    if (-not $Message) {
        $Message = "Password for [$UserName]"
    }

    if (-not $SecurePassword) {
        $credential = Get-Credential -Message $Message -UserName $UserName

        $UserName = $credential.UserName
        $SecurePassword = $credential.Password
    }

    if ([System.Net.NetworkCredential]::new('', $SecurePassword).Password.Length -eq 0) {
        $SecurePassword = ConvertTo-SecureString -String '<Insert the code to get a long random password here>' -AsPlainText -Force
    }

    $object = [PSCustomObject]@{
        PSTypeName     = $MyInvocation.MyCommand.Noun
        UserName       = $UserName
        SecurePassword = $SecurePassword
        KeepassUrl     = $KeepassUrl
    }

    Add-Member -InputObject $object -MemberType ScriptProperty -Name Password -Value {
        [System.Net.NetworkCredential]::new('', $this.SecurePassword).Password
    }

    Add-Member -InputObject $object -MemberType ScriptProperty -Name Credential -Value {
        [PSCredential]::new($this.UserName, $this.SecurePassword)
    }

    Add-Member -InputObject $object -MemberType ScriptMethod -Name SetToKeepass -Value {
        if ($this.KeepassUrl.Length -gt 0) {
            Write-Host "Will set $($this.UserName) on $($this.KeepassUrl)"
        } else {
            throw "KeepassUrl is not set"
        }
    }

    Update-TypeData -TypeName $MyInvocation.MyCommand.Noun -DefaultDisplayPropertySet UserName, KeepassUrl -Force
    
    $object
}
