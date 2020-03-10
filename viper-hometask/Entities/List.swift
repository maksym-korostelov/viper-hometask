import Foundation

protocol DataListProtocol: class {
    var randomList: [String] { get set }
}

final class DataList: DataListProtocol {
    var randomList: [String] = []
}
