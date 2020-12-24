//
//  Coordinator.swift
//  openweathermap
//
//  Created by Constantine Likhachov on 23.12.2020.
//

import UIKit

class Coordinator {
    
    var dependencies: AppDependencies!
    var window: UIWindow?
    var navigationController: UINavigationController
    
    //==============================================================================
    
    init() {
        let networkService = NetworkService()
        dependencies = AppDependencies(networkService: networkService)
        navigationController = UINavigationController()
    }
    
    //==============================================================================
    
    func presentInitialScreen(on window: UIWindow) {
        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let weatherRouter = WeatherRouter(dependencies: dependencies)
        let presentationContex = WeatherRouter.PresentationContext.fromCoordinator
        weatherRouter.present(on: navigationController, animated: true, context: presentationContex, completion: nil)
    }
    
}

