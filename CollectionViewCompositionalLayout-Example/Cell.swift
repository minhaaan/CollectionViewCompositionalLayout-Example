//
//  Cell.swift
//  CollectionViewCompositionalLayout-Example
//
//  Created by 최민한 on 2022/06/22.
//

import UIKit
import Then

final class Cell: UICollectionViewCell {
  
  // MARK: Properties
  
  let titleLabel = UILabel().then {
    $0.textColor = .white
    $0.font = .boldSystemFont(ofSize: 20)
    $0.numberOfLines = 0
  }
  
  // MARK: init

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupLayout()
    self.backgroundColor = .purple
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  // MARK: Method
  
  private func setupLayout() {
    contentView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(20)
      make.leading.equalTo(20)
      make.trailing.equalTo(-20)
      make.bottom.equalTo(-20)
    }
  }
  
  
}
