struct UserUseCaseModel {

    let email: String
    let name: String

}

extension UserUseCaseModel {

    init(from model: UserDataModel) {
        email = model.email
        name = model.name
    }

}
