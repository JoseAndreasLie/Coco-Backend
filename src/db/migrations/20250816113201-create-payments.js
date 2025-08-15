'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('payments', {
            id: {
                allowNull: false,
                autoIncrement: true,
                primaryKey: true,
                type: Sequelize.INTEGER,
            },
            booking_id: {
                type: Sequelize.INTEGER,
                references: {
                    model: 'bookings',
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            group_id: {
                type: Sequelize.INTEGER,
                references: {
                    model: 'groups',
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            payment_method: {
                type: Sequelize.STRING,
            },
            billing_address: {
                type: Sequelize.STRING,
            },
            amount: {
                type: Sequelize.DECIMAL,
            },
            tax: {
                type: Sequelize.DECIMAL,
            },
            total: {
                type: Sequelize.DECIMAL,
            },
            status: {
                type: Sequelize.STRING,
            },
            created_at: {
                allowNull: false,
                type: Sequelize.DATE,
            },
            updated_at: {
                allowNull: false,
                type: Sequelize.DATE,
            },
            deleted_at: {
                allowNull: true,
                type: Sequelize.DATE,
            },
        });
    },
    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('payments');
    },
};
