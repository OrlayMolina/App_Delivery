const User = require('../models/user');

module.exports = {

    login(req, res) {
        
        const email = req.body.email;
        const password = req.body.password;

        User.findByEmail(email, (err, data) => {

            if(err){
                return res.status(501).json({
                    success : false,
                    message : 'Hubo un error con el email del usuario',
                    error : err
                });
            }

            if(!data){
                return res.status(401).json({ /// No aurizado (401).
                    success : false,
                    message : 'El email no fue encontrado'
                });
            }

            return res.status(201).json({
                success : true,
                message : 'El registro se encontró correctamente',
                data : data // El ID del nuevo usuario que se registró.
            });
        });
    },

    register(req, res){

        // Capturó lo datos que me envie el cliente.
        const user = req.body;
        console.log(user);
        User.create(user, (err, data) => {

            if(err){
                return res.status(501).json({
                    success : false,
                    message : 'Hubo un error con el registro del usuario',
                    error : err
                });
            }

            return res.status(201).json({
                success : true,
                message : 'El registro se realizó correctamente',
                data : data // El ID del nuevo usuario que se registró.
            });
        });
    }
}