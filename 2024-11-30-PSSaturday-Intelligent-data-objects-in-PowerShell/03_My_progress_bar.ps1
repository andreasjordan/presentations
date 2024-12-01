# We need something to iterate over
$files = Get-ChildItem -Path C:\Windows -File | Select-Object -First 5

# We need to initialize the progress bar
$progress = New-MyProgress -Activity 'Processing files' -Total $files.Count

# Start the iteration
foreach ($file in $files) {
    # Set the values for the progress bar and display it
    $progress.Status = "$($progress.ItemsCompleted) of $($progress.ItemsTotal) files processed"
    $progress.CurrentOperation = "working on $($file.Name)"
    $progress.Write()

    # Do some work
    Write-Host "Working on $($file.Name)"
    Start-Sleep -Seconds 2

    # Update the counter    
    $progress.ItemsCompleted++
}

# Remove the progress bar
$progress.Completed()
