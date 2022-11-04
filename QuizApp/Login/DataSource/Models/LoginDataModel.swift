struct LoginDataModel {

    let accessToken: String

}

extension LoginDataModel {

    init(from model: LoginResponseModel) {
        accessToken = model.accessToken
    }

}
