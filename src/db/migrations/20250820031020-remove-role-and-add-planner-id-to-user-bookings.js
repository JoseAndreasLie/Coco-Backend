'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    const transaction = await queryInterface.sequelize.transaction();
    try{
      await queryInterface.addColumn(
        'user_bookings',
        'planner_id',
        {
          type: Sequelize.DataTypes.UUID,
          references: {
            model: 'users',
            key: 'id'
          },
          onUpdate: 'CASCADE',
          onDelete: 'CASCADE'
        },

        {transaction},
      );
      await queryInterface.removeColumn('user_bookings', 'role', {transaction});
      await transaction.commit();
    } catch (e) {
      await transaction.rollback();
      throw e;
    }
  },

  async down (queryInterface, Sequelize) {
    const transaction = await queryInterface.sequelize.transaction();
    try{
      await queryInterface.addColumn(
        'user_bookings',
        'role',
        {
          type: Sequelize.DataTypes.STRING,
        },

        {transaction},
      );
      await queryInterface.removeColumn('user_bookings', 'planner_id', {transaction});
      await transaction.commit();
    } catch (e) {
      await transaction.rollback();
      throw e;
    }
  }
};
