struct LoginUseCaseModel {

    let accessToken: String

}

extension LoginUseCaseModel {

    init(from model: LoginDataModel) {
        accessToken = model.accessToken
    }

}
