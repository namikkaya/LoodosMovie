//
//  HomeVM.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import Foundation
import UIKit

protocol HomeViewModel: ViewModel {
    
}

class HomeVM: HomeViewModel {
    
    var stateClosure: ((ObservationType<HomeObservation, ErrorEntity>) -> ())?
    
    typealias O = ObservationType
    
    private let listUseCase: ListMovieUseCase
    
    private var sections:[SectionType] = []
    
    init(listUseCase: ListMovieUseCase) {
        self.listUseCase = listUseCase
    }
    
    func start() {
        fetchKeyword(keyword: "GodFather")
    }
    
    func searchKeyword(str: String?) {
        guard let str = str else {
            return
        }
        fetchKeyword(keyword: str)
    }
    
    private func prepareUI(searchData: SearchResponseModel, keyword: String) {
        sections.removeAll()
        guard let searchData = searchData.Search else {
            if !keyword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                stateClosure?(.error(error: ErrorEntity(title: "", message: "\(keyword) ile ilgili bir sonuç bulunamadı", errorType: .warning)))
            }
            loading()
            return
        }
        var rows: [RowType] = []
        searchData.forEach { item in
            rows.append(.movieItem(data: item))
        }
        sections.append(.defaultType(rows: rows))
        stateClosure?(.updateUI(data: .reloadUI))
    }
    
    private func loading() {
        sections.removeAll()
        sections.append(.defaultType(rows: [.loading]))
        stateClosure?(.updateUI(data: .reloadUI))
    }
}

extension HomeVM {
    enum HomeObservation {
        case reloadUI
    }
    
    enum SectionType {
        case defaultType(rows: [RowType])
    }
    
    enum RowType {
        case movieItem(data: MovieItemModel), loading
    }
}

extension HomeVM {
    func getCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = sections[safe: indexPath.section] else { return UICollectionViewCell() }
        switch sectionType {
        case .defaultType(let rows):
            let rowType = rows[indexPath.row]
            switch rowType {
            case .movieItem(let data):
                let cell = collectionView.dequeueReusableCell(with: MovieItemCell.self, for: indexPath)
                cell.setup(data: data)
                return cell
            case .loading:
                let cell = collectionView.dequeueReusableCell(with: LoadingCell.self, for: indexPath)
                return cell
            }
        }
    }
    
    func numberOfItemsInSection(_ collectionView: UICollectionView, section: Int) -> Int {
        guard let sectionType = sections[safe: section] else { return 0 }
        switch sectionType {
        case .defaultType(let rows):
            return rows.count
        }
    }
    
    func sizeForItemAt(_ collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
        guard let sectionType = sections[safe: indexPath.section] else {
            return CGSize(width: collectionView.frame.size.width / 2, height: collectionView.frame.size.height / 2.5 )
        }
        switch sectionType {
        case.defaultType(let rows):
            let rowType = rows[indexPath.row]
            switch rowType {
            case .movieItem:
                return CGSize(width: collectionView.frame.size.width / 2, height: collectionView.frame.size.height / 2.5 )
            case .loading:
                return CGSize(width: collectionView.frame.size.width, height: 150)
            }
        }
    }
}

extension HomeVM {
    private func fetchKeyword(keyword: String) {
        loading()
        listUseCase.fetchSearchList(keyword: keyword.trimmingCharacters(in: .whitespacesAndNewlines)) { [weak self] status, response, error in
            if status {
                guard let response = response else {
                    self?.loading()
                    return
                }
                self?.prepareUI(searchData: response, keyword: keyword)
            }else {
                self?.stateClosure?(.error(error: error))
            }
        }
        
    }
}

extension HomeVM {
    func getImdbID(indexPath: IndexPath) -> String? {
        guard let sectionType = sections[safe: indexPath.section] else {
            return nil
        }
        switch sectionType {
        case.defaultType(let rows):
            let rowType = rows[indexPath.row]
            switch rowType {
            case .movieItem(let data):
                return data.imdbID
            default: return nil
            }
        }
    }
}
