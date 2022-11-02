struct UserUseCaseModel {

    let email: String
    let name: String

    init(from dataSourceModel: UserDataSourceModel) {
        self.email = dataSourceModel.email
        self.name = dataSourceModel.name
    }

}
