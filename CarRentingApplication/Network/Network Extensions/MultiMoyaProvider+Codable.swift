//
//  MultiMoyaProvider+Codable.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 10. 20..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Moya
import RxSwift

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
