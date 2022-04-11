//
//  HomeVC.swift
//  LoodosMovie
//
//  Created by namik kaya on 8.04.2022.
//

import UIKit

class HomeVC: BaseViewController {
    private var vm: HomeVM!
    
    @IBOutlet private  weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBarBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var searchBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var searchBar: SearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        listenerStateClosure()
        calculationForSearchBarHeight()
        vm.start()
    }

    func injectVM(vm: HomeVM) {
        self.vm = vm
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        addListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        removeListener()
    }
    
    private func calculationForSearchBarHeight() {
        searchBarHeightConstraint.constant = 57 + (getSafeArea()?.bottom ?? 0.0)
    }
}

extension HomeVC {
    private func listenerStateClosure() {
        vm.stateClosure = { [weak self] type in
            switch type {
            case.updateUI(let data):
                self?.homeTypeHandler(type: data)
            case .error(let error):
                self?.displayMessage(error: error)
            }
        }
    }
    
    private func homeTypeHandler(type: HomeVM.HomeObservation?) {
        guard let type = type else { return }
        switch type {
        case .reloadUI:
            reloadUI()
        }
    }
    
    
    private func reloadUI() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func displayMessage(error: ErrorEntity?) {
        DispatchQueue.main.async {
            ToastMessage.showToastMessage(message: error?.message ?? "", type: error?.errorType == .error ? .error : .warning, delay: 2)
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let cells = [LoadingCell.self,MovieItemCell.self]
        collectionView.register(cellTypes: cells)
        if #available(iOS 11, *) {
            self.collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.keyboardDismissMode = .onDrag
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: searchBarHeightConstraint.constant + (getSafeArea()?.bottom ?? 0.0) , right: 0)
        layoutCells()
    }
    
    private func layoutCells() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.numberOfItemsInSection(collectionView, section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return vm.getCell(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return vm.sizeForItemAt(collectionView, collectionViewLayout: collectionViewLayout, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let imdbID = vm.getImdbID(indexPath: indexPath) {
            self.coordinatorDelegate?.commonControllerToCoordinator(type: .main(flowType: .detail(imdbID: imdbID)))
            self.view.endEditing(true)
        }
    }
}

extension HomeVC {
    private func addListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeListener() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
           let keyboardCurveNumber = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double {
            let bottomSafeArea = getSafeArea()?.bottom ?? 0.0
            UIView.animate(withDuration: keyboardDuration, delay: 0, options: UIView.AnimationOptions(rawValue: UInt(keyboardCurveNumber)), animations: {
                self.searchBarBottomConstraint.constant = keyboardSize.height - bottomSafeArea
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
           let keyboardCurveNumber = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double {
            UIView.animate(withDuration: keyboardDuration, delay: 0, options: UIView.AnimationOptions(rawValue: UInt(keyboardCurveNumber)), animations: {
                self.searchBarBottomConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
        }
    }
}

extension HomeVC: SearchBarDelegate {
    func searchKeyword(str: String?) {
        vm.searchKeyword(str: str)
    }
}

extension HomeVC {
    private func getSafeArea() -> UIEdgeInsets? {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets
    }
    
    private func getStatusBarFrameHeight() -> CGFloat? {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.keyWindow
            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
}
