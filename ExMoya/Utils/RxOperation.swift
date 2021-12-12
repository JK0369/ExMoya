//
//  RxOperation.swift
//  ExMoya
//
//  Created by Jake.K on 2021/12/13.
//

import RxSwift
import RxCocoa

extension ObservableType {
  func map<T>(_ element: T) -> Observable<T> {
    self.map({ _ in element })
  }
  func map<T>(_ element: @escaping () -> T) -> Observable<T> {
    self.map({ _ in element() })
  }
}

extension SharedSequence {
  func map<T>(_ element: T) -> SharedSequence<SharingStrategy, T> {
    self.map({ _ in element })
  }
  func map<T>(_ element: @escaping () -> T) -> SharedSequence<SharingStrategy, T> {
    self.map({ _ in element() })
  }
}

extension ObservableType {
  func mapVoid() -> Observable<Void> {
    self.map(Void())
  }
}

extension SharedSequence {
  func mapVoid() -> SharedSequence<SharingStrategy, Void> {
    self.map(Void())
  }
}
