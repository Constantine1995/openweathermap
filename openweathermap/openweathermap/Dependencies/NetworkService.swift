//
//  NetworkService.swift
//  openweathermap
//
//  Created by Constantine Likhachov on 23.12.2020.
//

import Alamofire

protocol NetworkServiceType: AnyObject {
    func sendRequest<T: Decodable>(_ router: RequestRouter, completionHandler: @escaping (Swift.Result<T, StatusMessage>) -> Void)
}

final class NetworkService: NetworkServiceType {
    
    func sendRequest<T: Decodable>(_ router: RequestRouter, completionHandler: @escaping (Swift.Result<T, StatusMessage>) -> Void) {
        
        AF.request(router).validate().responseDecodable { (response: DataResponse<T, AFError>) in
            guard let error = response.error else {
                completionHandler(.success(response.value!))
                return
            }
            
            switch error {
            case .sessionTaskFailed(let urlError):
                if urlError._code == NSURLErrorNotConnectedToInternet {
                    completionHandler(.failure(.networkError(message: "noInternetConnection")))
                } else {
                    completionHandler(.failure(.networkError(message: error.localizedDescription)))
                }
            default:
                guard let data = response.data else { completionHandler(.failure(.parsError))
                    completionHandler(.failure(.networkError(message: error.localizedDescription)))
                    return
                }
                do {
                    let backendError = try JSONDecoder().decode(BackendError.self, from: data)
                    completionHandler(.failure(.serverError(message: backendError.message)))
                } catch {
                    completionHandler(.failure(.error(message: error.localizedDescription)))
                }
            }
        }
    }
    
}


struct BackendError: Decodable {
    let code: Int
    let message: String
}
