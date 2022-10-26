//
//  ListViewController.swift
//  SeSACUnsplashProject
//
//  Created by CHOI on 2022/10/22.
//

import UIKit
import RxCocoa
import RxSwift

class ListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, ListPhoto>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        bindData()
        self.viewModel.requestListPhoto()
    }
    
    func bindData() {
        print(#function)
        viewModel.listPhoto
            .withUnretained(self)
            .subscribe { (vc, photo) in
                var snapshot = NSDiffableDataSourceSnapshot<Int, ListPhoto>()
                snapshot.appendSections([0])
                snapshot.appendItems(photo.results)
                vc.dataSource.apply(snapshot)
                print("photo: \(photo)")
            } onError: { error in
                print("error: \(error)")
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
}

extension ListViewController {
    private func configureHierarchy() {
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell, ListPhoto> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(indexPath.row)"
            content.secondaryText = "1111"
            
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
                
            }
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeColor = .brown
            background.strokeWidth = 2
            cell.backgroundConfiguration = background
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}
