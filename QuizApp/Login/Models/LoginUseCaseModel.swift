struct LoginUseCaseModel {

    let accessToken: String

    init(from dataSourceModel: LoginDataSourceModel) {
        self.accessToken = dataSourceModel.accessToken
    }

}
