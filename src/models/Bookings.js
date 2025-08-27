'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Bookings extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
            Bookings.belongsTo(models.activity_availabilities, { as: 'availability', foreignKey: 'availability_id' });
            Bookings.belongsTo(models.activity_packages, { foreignKey: 'activity_package_id', as: 'package' });
            Bookings.hasMany(models.user_bookings, { as: 'user_booking', foreignKey: 'booking_id' });
            Bookings.belongsToMany(models.users, { through: 'user_bookings', foreignKey: 'booking_id', otherKey: 'user_id' });
            Bookings.belongsTo(models.users, { foreignKey: 'planner_id', as: 'planner' });
        }
    }
    Bookings.init(
        {
            id: {
                type: DataTypes.INTEGER,
                autoIncrement: true,
                primaryKey: true,
                
            },
            user_id: {
                type: DataTypes.UUID,
                references: {
                    model: 'users',
                    key: 'id',
                },
            },
            availability_id: {
                type: DataTypes.UUID,
                references: {
                    model: 'activity_availabilities',
                    key: 'id',
                },
            },
            activity_package_id: {
                type: DataTypes.INTEGER,
                references: {
                    model: 'activity_packages',
                    key: 'id',
                },
            },
            participants: {
                type: DataTypes.INTEGER,
            },
            date: {
                type: DataTypes.DATE,
            },
            planner_id: {
                type: DataTypes.UUID,
                references: {
                    model: 'users',
                    key: 'id',
                },
                onUpdate: 'CASCADE',
                onDelete: 'CASCADE',
            },
            total_price: {
                type: DataTypes.DECIMAL,
            },
            status: {
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
            modelName: 'bookings',
            underscored: true,
            paranoid: true,
            createdAt: 'created_at',
            updatedAt: 'updated_at',
            deletedAt: 'deleted_at',
        }
    );
    return Bookings;
};
