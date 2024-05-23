//
//  APIClient.swift
//  QRDex
//
//  Created by N648006 N648006 on 23/5/2567 BE.
//

import Alamofire

class APIClient {
    
    static let share = APIClient()
    
    private init() {}
    
    func request(url: String, method: HTTPMethod,
                 onComplete: @escaping (String)->Void, onError: @escaping (String)->Void) {
        AF.request(url, method: method).responseString { response in
            switch response.result {
            case .success(let data):
                onComplete(data)
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
    
    // Decoable
    func request(url: String, method: HTTPMethod,
                 onComplete: @escaping (PokemonListData)->Void, onError: @escaping (String)->Void) {
        AF.request(url, method: method).responseDecodable(of: PokemonListData.self) { response in
            switch response.result {
            case .success(let data):
                onComplete(data)
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
    
    // Decoable enhance. Let's try
    
}

