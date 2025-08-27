'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    const transaction = await queryInterface.sequelize.transaction();
    try{
      await queryInterface.addColumn(
        'bookings',
        'date',
        {
          type: Sequelize.DataTypes.DATE,
        },

        {transaction},
      );

      await queryInterface.addColumn(
        'bookings',
        'activity_package_id',
        {
          type: Sequelize.DataTypes.INTEGER,
          references: {
            model: 'activity_packages',
            key: 'id'
          },
          onUpdate: 'CASCADE',
          onDelete: 'CASCADE'
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
      await queryInterface.removeColumn('bookings', 'date', {transaction});
      await queryInterface.removeColumn('bookings', 'activity_package_id', {transaction});
      await transaction.commit();
    } catch (e) {
      await transaction.rollback();
      throw(e);
    }
  }
};
