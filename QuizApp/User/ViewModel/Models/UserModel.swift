struct UserModel {

    let email: String
    let name: String

}

extension UserModel {

    init(from model: UserUseCaseModel) {
        email = model.email
        name = model.name
    }

}
