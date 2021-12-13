//
//  MyAPI.swift
//  ExMoya
//
//  Created by Jake.K on 2021/12/10.
//

import Moya

enum MyAPI {
  case photos(PhotoRequest)
}

// MARK: MyAPI+TargetType
extension MyAPI: Moya.TargetType {
  var baseURL: URL { self.getBaseURL() }
  var path: String { self.getPath() }
  var method: Method { self.getMethod() }
  var sampleData: Data { Data() }
  var task: Task { self.getTask() }
  var headers: [String : String]? { ["Content-Type": "application/json"] }
}
