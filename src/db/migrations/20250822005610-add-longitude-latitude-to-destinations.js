'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    const transaction = await queryInterface.sequelize.transaction();
    try{
      await queryInterface.addColumn(
        'destinations',
        'longitude',
        {
          type: Sequelize.DataTypes.DECIMAL,
        },

        {transaction},
      );
      await queryInterface.addColumn(
        'destinations',
        'latitude',
        {
          type: Sequelize.DataTypes.DECIMAL,
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
    try{
      await queryInterface.removeColumn('destinations', 'longitude', {transaction});
      await queryInterface.removeColumn('destinations', 'latitude', {transaction});
      await transaction.commit();
    } catch (e) {
      await transaction.rollback();
      throw e;
    }
  }
};
