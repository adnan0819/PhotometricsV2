var express = require('express'),
    app = express();
var fs = require('fs');
var http = require('http').Server(app);
var io = require('socket.io')(http);

app.use(express.static(__dirname + '/'));


app.get('/images/:id', function(req, res) {
    var imageId = parseInt(req.params.id);
    var data = {};
    for (var i=0,len=images.length;i<len;i++) {
        if (images[i].id === imageId) {
           data = images[i];
           break;
        }
    }  
    res.json(data);
});

app.get('/images', function(req, res) {
    res.json(images);
    //res.json(500, { error: 'An error has occurred!' });
});

io.on('connection', function(socket) {
    fs.watch('./', function (event, filename) {
        fs.readFile('./results.json', function( err, data) {
            if(!err) {
                try {
                    var x = JSON.parse(data);
                    socket.emit('updated', x);
                } catch (err) {
                    console.log('data error');
                }
            } 
       });
   }); 
});

http.listen(8080, function(){
    console.log('App listening on port 8080');
});

var images = require('./images.json');