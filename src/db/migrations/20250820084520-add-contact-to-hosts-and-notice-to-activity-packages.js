'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    const transaction = await queryInterface.sequelize.transaction();
    try{
      await queryInterface.addColumn(
        'hosts',
        'contact',
        {
          type: Sequelize.DataTypes.STRING
        },

        {transaction},
      );
      await queryInterface.addColumn(
        'activity_packages',
        'notice',
        {
          type: Sequelize.DataTypes.TEXT
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
      await queryInterface.removeColumn('hosts', 'contact', {transaction});
      await queryInterface.removeColumn('activity_packages', 'notice', {transaction});
      await transaction.commit();
    } catch (e) {
      await transaction.rollback();
      throw e;
    }
  }
};
