# We need something to iterate over
$files = Get-ChildItem -Path C:\Windows -File | Select-Object -First 5

# We need to initialize the progress bar
$progress = New-MyProgress -Activity 'Processing files' -Total $files.Count

# Start the iteration
foreach ($file in $files) {
    # Set the values for the progress bar, display it and update the counter
    $progress.Write("$($progress.ItemsCompleted) of $($progress.ItemsTotal) files processed", "working on $($file.Name)", $true)

    # Do some work
    Write-Host "Working on $($file.Name)"
    Start-Sleep -Seconds 2
}

# Remove the progress bar
$progress.Completed()
