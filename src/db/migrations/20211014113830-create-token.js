module.exports = {
    up: async (queryInterface, Sequelize) => {
        //         await queryInterface.createTable('tokens', {
        //             id: {
        //
        //                 autoIncrement: true,
        //                 primaryKey: true,
        //                 type: Sequelize.INTEGER,
        //             },
        //             token: {
        //                 type: Sequelize.STRING,
        //             },
        //             user_uuid: {
        //
        //                 type: Sequelize.DataTypes.UUID,
        //             },
        //             type: {
        //                 type: Sequelize.STRING,
        //             },
        //             blacklisted: {
        //                 type: Sequelize.BOOLEAN,
        //             },
        //             expires: {
        //
        //                 type: Sequelize.DATE,
        //             },
        //             created_at: {
        //
        //                 type: Sequelize.DATE,
        //             },
        //             updated_at: {
        //
        //                 type: Sequelize.DATE,
        //             },
        //         });
    },

    down: async (queryInterface, Sequelize) => {
        //         await queryInterface.dropTable('tokens');
    },
};
