const { v4: uuidv4 } = require('uuid');
const bcrypt = require('bcryptjs');

module.exports = {
    up: async (queryInterface, Sequelize) => {
        return queryInterface.bulkInsert('users', [
            {
                id : Sequelize.literal('gen_random_uuid()'),
                name: 'Chia',
                email: 'chia@gmail.com',
                group_id: 1,
                password_hash: bcrypt.hashSync('123456', 8),
                created_at: new Date(),
                updated_at: new Date(),
            },
            {
                id : Sequelize.literal('gen_random_uuid()'),
                name: 'Jose',
                email: 'jose@gmail.com',
                group_id: 1,
                password_hash: bcrypt.hashSync('123456', 8),
                created_at: new Date(),
                updated_at: new Date(),
            },
            {
                id : Sequelize.literal('gen_random_uuid()'),
                name: 'Louis',
                email: 'louis@gmail.com',
                group_id: 1,
                password_hash: bcrypt.hashSync('123456', 8),
                created_at: new Date(),
                updated_at: new Date(),
            },
            {
                id : Sequelize.literal('gen_random_uuid()'),
                name: 'Hany',
                email: 'hany@gmail.com',
                group_id: 1,
                password_hash: bcrypt.hashSync('123456', 8),
                created_at: new Date(),
                updated_at: new Date(),
            },
            {
                id : Sequelize.literal('gen_random_uuid()'),
                name: 'Marshia',
                email: 'marshia@gmail.com',
                group_id: 1,
                password_hash: bcrypt.hashSync('123456', 8),
                created_at: new Date(),
                updated_at: new Date(),
            },
            {
                id : Sequelize.literal('gen_random_uuid()'),
                name: 'Raissa',
                email: 'raissa@gmail.com',
                group_id: 1,
                password_hash: bcrypt.hashSync('123456', 8),
                created_at: new Date(),
                updated_at: new Date(),
            },
        ]);
    },

    down: async (queryInterface, Sequelize) => {
        return queryInterface.bulkDelete('users', null, {});
    },
};
