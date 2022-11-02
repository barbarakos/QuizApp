struct LoginDataSourceModel {

    let accessToken: String

    init(from responseModel: LoginResponseModel) {
        self.accessToken = responseModel.accessToken
    }

}
