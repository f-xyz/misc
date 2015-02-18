fs = require('fs')

fs.createReadStream('usage.txt').pipe(process.stdout)