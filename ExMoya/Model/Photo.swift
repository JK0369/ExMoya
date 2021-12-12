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
  let description: String
  let modified: Date
  let generator: String
  let items: [Item]
  
  struct Item: ModelType {
    let title: String
    let link: String
    let media: Media
    let dateTaken: Date
    let itemDescription: String
    let published: Date
    let author, authorID, tags: String
    
    enum CodingKeys: String, CodingKey {
      case title, link, media
      case dateTaken = "date_taken"
      case itemDescription = "description"
      case published, author
      case authorID = "author_id"
      case tags
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
