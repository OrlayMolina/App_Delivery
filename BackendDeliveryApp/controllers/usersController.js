const User = require('../models/user');

module.exports = {

    register(req, res){

        // Capturó lo datos que me envie el cliente.
        const user = req.body;
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