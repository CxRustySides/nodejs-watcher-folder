### Node.js - Watching changes (created, deleted, changed )  in Windows folder on network with chokidar.

####1. Installation

Install Node.js
https://nodejs.org/en/download/

Install chokidar:
https://github.com/paulmillr/chokidar

Opens terminal windows and execute:

``
$npm install chokidar --save
``

####2. Map a network drive in Windows

Specify the drive letter for the connection and the folder that you want to connect.
Example:

``
Shared (\\W-LNIELSEN\Users\leslie.nielsen\Desktop\Temp\2018)(Z:)
``

####3. watcher.js

**Add the usePolling: true option to watch network folders.**

```javascript
var chokidar = require('chokidar');

var fs = require('fs');

var log_file = fs.createWriteStream(__dirname + '/watch.log', {flags : 'w'});

try
  {
        var watcher = chokidar.watch('D:\\folderToWatch',
        {
                    ignored: /^\./,
                    persistent: true,
                    usePolling: true,
        });
        watcher.on('add', function(path) 
         {
                log_file.write(path+'\n');
          })
          .on('change', function(path) 
          {
                      console.log('File', path, 'has been changed');
          })
          .on('unlink', function(path) {
                  console.log('File', path, 'has been removed');
          })
          .on('error', function(error) {
                  console.error('Error happened', error);
         })
} 
catch (err)
{
        console.error('Error happened', error);
}
```

####4. Running the watcher:

``
$node watcher.js
``

Add files or folders to remote path:
``Shared (\\W-LNIELSEN\Users\leslie.nielsen\Desktop\Temp\2018)(Z:)`` and check if log watch.log tracked these files.

<img src="https://image.ibb.co/g1T90d/watcher_node01.jpg" alt="watcher_node01" border="0"></a>