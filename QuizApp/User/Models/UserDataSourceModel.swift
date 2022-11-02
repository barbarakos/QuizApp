struct UserDataSourceModel {

    let email: String
    let name: String

    init(from responseModel: UserResponseModel) {
        self.email = responseModel.email
        self.name = responseModel.name
    }

}
