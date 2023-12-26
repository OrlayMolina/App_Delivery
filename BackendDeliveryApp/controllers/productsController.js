const Product = require('../models/product');
const storage = require('../utils/cloud_storage');
const asyncForEach = require('../utils/async_foreach');

module.exports = {

    findByCategory(req, res) {
        const id_category = req.params.id_category;
        Product.findByCategory(id_category, (err, data) => {

            if(err){
                return res.status(501).json({
                    success : false,
                    message : 'Hubo un error al listar los productos de la categoria',
                    error : err
                });
            }

            return res.status(201).json(data);
        });
    },

    create(req, res) {

        // Capturó lo datos que me envie el cliente.
        const product = JSON.parse(req.body.product);

        // Archivos que se subieron al servidor.
        const files = req.files;

        // Cuenta cuantas imagenes se subieron al servidor.
        let inserts =0;

        if(files.length === 0){
            return res.status(501).json({
                success : false,
                message : 'Hubo un error con la creación del producto, no tiene imágenes'
            });
        }else {

            Product.create(product, (err, id_product) => {

                if(err){
                    return res.status(501).json({
                        success : false,
                        message : 'Hubo un error con la creación del producto',
                        error : err
                    });
                }

                product.id = id_product;

                const start = async () => {
                    await asyncForEach(files, async (file) => {

                        const path = `image_${Date.now()}`;
                        const url = await storage(file, path);

                        if(url != undefined || url != null){// Se creo l imagen en Firebase

                            if(inserts === 0){// imagen 1
                                product.image1 = url;
                            }else if (inserts === 1){// imagen 2
                                product.image2 = url;
                            }else if (inserts === 2){// imagen 3
                                product.image3 = url;
                            }
                        }

                        await Product.update(product, (err, data) => {

                            if(err){
                                return res.status(501).json({
                                    success : false,
                                    message : 'Hubo un error con la creación del producto',
                                    error : err
                                });
                            }

                            inserts++;

                            if(inserts == files.length){// Termino de subir las imagenes
                                return res.status(201).json({
                                    success : true,
                                    message : 'El producto se creó correctamente',
                                    data : data // El ID del nuevo producto que se registró.
                                });
                            }
                        });
                    });
                }

                start();
                
            });
        }

    }
};