'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Reviews extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  Reviews.init({
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true, 
      primaryKey: true,
      allowNull: false,
    },
    activity_id: DataTypes.UUID,
    user_id: DataTypes.UUID,
    group_id: DataTypes.UUID,
    rating: DataTypes.INTEGER,
    comment: DataTypes.TEXT,
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
    modelName: 'reviews',
    underscored: true,
    paranoid: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    deletedAt: 'deleted_at',
  });
  return Reviews;
};