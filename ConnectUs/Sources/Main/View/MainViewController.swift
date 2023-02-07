//
//  ViewController.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/24.
//

import UIKit
import Combine

class MainViewController: BaseViewController {
    
    // MVVM
    private var viewModel: MainViewModel = MainViewModel()
    
    // Combine
    private var subscriptions = Set<AnyCancellable>()
    
    // 스크롤 업 버튼
    @IBOutlet weak var scrollUpButton: UIButton!
    
    // CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bind()
        viewModel.getPosts()
        setupUI()
    }
    
    // Combine 바인드 !
    private func bind() {
        viewModel.articleLists
            .receive(on: RunLoop.main)
            .sink { _ in
                self.collectionView.reloadData()
            }.store(in: &subscriptions)
        
        viewModel.scrollButtonState
            .sink { [weak self] state in
                print("Combine으로 들어옴")
                UIView.animate(withDuration: 0.5, delay: 0.5) {
                    self?.scrollUpButton.alpha = state.alpha
                }
            }.store(in: &subscriptions)
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = ColorPreset.background.colors
        scrollUpButton.tintColor = ColorPreset.accent00.colors
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
    
    // 맨 위로 가게 하는 코드
    @IBAction func scrollUpButtonTapped(_ sender: UIButton) {

        collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
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
            return viewModel.articleLists.value.count
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
            
            cell.articleResult = viewModel.articleLists.value[indexPath.row]
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        viewModel.scrollViewOffsetY(scrollView.contentOffset.y)
    }
}
