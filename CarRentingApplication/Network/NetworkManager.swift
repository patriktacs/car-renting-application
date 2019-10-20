//
//  NetworkManager.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 20..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Moya

protocol NetworkingManager {
    var provider: MultiMoyaProvider { get }
}

class NetworkManager: NetworkingManager {
    var provider: MultiMoyaProvider = MultiMoyaProvider()
    
    let networkConfig: NetworkingConfig
    
    init(networkConfig: NetworkingConfig) {
        self.networkConfig = networkConfig
        self.provider = setupProvider()
    }
    
    func customAlamofireManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        
        configuration.timeoutIntervalForRequest = self.networkConfig.timeoutIntervalForRequest
        
        let manager = Manager(configuration: configuration)
        
        return manager
    }
    
    func plugins() -> [PluginType] {
        let networkActivityPlugin = NetworkActivityPlugin(networkActivityClosure: { change, _  in
            switch change {
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        })
        
        return [networkActivityPlugin]
    }
    
    func setupProvider() -> MultiMoyaProvider {
        let provider = MultiMoyaProvider(manager: customAlamofireManager(),
                                         plugins: plugins())
        return provider
    }
}
