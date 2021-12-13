//
//  MyAPI+Task.swift
//  ExMoya
//
//  Created by Jake.K on 2021/12/10.
//

import Foundation
import Alamofire
import Moya

extension MyAPI {
  func getTask() -> Task {
    switch self {
    case .getPhotos(let request):
      return .requestParameters(parameters: request.toDictionary(), encoding: URLEncoding.queryString)
    }
  }
}

extension Encodable {
  func toDictionary() -> [String: Any] {
    do {
      let jsonEncoder = JSONEncoder()
      let encodedData = try jsonEncoder.encode(self)
      
      let dictionaryData = try JSONSerialization.jsonObject(
        with: encodedData,
        options: .allowFragments
      ) as? [String: Any]
      return dictionaryData ?? [:]
    } catch {
      return [:]
    }
  }
}
