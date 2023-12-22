const User = require('../models/user');
const Rol = require('../models/rol');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const keys = require('../config/keys');
const storage = require('../utils/cloud_storage');

module.exports = {

    login(req, res) {
        
        const email = req.body.email;
        const password = req.body.password;

        User.findByEmail(email, async (err, myUser) => {

            console.log('Error ', err);
            console.log('Usuario ', myUser);

            if(err){
                return res.status(501).json({
                    success : false,
                    message : 'Hubo un error con el email del usuario',
                    error : err
                });
            }

            if(!myUser){
                return res.status(401).json({ /// No aurizado (401).
                    success : false,
                    message : 'El email no fue encontrado'
                });
            }

            const isPasswordValid = await bcrypt.compare(password, myUser.password);


            if(isPasswordValid){
                const token = jwt.sign({id : myUser.id, email : myUser.email}, keys.secretOrKey,{});

                const data = {
                    id: `${myUser.id}`,
                    name: myUser.name,
                    lastname: myUser.lastname,
                    email: myUser.email,
                    phone: myUser.phone,
                    image: myUser.image,
                    session_token: `JWT ${token}`,
                    roles: JSON.parse(myUser.roles)
                }

                console.log('info aquí ');
                console.log(data);

                return res.status(201).json({
                    success : true,
                    message : 'El usuario fue autenticado correctamente',
                    data : data // El ID del nuevo usuario que se registró.
                });
            }else {
                return res.status(401).json({ /// No aurizado (401).
                    success : false,
                    message : 'La contraseña es incorrecta'
                });
            }

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
    },

    async registerWithImage(req, res){

        // Capturó lo datos que me envie el cliente.
        const user = JSON.parse(req.body.user);

        // Archivos que se subieron al servidor.
        const files = req.files;

        if(files.length > 0){
            const path = `image_${Date.now()}`;
            const url = await storage(files[0], path);

            if(url != undefined || url != null){
                user.image = url;
            }
        }

        User.create(user, (err, data) => {

            if(err){
                return res.status(501).json({
                    success : false,
                    message : 'Hubo un error con el registro del usuario',
                    error : err
                });
            }

            user.id = `${data}`;
            const token = jwt.sign({id: user.id, email: user.email}, keys.secretOrKey,{});
            user.session_token = `JWT ${token}`;

            Rol.create(user.id, 3, (err, data) => {

                if(err){
                    return res.status(501).json({
                        success : false,
                        message : 'Hubo un error con el registro de rol de usuario',
                        error : err
                    });
                }

                return res.status(201).json({
                    success : true,
                    message : 'El registro se realizó correctamente',
                    data : user // El ID del nuevo usuario que se registró.
                });
            });
            
        });
    }
}