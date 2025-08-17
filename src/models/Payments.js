'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Payments extends Model {
        /**
         * Helper method for defining associations.
         * This method is not a part of Sequelize lifecycle.
         * The `models/index` file will call this method automatically.
         */
        static associate(models) {
            // define association here
        }
    }
    Payments.init(
        {
            id: {
                type: DataTypes.INTEGER,
                autoIncrement: true,
                primaryKey: true,
                allowNull: false,
            },
            booking_id: {
                type: DataTypes.UUID,
				references: {
					model: 'bookings',
					key: 'id',
				},
				onUpdate: 'CASCADE',
				onDelete: 'CASCADE',
            },
            group_id: {
                type: DataTypes.UUID,
				references: {
					model: 'groups',
					key: 'id',
				},
				onUpdate: 'CASCADE',
				onDelete: 'CASCADE',
            },
            payment_method: {
                type: DataTypes.STRING,
            },
            billing_address: {
                type: DataTypes.STRING,
            },
            amount: {
                type: DataTypes.DECIMAL,
            },
            tax: {
                type: DataTypes.DECIMAL,
            },
            total: {
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
            modelName: 'payments',
            underscored: true,
            paranoid: true,
            createdAt: 'created_at',
            updatedAt: 'updated_at',
            deletedAt: 'deleted_at',
        }
    );
    return Payments;
};
