'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Destinations extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            Destinations.hasMany(models.activities, { foreignKey: 'destination_id' });
        }
    }
    Destinations.init(
        {
            id: {
                type: DataTypes.INTEGER,
                primaryKey: true,
                autoIncrement: true,
                
            },
            name: {
                type: DataTypes.STRING,
            },
            description: {
                type: DataTypes.TEXT,
            },
            image_url: {
                type: DataTypes.STRING,
            },
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
            },
        },
        {
            sequelize,
            modelName: 'destinations',
            underscored: true,
            paranoid: true,
            createdAt: 'created_at',
            updatedAt: 'updated_at',
            deletedAt: 'deleted_at',
        }
    );
    return Destinations;
};
