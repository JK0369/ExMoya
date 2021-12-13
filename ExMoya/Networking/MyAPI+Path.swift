//
//  MyAPI+Path.swift
//  ExMoya
//
//  Created by Jake.K on 2021/12/11.
//

import Foundation

extension MyAPI {
  func getPath() -> String {
    switch self {
    case .getPhotos:
      return "services/feeds/photos_public.gne"
    }
  }
}
