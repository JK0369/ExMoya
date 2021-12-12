//
//  UIView.swift
//  ExMoya
//
//  Created by Jake.K on 2021/12/12.
//

import UIKit

extension UIView {
  func addSubviews(_ subviews: UIView...) {
    subviews.forEach(self.addSubview)
  }
}
