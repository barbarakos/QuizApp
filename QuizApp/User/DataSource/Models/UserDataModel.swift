struct UserDataModel {

    let email: String
    let name: String

}

extension UserDataModel {

    init(from model: UserResponseModel) {
        email = model.email
        name = model.name
    }

}
