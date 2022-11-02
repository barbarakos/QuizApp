struct UserModel {

    let email: String
    let name: String

    init(from useCaseModel: UserUseCaseModel) {
        self.email = useCaseModel.email
        self.name = useCaseModel.name
    }

}
