### SET FOLDER TO WATCH
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = "D:\source"
    $watcher.Filter = "*.txt*"
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true  

### EVENT LOG FOR ACTIONS
    $action = { $path = $Event.SourceEventArgs.FullPath
                $changeType = $Event.SourceEventArgs.ChangeType
                $logline = "$(Get-Date), $changeType, $path"
                Add-content "D:\log.txt" -value $logline
              }    
### EVENTS 
    Register-ObjectEvent $watcher "Created" -Action $action
    Register-ObjectEvent $watcher "Changed" -Action $action
    Register-ObjectEvent $watcher "Deleted" -Action $action
    Register-ObjectEvent $watcher "Renamed" -Action $action
    while ($true) {sleep 5}