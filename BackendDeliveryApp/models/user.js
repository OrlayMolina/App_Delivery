const db = require('../config/config');

const User = {};

User.create = (user, result) => {
    const { email, name, lastname, phone, image, password } = user; // Destructuración del objeto user

    const sql = `
        INSERT INTO users(email, name, lastname, phone, image, password, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `;

    db.query(sql, [email, name, lastname, phone, image, password, new Date(), new Date()], (err, res) => {
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