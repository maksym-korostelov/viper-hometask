import Foundation

protocol UserAccountProtocol: class {
    var userName: String { get set }
    var password: String { get set }
}

final class UserAccount: UserAccountProtocol {
    var userName: String = ""
    var password: String = ""
}
