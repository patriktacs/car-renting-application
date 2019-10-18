//
//  MultiMoyaProvider.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 18..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class MultiMoyaProvider: MoyaProvider<MultiTarget> {
    
    override public init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
                  requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MultiMoyaProvider.defaultRequestMapping,
                  stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
                  callbackQueue: DispatchQueue? = nil,
                  manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
                  plugins: [PluginType] = [],
                  trackInflights: Bool = false) {
        super.init(endpointClosure: endpointClosure,
                   requestClosure: requestClosure,
                   stubClosure: stubClosure,
                   callbackQueue: callbackQueue,
                   manager: manager,
                   plugins: plugins,
                   trackInflights: trackInflights)
    }
}

extension MultiMoyaProvider {
    internal func requestDecoded<T, M>(_ target: T, callBackQueue: DispatchQueue? = nil) -> Single<M> where T: TargetType, M: Codable {
        return self.rx.request(MultiTarget(target), callbackQueue: callBackQueue)
            .flatMap({ response -> Single<M> in
                do {
                    let data = try response.map(M.self)
                    return Single<M>.just(data)
                } catch {
                    return Single<M>.error(error)
                }
            })
    }
}
