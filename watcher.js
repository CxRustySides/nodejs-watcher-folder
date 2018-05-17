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