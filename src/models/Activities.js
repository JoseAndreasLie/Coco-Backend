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
            Activities.belongsTo(models.categories, { foreignKey: 'category_id' });
            Activities.belongsTo(models.destinations, { as: 'destination', foreignKey: 'destination_id' });
            Activities.belongsToMany(models.accessories, { through: 'activity_accessories', foreignKey: 'activity_id', otherKey: 'accessory_id' });
            Activities.hasMany(models.activity_packages, { foreignKey: 'activity_id', as: 'packages' });
            Activities.hasMany(models.activity_images, { foreignKey: 'activity_id', as: 'images' });
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
            description: DataTypes.TEXT,
            category_id: { 
                type: DataTypes.INTEGER,
                references: {
                    model: 'categories',
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            destination_id: {
                type: DataTypes.INTEGER,
                references: {
                    model: 'destinations',
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            duration_minutes: {
                type: DataTypes.INTEGER,
            },
            pricing: {
                type: DataTypes.DECIMAL,
            },
            accessory_ids: {
                type: DataTypes.ARRAY(DataTypes.INTEGER),
            },
            cancelable: {
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
