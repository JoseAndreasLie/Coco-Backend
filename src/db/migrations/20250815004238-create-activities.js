'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('activities', {
            id: {
                autoIncrement: true,
                primaryKey: true,
                type: Sequelize.INTEGER,
            },
            title: {
                type: Sequelize.STRING,
            },
            description: {
                type: Sequelize.TEXT,
            },
            category_id: {
                type: Sequelize.INTEGER,
                reference: {
                    model: 'categories',
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            destination_id: {
                type: Sequelize.INTEGER,
                references: {
                    model: 'destinations',
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            duration_minutes: {
                type: Sequelize.INTEGER,
            },
            pricing: {
                type: Sequelize.DECIMAL,
            },
            accessory_ids: {
                type: Sequelize.ARRAY(Sequelize.INTEGER),
            },
            cancelable: {
                type: Sequelize.TEXT,
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
                allowNull: true,
                type: Sequelize.DATE,
            },
        });
    },
    async down(queryInterface, Sequelize) {
        await queryInterface.dropTable('activities');
    },
};
