const Category = require('../models/category');


module.exports = {
    create(req, res) {

        const category = req.body;

        Category.create(category, (err, id) => {

            if(err){
                return res.status(501).json({
                    success : false,
                    message : 'Hubo un error al crear la categoria',
                    error : err
                });
            }

            return res.status(201).json({
                success : true,
                message : 'La categoria se creó correctamente',
                data : `${id}` // El ID de la nueva categoria.
            });
        });
    },

    getAll(req, res) {
        Category.getAll((err, data) => {

            if(err){
                return res.status(501).json({
                    success : false,
                    message : 'Hubo un error al listar las categorias',
                    error : err
                });
            }

            return res.status(201).json(data);
        });
    }
};