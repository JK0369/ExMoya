//
//  MyAPI+Method.swift
//  ExMoya
//
//  Created by Jake.K on 2021/12/11.
//

import Foundation
import Moya

extension MyAPI {
  func getMethod() -> Moya.Method {
    switch self {
    case
        .getPhotos
      :
      return .get
    }
  }
}
