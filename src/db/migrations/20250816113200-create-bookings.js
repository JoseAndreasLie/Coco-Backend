'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('bookings', {
            id: {
                autoIncrement: true,
                primaryKey: true,
                type: Sequelize.INTEGER,
            },
            user_id: {
                type: Sequelize.UUID,
                references: {
                    model: 'users',
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            availability_id: {
                type: Sequelize.INTEGER,
                references: {
                    model: 'activity_availabilities',
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            participants: {
                type: Sequelize.INTEGER,
            },
            total_price: {
                type: Sequelize.DECIMAL,
            },
            status: {
                type: Sequelize.STRING,
            },
            created_at: {
                type: Sequelize.DATE,

                defaultValue: Sequelize.NOW,
            },
            updated_at: {
                type: Sequelize.DATE,

                defaultValue: Sequelize.NOW,
            },
            deleted_at: {
                type: Sequelize.DATE,
                allowNull: true,
            },
        });
    },
    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('bookings');
    },
};
