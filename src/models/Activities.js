'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Activities extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
        }
    }
    Activities.init(
        {
			id : {
				type: DataTypes.INTEGER,
				primaryKey: true,
				autoIncrement: true,
				allowNull: false,
			},
            title: DataTypes.STRING,
            description: DataTypes.STRING,
            category_id: DataTypes.INTEGER,
            destination_id: DataTypes.INTEGER,
            duration_minutes: DataTypes.INTEGER,
            pricing: DataTypes.DECIMAL,
            cancelable: DataTypes.STRING,
            created_at: {
                type: DataTypes.DATE,
                defaultValue: DataTypes.NOW,
                allowNull: false,
            },
            updated_at: {
                type: DataTypes.DATE,
                defaultValue: DataTypes.NOW,
                allowNull: false,
            },
            deleted_at: {
                type: DataTypes.DATE,
                allowNull: true,
            },
        },
        {
            sequelize,
            modelName: 'activities',
            underscored: true,
            paranoid: true,
            createdAt: 'created_at',
            updatedAt: 'updated_at',
            deletedAt: 'deleted_at',
        }
    );
    return Activities;
};
