//
//  APIManager.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import Alamofire
import Foundation

// MARK: - ApiManagerProtocol

protocol ApiManagerProtocol {
    func apiRequest<Response: APIResponseProtocol>(_ request: APIRequestProtocol, withSuccess success: @escaping apiSuccess<Response>, WithApiFailure failure: @escaping apiFailure)
}

typealias apiSuccess<Response: APIResponseProtocol> = (_ response: Response?, _ error: String?, _ statusCode: Int?) -> Void
typealias apiFailure = (_ error: Error) -> Void

// MARK: - ApiManager

class ApiManager {
    private let decoder = JSONDecoder()
}

// MARK: ApiManagerProtocol

extension ApiManager: ApiManagerProtocol {
    func apiRequest<Response>(_ request: APIRequestProtocol, withSuccess success: @escaping apiSuccess<Response>, WithApiFailure failure: @escaping apiFailure) where Response: APIResponseProtocol {
        AF.request(request.endpoint,
                   method: request.method,
                   parameters: request.parameters,
                   headers: request.headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case let .success(value):

                    success(Response(with: value), response.error?.localizedDescription, response.response?.statusCode)

                case let .failure(error):
                    failure(error)
                }
            }
    }
}
