function New-MyProgress {
    param(
        [string]$Activity,
        [int]$Total
    )

    $object = [PSCustomObject]@{
		PSTypeName       = $MyInvocation.MyCommand.Noun
        Id               = Get-Random
        Activity         = $Activity
        Status           = $null
        CurrentOperation = $null
        StartDate        = [datetime]::Now
        EndDate          = $null
        ItemsTotal       = $Total
        ItemsCompleted   = 0
    }

    Add-Member -InputObject $object -MemberType ScriptProperty -Name PercentComplete -Value {
        $this.ItemsCompleted * 100 / $this.ItemsTotal
    }

    Add-Member -InputObject $object -MemberType ScriptProperty -Name SecondsRemaining -Value {
        if ($this.PercentComplete -gt 0 -and $this.PercentComplete -lt 100) {
            ([datetime]::Now - $this.StartDate).TotalSeconds / $this.PercentComplete * (100 - $this.PercentComplete)
        }
    }

    Add-Member -InputObject $object -MemberType ScriptProperty -Name Duration -Value {
        if ($null -eq $this.EndDate) {
            [datetime]::Now - $this.StartDate
        } else {
            $this.EndDate - $this.StartDate
        }
    }

    Add-Member -InputObject $object -MemberType ScriptMethod -Name Write -Value {
        param(
            [string]$Status,
            [string]$CurrentOperation,
            [bool]$IncreaseItemsCompleted
        )

        if ($Status.Length -gt 0) {
            $this.Status = $Status
        }
        if ($CurrentOperation.Length -gt 0) {
            $this.CurrentOperation = $CurrentOperation
        }

        $progressParams = @{
            Id       = $this.Id
            Activity = $this.Activity
        }
        if ($null -ne $this.Status) {
            $progressParams.Status = $this.Status
        }
        if ($null -ne $this.CurrentOperation) {
            $progressParams.CurrentOperation = $this.CurrentOperation
        }
        if ($null -ne $this.PercentComplete) {
            $progressParams.PercentComplete = $this.PercentComplete
        }
        if ($null -ne $this.SecondsRemaining) {
            $progressParams.SecondsRemaining = $this.SecondsRemaining
        }
        Write-Progress @progressParams

        if ($IncreaseItemsCompleted) {
            $this.ItemsCompleted++
        }
    }

    Add-Member -InputObject $object -MemberType ScriptMethod -Name Completed -Value {
        $this.EndDate = [datetime]::Now
        Write-Progress -Id $this.Id -Activity $this.Activity -Completed
    }

    Update-TypeData -TypeName $MyInvocation.MyCommand.Noun -DefaultDisplayPropertySet Activity, Status, CurrentOperation, PercentComplete, SecondsRemaining -Force

    $object
}
