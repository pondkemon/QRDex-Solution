//
//  PokedexSercice.swift
//  QRDex
//
//  Created by Wittawas Mukdaprasert on 21/5/2567 BE.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

open class PokedexService {
    private let sessionManager = SessionManager()
    private func createUrlReq(_ limit: Int = 20) -> URLRequestConvertible? {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=\(limit)") else { return nil }
        return try? URLRequest(url: url, method: .get)
    }
    
    public init() {}
    public func execute(request: String) -> Observable<Dictionary<String,Any>> {
        guard let url = createUrlReq() else { return .error( NSError(domain: "Can't create Url", code: 1001) ) }
        return sessionManager.rx.request(urlRequest: url).flatMap { request in
            return request.rx.responseJSON()
        }.map { [self] responsed -> Dictionary<String,Any> in
            let _ = self.sessionManager
            return responsed.result.value as! Dictionary<String,Any>
        }
    }
}




//open class SubmitTermsSequentRequest : BaseRequestModel {
//    public var content: BaseRequestDataModel?
//    public var identifier: String?
//    public var accepteds: [EkycAccepts]?
//    
//    public init(identifier: String, accepteds: [EkycAccepts]) {
//        super.init("--SubmitTermsSequent--")
//        self.content = BaseRequestDataModel()
//        self.identifier = identifier
//        self.accepteds = accepteds
//    }
//    
//    public required init?(map: Map) {
//        super.init(map: map)
//    }
//    
//    public override func mapping(map: Map) {
//        super.mapping(map: map)
//        content <- map["content"]
//        identifier <- map["content.identifier"]
//        accepteds <- map["content.accepteds"]
//    }
//}
//
//open class SubmitTermsSequentResponse: BaseResponseModel {
//    
//    public var content: BaseResponseModel?
//    
//    public override init() {
//        super.init()
//    }
//    
//    public required init?(map: Map) {
//        super.init(map: map)
//    }
//    
//    public override func mapping(map: Map) {
//        super.mapping(map: map)
//        content <- map["content"]
//    }
//}
