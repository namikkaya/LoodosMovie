//
//  MovieDetailsVC.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import UIKit

class MovieDetailsVC: BaseViewController {

    private var vm: MovieDetailsVM!
    @IBOutlet private weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        listenerStateClosure()
        vm.start()
    }

    func injectVM(vm: MovieDetailsVM) {
        self.vm = vm
    }
    
    private func listenerStateClosure() {
        vm.stateClosure = { [weak self] type in
            switch type {
            case.updateUI(let data):
                self?.typeHandler(type: data)
                break
            case .error(let error):
                self?.displayMessage(error: error)
                break
            }
        }
    }
    
    private func typeHandler(type: MovieDetailsVM.DetailObservation?) {
        guard let type = type else { return }
        switch type {
        case .reloadUI:
            reloadUI()
            headerImageLoad()
        }
    }
    
    private func reloadUI() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func displayMessage(error: ErrorEntity?) {
        DispatchQueue.main.async {
            ToastMessage.showToastMessage(message: error?.message ?? "", type: error?.errorType == .error ? .error : .warning, delay: 2)
        }
    }
    
    private func headerImageLoad(){
        DispatchQueue.main.async { [weak self] in
            if let headerView = self?.tableView.tableHeaderView as? StretchyTableHeaderView {
                headerView.isHidden = false
                headerView.setup(detail: self?.vm.detailData)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let headerView = self.tableView.tableHeaderView as? StretchyTableHeaderView {
            headerView.scrollViewDidScroll(scrollView: scrollView)
        }
    }
}
extension MovieDetailsVC: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        let cells = [TableViewLoadingCell.self, DetailCommonInfoCell.self]
        tableView.register(cellTypes: cells)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        if let interactivePopGestureRecognizer = navigationController?.interactivePopGestureRecognizer {
            tableView.panGestureRecognizer.require(toFail: interactivePopGestureRecognizer)
        }
        
        let header = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height / 2))
        header.isHidden = true
        self.tableView.tableHeaderView = header
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return vm.getCell(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vm.heightForRowAt(indexPath: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.numberOfSections()
    }
}
