//
//  ViewController.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/24.
//

import UIKit

class MainViewController: BaseViewController {
    
    private var models: [PostModel] = []
    private var viewModel: MainViewModel = MainViewModel()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupCollectionView()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = ColorPreset.background.colors
    }
    
    private func setupViewModel() {
        viewModel.getPosts()
        
        // reload tableview closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    private func setupCollectionView() {
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
        collectionView.register(DiscoverCell.self, forCellWithReuseIdentifier: "DiscoverCell")
        collectionView.register(SearchBarHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBarHeaderView")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = ColorPreset.background.colors
        collectionView.collectionViewLayout = setupCollectionViewLayout()
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setupCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] (section, env) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self?.discoverSectionLayout()
            default:
                return self?.postsSectionLayout()
            }
        }
    }
    
    private func discoverSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        section.interGroupSpacing = 20
        // horizontal 로 스크롤 되게 하려면 설정해줘야 하는 옵션
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func postsSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.6))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        
        // Header 정의
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = true
        
        section.boundarySupplementaryItems = [header]
        return section
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return DummyImage.dummyImageUrl.count
        default:
            return viewModel.postViewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as? DiscoverCell else { return UICollectionViewCell() }
            cell.imageUrl = DummyImage.randomDummyImage[indexPath.row]
            cell.configure()
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as? PostCell else { return UICollectionViewCell() }
            cell.viewModel = viewModel.postViewModels[indexPath.row]
            cell.configure()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBarHeaderView", for: indexPath) as? SearchBarHeaderView else { return UICollectionReusableView() }
            header.configure()
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

//extension MainViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return viewModel.getNumberOfSections()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        switch section {
//        case 0:
//            return 1
//        default:
//            return viewModel.postViewModels.count
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        switch indexPath.section {
//        case 0:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverCell", for: indexPath) as? DiscoverCell else { return UITableViewCell() }
//            cell.configure()
//            cell.selectionStyle = .none
//        default:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else { return UITableViewCell() }
//            cell.viewModel = viewModel.getCellViewModel(indexpath: indexPath)
//            cell.configure()
//            cell.selectionStyle = .none
//            return cell
//        }
//        return UITableViewCell()
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        switch indexPath.section {
//        case 0:
//            return 200
//        default:
//            return 500
//        }
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        switch section {
//        case 1:
//            guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchBarHeaderView") as? SearchBarHeaderView else { return UIView() }
//            cell.configure()
//            return cell
//        default:
//            return nil
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        switch section {
//        case 1:
//            return 50
//        default:
//            return 0
//        }
//    }
//}

