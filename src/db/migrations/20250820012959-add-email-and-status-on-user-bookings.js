'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    const transaction = await queryInterface.sequelize.transaction();
    try{
      await queryInterface.addColumn(
        'user_bookings',
        'email',
        {
          type: Sequelize.DataTypes.STRING,
        },

        {transaction},
      );

      await queryInterface.addColumn(
        'user_bookings',
        'status',
        {
          type: Sequelize.DataTypes.STRING,
        },

        {transaction},
      );
      await transaction.commit();
    } catch (e) {
      await transaction.rollback();
      throw e;
    }
  },

  async down (queryInterface, Sequelize) {
    const transaction = await queryInterface.sequelize.transaction();
    try {
      await queryInterface.removeColumn('user_bookings', 'email', {transaction});
      await queryInterface.removeColumn('user_bookings', 'status', {transaction});
      await transaction.commit();
    } catch (e) {
      await transaction.rollback();
      throw(e);
    }
  }
};
