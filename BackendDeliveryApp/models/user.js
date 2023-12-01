const db = require('../config/config');
const bcrypt = require('bcryptjs'); 

const User = {};

User.create = async (user, result) => {
    const { email, name, lastname, phone, image, password } = user; // Destructuración del objeto user

    const hash = await bcrypt.hash(password, 10)

    const sql = `
        INSERT INTO users(email, name, lastname, phone, image, password, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `;

    db.query(
        sql, 
        [
            email, 
            name, 
            lastname, 
            phone, 
            image, 
            hash, 
            new Date(), 
            new Date()
        ], 
        (err, res) => {
        if (err) {
            console.log('Error: ', err);
            result(err, null);
        } else {
            console.log('Id del nuevo usuario: ', res.insertId);
            result(null, res.insertId);
        }
    });
};

module.exports = User;