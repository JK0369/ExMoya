//
//  MyAPI+BaseURL.swift
//  ExMoya
//
//  Created by Jake.K on 2021/12/11.
//

import Foundation

extension MyAPI {
  func getBaseURL() -> URL {
    return URL(string: "https://api.flickr.com/")!
  }
}
