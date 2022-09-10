//
//  APIRequestProtocol.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 08/09/2022.
//

import Foundation
import Alamofire

public protocol APIRequestProtocol {
    
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var arrayParameters: [[String: Any]]? { get }
    var formData: Data? { get }
    var formDataParameters: [String: Any]? { get }
    var headers: HTTPHeaders { get }
    var isFormURLEncoded: Bool? { get }
    var apiTokenType: APITokenType? { get }
    var customEncoding: ParameterEncoding? { get }
}

public extension APIRequestProtocol {

    var method: HTTPMethod { return .get }
    var parameters: [String: Any] { return [:] }
    var arrayParameters: [[String: Any]]? { return [[:]] }
    var headers: HTTPHeaders { return [:] }
    var formData: Data? { return nil }
    var formDataParameters: [String: Any]? { return [:] }
    var isFormURLEncoded: Bool? { return false }
    var apiTokenType: APITokenType? { return .accessToken }
    var customEncoding: ParameterEncoding? { return nil }
}


public enum APITokenType {
    case none // for requests that doesn't need an access token
    case accessToken
    case refreshToken
}
