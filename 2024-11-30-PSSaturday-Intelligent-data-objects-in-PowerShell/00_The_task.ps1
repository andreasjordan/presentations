# We need something to iterate over
$files = Get-ChildItem -Path C:\Windows -File | Select-Object -First 5

# Start the iteration
foreach ($file in $files) {

    # Do some work
    Write-Host "Working on $($file.Name)"
    Start-Sleep -Seconds 2
    
}
