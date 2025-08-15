'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class ActivityPackages extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
        }
    }
    ActivityPackages.init(
        {
            id: {
                type: DataTypes.INTEGER,
                primaryKey: true,
                autoIncrement: true,
                allowNull: false,
            },
            activity_id: {
                type: DataTypes.INTEGER,
                references: { model: 'activities', key: 'id' },
            },
            name: {
                type: DataTypes.STRING,
            },
            description: {
                type: DataTypes.TEXT,
            },
            price_per_person: {
                type: DataTypes.DECIMAL,
            },
            min_participants: {
                type: DataTypes.INTEGER,
            },
            max_participants: {
                type: DataTypes.INTEGER,
            },
            start_time: {
                type: DataTypes.TIME,
            },
            end_time: {
                type: DataTypes.TIME,
            },
            host_id: {
                type: DataTypes.INTEGER,
            },
            address: {
                type: DataTypes.STRING,
            },
            image_url: {
                type: DataTypes.STRING,
            },
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
            modelName: 'activity_packages',
            underscored: true,
            paranoid: true,
            createdAt: 'created_at',
            updatedAt: 'updated_at',
            deletedAt: 'deleted_at',
        }
    );
    return ActivityPackages;
};
