//
//  PhotoSection.swift
//  ExMoya
//
//  Created by Jake.K on 2021/12/13.
//

import RxDataSources

enum PhotoSection {
  case result([PhotoSectionItem])
}

enum PhotoSectionItem: Equatable {
  case result(Photo.Item)
}

extension PhotoSection: SectionModelType {
  var items: [PhotoSectionItem] {
    switch self {
    case .result(let photos): return photos
    }
  }
  
  init(original: PhotoSection, items: [PhotoSectionItem]) {
    switch original {
    case .result: self = .result(items)
    }
  }
}

extension PhotoSection: Equatable {
  static func == (lhs: PhotoSection, rhs: PhotoSection) -> Bool {
    lhs.items == rhs.items
  }
}
