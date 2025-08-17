'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
    async up(queryInterface, Sequelize) {
        await queryInterface.createTable('activity_availabilities', {
            id: {
                autoIncrement: true,
                primaryKey: true,
                type: Sequelize.INTEGER,
            },
            activity_package_id: {
                type: Sequelize.INTEGER,
                references: {
                    model: 'activity_packages',
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            date: {
                type: Sequelize.DATE,
            },
            start_time: {
                type: Sequelize.TIME,
            },
            end_time: {
                type: Sequelize.TIME,
            },
            available_slots: {
                type: Sequelize.INTEGER,
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
        await queryInterface.dropTable('activity_availabilities');
    },
};
