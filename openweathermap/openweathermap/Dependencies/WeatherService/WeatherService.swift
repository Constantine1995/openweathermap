//
//  WeatherService.swift
//  openweathermap
//
//  Created by Constantine Likhachov on 23.12.2020.
//

import Foundation

typealias CompletionHandler = (Swift.Result<WeatherData, StatusMessage>) -> Void

protocol WeatherServiceType {
    func loadWeather(completionHandler: @escaping CompletionHandler)
}

final class WeatherService: WeatherServiceType {
    
    private let networkService: NetworkServiceType
    
    init(_ networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func loadWeather(completionHandler: @escaping CompletionHandler) {
        self.networkService.sendRequest(WeatherRequestRouter.weather) { (result: Swift.Result<WeatherData, StatusMessage>) in
            switch result {
            case .success(let weather):
                completionHandler(.success(weather))
            case .failure(let message):
                completionHandler(.failure(message))
            }
        }
    }
}
