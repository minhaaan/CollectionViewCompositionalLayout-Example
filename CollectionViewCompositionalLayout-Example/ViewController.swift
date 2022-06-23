//
//  ViewController.swift
//  CollectionViewCompositionalLayout-Example
//
//  Created by 최민한 on 2022/06/22.
//

import UIKit
import Then
import SnapKit

struct Text: Hashable {
  let uuid = UUID()
  let text: String
  
  static func ==(lhs: Text, rhs: Text) -> Bool {
    return lhs.uuid == rhs.uuid
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(uuid)
  }
}

class ViewController: UIViewController {
  
  enum Section: CaseIterable {
    case a
  }
  
  lazy var dataSource: UICollectionViewDiffableDataSource<Section, Text>! = nil
  let items = [
    Text(text: "1"),
    Text(text: "2"),
    Text(text: "3"),
    Text(text: "4"),
    Text(text: "5"),
    Text(text: "6"),
    Text(text: "7")
  ]
  
  lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
    setupLayout()
    configureDataSource()
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource
    <Section, Text>(collectionView: collectionView) {
      (collectionView: UICollectionView, indexPath: IndexPath, albumItem: Text) -> UICollectionViewCell? in
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "cell",
        for: indexPath) as? Cell else { fatalError("Could not create new cell") }
      cell.titleLabel.text = "1231231232112312312312312312312312312312"
      return cell
    }
    var snapshot = NSDiffableDataSourceSnapshot<Section, Text>()
    snapshot.appendSections([Section.a])
    snapshot.appendItems(items)
    dataSource.apply(snapshot)
  }
  
  func createLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
      let contentSize = layoutEnvironment.container.effectiveContentSize
      let columns = contentSize.width > 800 ? 3 : 2
      let spacing = CGFloat(10)
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .estimated(100))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .estimated(100))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
      group.interItemSpacing = .fixed(spacing)
      
      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = spacing
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      
      return section
    }
    return layout
  }
  
  private func setupLayout() {
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  
}

