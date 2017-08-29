const fs = require('fs');

if (process.argv.length < 3) {
  console.log("Please Provide Input file!");
  process.exit();
}

var file = process.argv[2];
var content = fs.readFileSync(file, 'utf8').split('\n');;


content.forEach(function(item, index, array) {
  console.log(item);
  var hot = item.replace(/^[ ]*\.text/, '$&' + '.hot');
  console.log(hot);
});

