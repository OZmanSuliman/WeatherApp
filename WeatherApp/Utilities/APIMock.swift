//
//  APIMock.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import Foundation
import ObjectMapper
import StreamReader

// MARK: - ApiManagerMock

class ApiManagerMock: ApiManagerProtocol {
    private let decoder = JSONDecoder()

    func apiRequest<Response: APIResponseProtocol>(_ request: APIRequestProtocol, withSuccess success: @escaping apiSuccess<Response>, WithApiFailure failure: @escaping apiFailure) {
        guard let path = Bundle.main.path(forResource: request.endpoint, ofType: "txt") else {
            failure(NSError(domain: "invalid file", code: 500, userInfo: nil))
            return
        }

        if let json = streamReading(path: path, keyword: getKeyword(request: request)) {
            let response = Response(with: json)
            success(response, "error", 200)
        } else {
            failure(NSError(domain: "empty", code: 500, userInfo: nil))
        }
    }

    func getKeyword(request: APIRequestProtocol) -> String? {
        if let keyword = request.parameters["keyword"] as? String{
            return keyword
        }
        return nil
    }
}

extension ApiManagerMock {
    func streamReading(path: String, keyword: String? = nil) -> [[String: Any]]? {
        var list = [[String: Any]]()
        let stream = StreamReader(path: path, delimiter: "\n", encoding: String.Encoding.utf8)

        while let line = stream?.nextLine() {
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            if let obj = jsonStringToSwiftObject(str: trimmed) {
                if let keyword = keyword {
                    if let filteredList = filterByCity(city: keyword, weatherItem: obj) {
                        list.append(filteredList)
                        break
                    }
                } else {
                    list.append(obj)
                    break
                }
            }
        }

        return list
    }

    func filterByCity(city: String, weatherItem: [String: Any]) -> [String: Any]? {
        if let cityObj = weatherItem["city"] as? [String: Any],
           let cityName = cityObj["name"] as? String,
           cityName == city
        {
            return weatherItem
        }
            return nil
        
    }

    func jsonStringToSwiftObject(str: String) -> [String: Any]? {
        let data = str.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            {
                return jsonArray
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}
