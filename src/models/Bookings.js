'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Bookings extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  Bookings.init({
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true, 
      primaryKey: true,
      allowNull: false,
    },
    user_id: DataTypes.UUID,
    availability_id: DataTypes.UUID,
    participants: DataTypes.INTEGER,
    total_price: DataTypes.DECIMAL,
    status: DataTypes.STRING,
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW,
    },
    updated_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW,
    },
    deleted_at: {
        type: DataTypes.DATE,
        allowNull: true,
    }
  }, {
    sequelize,
    modelName: 'bookings',
    underscored: true,
    paranoid: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    deletedAt: 'deleted_at',
  });
  return Bookings;
};