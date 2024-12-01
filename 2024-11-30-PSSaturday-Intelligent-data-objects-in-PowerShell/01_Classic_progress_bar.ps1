# We need something to iterate over
$files = Get-ChildItem -Path C:\Windows -File | Select-Object -First 5

# We need to initialize the progress bar
$progressParameter = @{ Activity = 'Processing files' }
$progressTotal = $files.Count
$progressCompleted = 0 
$progressStart = Get-Date

# Start the iteration
foreach ($file in $files) {
    # Set the values for the progress bar and display it
    $progressParameter.Status = "$progressCompleted of $progressTotal files processed"
    $progressParameter.CurrentOperation = "working on $($file.Name)"
    $progressParameter.PercentComplete = $progressCompleted * 100 / $progressTotal
    if ($progressParameter.PercentComplete -gt 0) {
        $progressParameter.SecondsRemaining = ((Get-Date) - $progressStart).TotalSeconds / $progressParameter.PercentComplete * (100 - $progressParameter.PercentComplete)
    }
    Write-Progress @progressParameter

    # Do some work
    Write-Host "Working on $($file.Name)"
    Start-Sleep -Seconds 2

    # Update the counter    
    $progressCompleted++
}

# Remove the progress bar
Write-Progress @progressParameter -Completed 
