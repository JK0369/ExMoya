//
//  PhotoCell.swift
//  ExMoya
//
//  Created by Jake.K on 2021/12/13.
//

import UIKit
import Reusable

class PhotoCell: UICollectionViewCell, Reusable {
  // MARK: Constants
  private enum Metric {
    static let cornerRadius = 48.0
  }
  
  private enum Color {
    static let white = UIColor.white
  }
  
  // MARK: UI
  let photoImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = Metric.cornerRadius
    $0.clipsToBounds = true
  }
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.contentView.addSubviews(
      self.photoImageView
    )
    
    self.photoImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder: NSCoder) has not been implemented")
  }
  
  func setImage(photo: Photo.Item) {
    photoImageView.tintColor = .lightGray.withAlphaComponent(0.5)
    photoImageView.setImage(
      with: photo.media.urlString,
      placeholder: UIImage(systemName: "circle.dashed"),
      completion: { [weak self] result in
        guard let image = try? result.get().image else { return }
        self?.photoImageView.image = image
      }
    )
  }
  
}
