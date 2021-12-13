//
//  ViewController.swift
//  ExMoya
//
//  Created by Jake.K on 2021/12/10.
//

import UIKit
import Then
import SnapKit
import RxDataSources
import RxCocoa
import Reusable
import RxSwift
import Moya

class ViewController: UIViewController {
  
  struct Metric {
    static let collectionViewItemSize = CGSize(width: 96, height: 96)
    static let collectionViewSpacing = 20.0
    static let collectionViewContentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  }
  
  struct Color {
    static let collectionViewBackgroundColor = UIColor.clear
  }
  
  private let disposeBag = DisposeBag()
  private let photoDataSource = BehaviorRelay<[PhotoSection]>(value: [])
  
  private let loadImageButton = UIButton().then {
    $0.setTitle("이미지 불러오기", for: .normal)
    $0.setTitleColor(.systemBlue, for: .normal)
    $0.setTitleColor(.blue, for: .highlighted)
  }
  
  private let collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout().then {
      $0.itemSize = Metric.collectionViewItemSize
      $0.minimumLineSpacing = Metric.collectionViewSpacing
      $0.minimumInteritemSpacing = Metric.collectionViewSpacing
    }
  ).then {
    $0.register(cellType: PhotoCell.self)
    $0.contentInset = Metric.collectionViewContentInset
    $0.showsHorizontalScrollIndicator = false
    $0.allowsSelection = true
    $0.isScrollEnabled = true
    $0.bounces = true
    $0.backgroundColor = Color.collectionViewBackgroundColor
  }
  
  private var loadImageButtonTapObservable: Observable<Void> {
    self.loadImageButton.rx.tap.asObservable()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureLayout()
    setupCollectionViewDataSource()
    configureBind()
  }
  
  private func configureLayout() {
    
    view.addSubviews(
      loadImageButton,
      collectionView
    )
    
    loadImageButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(56)
      $0.centerX.equalToSuperview()
    }
    collectionView.snp.makeConstraints {
      $0.top.equalTo(loadImageButton.snp.bottom).offset(8)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func setupCollectionViewDataSource() {
    let collectionViewDataSource = RxCollectionViewSectionedReloadDataSource<PhotoSection> { _, collectionView, indexPath, sectionItem in
      Self.collectionViewConfigureCell(
        collectionView: collectionView,
        indexPath: indexPath,
        item: sectionItem
      )
    }
    
    self.photoDataSource
      .distinctUntilChanged()
      .bind(to: self.collectionView.rx.items(dataSource: collectionViewDataSource))
      .disposed(by: disposeBag)
  }
  
  private func configureBind() {
    loadImageButtonTapObservable
      .mapVoid()
      .bind(onNext: self.loadImage)
      .disposed(by: disposeBag)
  }
  
  private func loadImage() {
    let photoRequest = PhotoRequest()
    MyAPI.photos(photoRequest)
      .request()
      .map {
        let jsonString = try $0.mapString().removedEscapeCharacters
        let value = jsonString.data(using: .utf8)!
        let newResponse = Response(
          statusCode: $0.statusCode,
          data: value,
          request: $0.request,
          response: $0.response
        )
        return newResponse
      }
      .map(Photo.self, using: MyAPI.jsonDecoder)
      .do(onSuccess: { print($0) })
      .subscribe()
      .disposed(by: disposeBag)
  }
  
  // MARK: DataSources
  private static func collectionViewConfigureCell(
    collectionView: UICollectionView,
    indexPath: IndexPath,
    item: PhotoSectionItem
  ) -> UICollectionViewCell {
    switch item {
    case let .result(photo):
      let cell = collectionView.dequeueReusableCell(for: indexPath) as PhotoCell
      cell.photoImageView.setImage(
        with: photo.items.first?.media.m,
        placeholder: nil,
        completion: { result in
          guard
            let image = try? result.get().image
          else { return }
          cell.photoImageView.image = image
        }
      )
      return cell
    }
  }
}
