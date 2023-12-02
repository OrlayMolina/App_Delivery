const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const logger = require('morgan');
const cors = require('cors');
const bodyparser = require('body-parser');
const passport = require('passport');

require('dotenv').config();

/**
 * Middleware de análisis de cuerpos
 */
app.use(express.json()); // Analiza application/json
app.use(express.urlencoded({ extended: true }));


/**
 * Importar rutas
 */
const userRoutes = require('./routes/userRoutes');

const port = process.env.PORT || 3000;
app.set('port', port);

/**
 * 
 */
userRoutes(app);

app.use(logger('dev'));

app.use(cors());
app.use(passport.initialize());
app.use(passport.session());

require('./config/passport')(passport);

app.disable('x.powered-by');

// Verificar la ip con ipconfig
server.listen(3000, '192.168.1.3' || 'localhost', function(){
    console.log( 'Aplicación de NodeJS en el puerto ' + port );
});

app.get('/', (req, res) => {
    res.send('Ruta raíz del backend');
});

app.get('/test', (req, res) => {
    res.send('Ruta de testeo');
});

// Error Handler
app.use((err, req, res, next) => {
    console.log(err);
    res.status(err.status || 500).send(err.stack);
});