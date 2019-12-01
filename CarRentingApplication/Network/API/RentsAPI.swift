//
//  RentsAPI.swift
//  CarRentingApplication
//
//  Created by Ács Patrik on 2019. 11. 24..
//  Copyright © 2019. Ács Patrik Tamás. All rights reserved.
//

import Foundation
import Moya

enum RentsAPI {
    case getRents(token: String)
    case postStartRent(token: String, rentId: String)
    case postCancelRent(token: String, rentId: String)
    case postStopRent(token: String, rentId: String)
    case postBeforeImage(token: String, image: UIImage, rentId: String)
    case postAfterImage(token: String, image: UIImage, rentId: String)
}

extension RentsAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://ec2-3-14-28-216.us-east-2.compute.amazonaws.com")!
    }
    
    var path: String {
        switch self {
        case .getRents:
            return "/rents"
        case .postStartRent(token: _, let rentId):
            return "/rents/" + rentId + "/start"
        case .postCancelRent(token: _, let rentId):
            return "/rents/" + rentId + "/cancel"
        case .postStopRent(token: _, let rentId):
            return "/rents/" + rentId + "/stop"
        case .postBeforeImage(token: _, image: _, let rentId):
            return "/rents/" + rentId + "/image/before"
        case .postAfterImage(token: _, image: _, let rentId):
            return "/rents/" + rentId + "/image/after"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRents:
            return .get
        case .postStartRent, .postCancelRent, .postStopRent, .postAfterImage, .postBeforeImage:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .postBeforeImage(token: _, let image, let rentId):
            let imageData = image.jpegData(compressionQuality: 0.01) ?? Data()
            let multiImage = MultipartFormData(provider: .data(imageData), name: "image", fileName: rentId + "uploaded-image.jpeg", mimeType: "image/jpeg")
            
            return .uploadMultipart([multiImage])
        case .postAfterImage(token: _, let image, let rentId):
            let imageData = image.jpegData(compressionQuality: 0.01) ?? Data()
            let multiImage = MultipartFormData(provider: .data(imageData), name: "image", fileName: rentId + "uploaded-image.jpeg", mimeType: "image/jpeg")
            
            return .uploadMultipart([multiImage])
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getRents(let token):
            return ["Authorization": "Basic " + token]
        case .postStartRent(let token, rentId: _), .postCancelRent(let token, rentId: _), .postStopRent(let token, rentId: _), .postBeforeImage(let token, image: _, rentId: _), .postAfterImage(let token, image: _, rentId: _):
            return ["Authorization": "Basic " + token]
        }
    }
}
