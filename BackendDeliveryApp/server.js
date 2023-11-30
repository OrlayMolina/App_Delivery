const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);

const port = process.env.PORT || 3000;
app.set('port', port);

// Verificar la ip con ipconfig
server.listen(3000, '192.168.1.3' || 'localhost', function(){
    console.log( 'Aplicación de NodeJS en el puerto ' + port );
});