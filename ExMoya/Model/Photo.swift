//
//  Photo.swift
//  ExMoya
//
//  Created by Jake.K on 2021/12/13.
//

import Foundation

struct Photo: ModelType {
  let title: String
  let link: String
  let items: [Item]
  
  struct Item: ModelType {
    let title: String
    let link: String
    let media: Media
    let author: String
    let authorID: String
    
    enum CodingKeys: String, CodingKey {
      case title
      case link
      case media
      case author
      case authorID = "author_id"
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
      lhs.link == rhs.link
    }
    
    struct Media: Codable {
      let m: String
    }
  }
  
  static func == (lhs: Photo, rhs: Photo) -> Bool {
    lhs.link == rhs.link
  }
}
