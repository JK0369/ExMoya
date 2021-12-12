//
//  UIImageView+Kingfisher.swift
//  ExMoya
//
//  Created by Jake.K on 2021/12/13.
//

import Foundation
import Kingfisher

extension UIImageView {
  func setImage(
    with urlString: String?,
    placeholder: UIImage? = nil,
    kingfisherOptions: KingfisherOptionsInfo? = nil,
    progressBlock: DownloadProgressBlock? = nil,
    completion: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil
  ) {
    guard let url = urlString?.percentEncodedUrl else {
      self.image = placeholder
      return
    }
    
    self.kf.setImage(
      with: url,
      placeholder: placeholder,
      options: kingfisherOptions,
      progressBlock: progressBlock,
      completionHandler: completion
    )
  }
}

extension String {
  var percentEncodedUrl: URL? {
    self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
      .flatMap(URL.init(string:))
  }
}
