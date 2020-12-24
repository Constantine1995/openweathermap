//
//  WeatherRequestRouter.swift
//  openweathermap
//
//  Created by Constantine Likhachov on 23.12.2020.
//

import Alamofire

enum WeatherRequestRouter: RequestRouter {
    
    case weather
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        switch self {
        
        default:
            return nil
        }
    }
}
