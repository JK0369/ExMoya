//
//  String.swift
//  ExMoya
//
//  Created by Jake.K on 2021/12/13.
//

import Foundation

extension String {
  var removedEscapeCharacters: String {
    /// remove: \"
    let removedEscapeWithQuotationMark = self.replacingOccurrences(of: "\\\"", with: "")
    /// remove: \
    let removedEscape = removedEscapeWithQuotationMark.replacingOccurrences(of: "\\", with: "")
    return removedEscape
  }
}
