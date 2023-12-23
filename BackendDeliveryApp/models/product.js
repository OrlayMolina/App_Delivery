const db = require('../config/config');

const Product = {};

Product.create = (product, result) => {

    const sql = `
    INSERT INTO 
        products(
            name, 
            description, 
            price, 
            imagen1, 
            imagen2, 
            imagen3, 
            id_category, 
            created_at, 
            updated_at
        )
    VALUES(?, ?, ?, ?,?, ?, ?, ?, ?)
    `;

    db.query(
        sql,
        [
            product.name,
            product.description,
            product.price,
            product.imagen1,
            product.imagen2,
            product.imagen3,
            product.id_category,
            new Date(),
            new Date()
        ],
        (err, res) => {
            if (err) {
                console.log('Error: ', err);
                result(err, null);
            } else {
                console.log('Id del nuevo producto: ', res.insertId);
                result(null, res.insertId);
            }
        }
    );
}

Product.update = (product, result) => {

    const sql = `
    UPDATE
        products
    SET
        name = ?,
        description = ?,
        price = ?,
        imagen1 = ?,
        imagen2 = ?,
        imagen3 = ?,
        id_category = ?,
        updated_at = ?
    WHERE
        id = ?
    `;

    db.query(
        sql,
        [
            product.name,
            product.description,
            product.price,
            product.imagen1,
            product.imagen2,
            product.imagen3,
            product.id_category,
            new Date(),
            product.id
        ],
        (err, res) => {
            if (err) {
                console.log('Error: ', err);
                result(err, null);
            } else {
                console.log('Id del producto actualizado: ', product.id);
                result(null, product.id);
            }
        }
    );
}

module.exports = Product;