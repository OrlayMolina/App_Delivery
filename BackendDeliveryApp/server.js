const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const logger = require('morgan');
const cors = require('cors');

const port = process.env.PORT || 3000;
app.set('port', port);

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({
    extended : true,
}));

app.use(cors());

app.disable('x.powered-by');

// Verificar la ip con ipconfig
server.listen(3000, '192.168.1.3' || 'localhost', function(){
    console.log( 'Aplicación de NodeJS en el puerto ' + port );
});

app.get('/', (req, res) => {
    res.send('Ruta raíz del backend');
});

// Error Handler
app.use((err, req, res, next) => {
    console.log(err);
    res.status(err.status || 500).send(err.stack);
});