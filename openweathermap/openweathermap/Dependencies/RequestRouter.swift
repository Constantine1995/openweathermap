//
//  RequestRouter.swift
//  openweathermap
//
//  Created by Constantine Likhachov on 23.12.2020.
//

import Alamofire

protocol RequestRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
}

extension RequestRouter {
    
    func asURLRequest() throws -> URLRequest {
        let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(Constant.city)&units=\(Constant.unitMetric)&appid=\(Constant.appid)"

        let url = try urlString.asURL()
        var urlRequest = URLRequest(url: url)
        if method == .post {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        } else {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
