import Foundation

enum RequestRandomDataError: Error {
    case somethingWentWrong
    case parsingFailed
}

extension RequestRandomDataError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .somethingWentWrong:
            return NSLocalizedString("A nasty issue happend.", comment: "My error")
        case .parsingFailed:
            return NSLocalizedString("Parsing failed.", comment: "My error")
        }
    }
}

enum LoginError: Error {
    case wrongCredentials
}

extension LoginError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .wrongCredentials:
            return NSLocalizedString("Invalid User Name or Password", comment: "My error")
        }
    }
}

class NetworkService {
    // MARK: Random List

    func getRandomList(completionHandler: @escaping (Result<[String], RequestRandomDataError>) -> Void) {
        guard let url = Constants.randomDataUrl else { completionHandler(.failure(.somethingWentWrong)); return }

        requestData(url: url) { [weak self] result in
            switch result {
            case let .failure(error):
                debugPrint(error.localizedDescription)
                completionHandler(.failure(.somethingWentWrong))
            case let .success(data):
                if let result = self?.parseRandomData(data) {
                    completionHandler(.success(result))
                } else {
                    completionHandler(.failure(.parsingFailed))
                }
            }
        }
    }

    private func parseRandomData(_ data: Data) -> [String]? {
        guard let dataString = String(data: data, encoding: .utf8) else { return nil }

        return dataString
            .split { $0.isNewline }
            .map { String($0) }
    }

    func requestData(url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completionHandler(.failure(error))
                } else {
                    if let response = response as? HTTPURLResponse {
                        print("statusCode: \(response.statusCode)")
                    }
                    if let data = data {
                        completionHandler(.success(data))
                    }
                }
            }
            task.resume()
        }
    }

    // MARK: Login

    func requestLoginData(
        userName: String,
        password: String,
        completionHandler: @escaping (Result<Bool, LoginError>) -> Void
    ) {
        DispatchQueue.global().async {
            guard userName == "user", password == "123qwe" else {
                completionHandler(.failure(LoginError.wrongCredentials))
                return
            }
            debugPrint("Authentification...")
            completionHandler(.success(true))
        }
    }
}
