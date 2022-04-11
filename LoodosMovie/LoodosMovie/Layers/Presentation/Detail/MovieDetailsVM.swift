//
//  MovieDetailsVM.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import Foundation
import UIKit

protocol MovieDetailsViewModel: ViewModel {
    init(useCase: DetailMovieUseCase, imdbID: String)
    var imdbID: String { get set }
    var getDetailData: MovieDetails? { get }
    var stateClosure: ((ObservationType<MovieDetailsVM.DetailObservation, ErrorEntity>) -> ())? { get set }
    func getCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func numberOfRowsInSection(section:Int) -> Int
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func numberOfSections() -> Int
}

class MovieDetailsVM: MovieDetailsViewModel {
    var getDetailData: MovieDetails? {
        get {
            return detailData
        }
    }
    
    var imdbID: String
    
    var stateClosure: ((ObservationType<DetailObservation, ErrorEntity>) -> ())?
    
    private let useCase:DetailMovieUseCase
    
    private var detailData: MovieDetails?
    
    private var sections: [SectionType] = []
    
    required init(useCase: DetailMovieUseCase, imdbID: String) {
        self.useCase = useCase
        self.imdbID = imdbID
    }
    
    func start() {
        loading()
        fetchDetail(imdbID: self.imdbID)
    }
    
    private func prepareUI(data: MovieDetails) {
        detailData = data
        
        sections.removeAll()
        let rows: [RowType] = [
            .commonType(title: TitleListType.title.title, desc: data.Title),
            .commonType(title: TitleListType.plot.title, desc: data.Plot),
            .commonType(title: TitleListType.director.title, desc: data.Director),
            .commonType(title: TitleListType.writer.title, desc: data.Writer),
            .commonType(title: TitleListType.actors.title, desc: data.Actors),
            .commonType(title: TitleListType.country.title, desc: data.Country),
            .commonType(title: TitleListType.released.title, desc: data.Released),
            .commonType(title: TitleListType.awards.title, desc: data.Awards)
        ]
        sections.append(.defaultType(rows: rows))
        stateClosure?(.updateUI(data: .reloadUI))
        
        sendEvent(detail: data)
    }
    
    private func loading() {
        sections.removeAll()
        sections.append(.defaultType(rows: [.loading]))
        stateClosure?(.updateUI(data: .reloadUI))
    }
}

extension MovieDetailsVM {
    enum DetailObservation {
        case reloadUI
    }
    
    enum SectionType {
        case defaultType(rows: [RowType])
    }
    
    enum RowType {
        case commonType(title: String, desc: String?), loading
    }
    
    enum TitleListType {
        case title, plot, director, writer, actors, country, released, awards
        
        var title:String {
            switch self {
            case .title: return "Movie Name:"
            case .plot: return "Plot:"
            case .director: return "Director:"
            case .writer: return "Writer:"
            case .actors: return "Actors:"
            case .country: return "Country:"
            case .released: return "Released:"
            case .awards: return "Awards:"
            }
        }
    }
}

extension MovieDetailsVM {
    private func fetchDetail(imdbID: String) {
        useCase.fetchMovieDetails(imdbID: imdbID) { [weak self] status, response, error in
            if status {
                guard let response = response else {
                    self?.loading()
                    return
                }
                self?.prepareUI(data: response)
            }else {
                self?.stateClosure?(.error(error: error))
            }
        }
    }
    
    private func sendEvent(detail: MovieDetails) {
        useCase.logEvent(detail: detail)
    }
}

extension MovieDetailsVM {
    func getCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .defaultType(let rows):
            let rowType = rows[indexPath.row]
            switch rowType {
            case .commonType(let title, let desc):
                let cell = tableView.dequeueReusableCell(with: DetailCommonInfoCell.self, for: indexPath)
                cell.setup(title:title, desc: desc)
                return cell
            case .loading:
                let cell = tableView.dequeueReusableCell(with: TableViewLoadingCell.self, for: indexPath)
                return cell
            }
        }
    }
    
    func numberOfRowsInSection(section:Int) -> Int {
        guard sections.count > 0 else { return 0 }
        let type = sections[section]
        switch type {
        case .defaultType(let rows):
            return rows.count
        }
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .defaultType(let rows):
            let rowType = rows[indexPath.row]
            switch rowType {
            case .commonType:
                return UITableView.automaticDimension
            case .loading:
                return 80
            }
        }
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
}
