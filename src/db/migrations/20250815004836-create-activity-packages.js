'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('activity_packages', {
            id: {
                allowNull: false,
                autoIncrement: true,
                primaryKey: true,
                type: Sequelize.INTEGER,
            },
            activity_id: {
                type: Sequelize.INTEGER,
                references: {
                    model: 'activities',
                    key: 'id'
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE'
            },
            name: {
                type: Sequelize.STRING,
            },
            description: {
                type: Sequelize.STRING,
            },
            price_per_person: {
                type: Sequelize.DECIMAL,
            },
            min_participants: {
                type: Sequelize.INTEGER,
            },
            max_participant: {
                type: Sequelize.INTEGER,
            },
            start_time: {
                type: Sequelize.TIME,
            },
            end_time: {
                type: Sequelize.TIME,
            },
            host_id: {
                type: Sequelize.INTEGER,
                references: {
                    model: 'hosts',
                    key: 'id'
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE'
            },
            address: {
                type: Sequelize.STRING,
            },
            image_url: {
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
        await queryInterface.dropTable('activity_packages');
    },
};
