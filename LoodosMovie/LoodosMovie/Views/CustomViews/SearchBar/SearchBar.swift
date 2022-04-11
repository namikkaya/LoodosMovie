//
//  SearchBar.swift
//  LoodosMovie
//
//  Created by namik kaya on 9.04.2022.
//

import UIKit
protocol SearchBarDelegate:AnyObject {
    func searchKeyword(str: String?)
}

class SearchBar: UIView {
    weak var delegate: SearchBarDelegate?
    private var pendingSearchWorkItem: DispatchWorkItem?
    private var holder:String?
    @IBOutlet private weak var contentContainer: UIView! {
        didSet {
            contentContainer.clipsToBounds = true
            contentContainer.layer.cornerRadius = 10
            contentContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    @IBOutlet private weak var textFieldContainer: UIView! {
        didSet {
            textFieldContainer.layer.cornerRadius = 4
        }
    }
    
    @IBOutlet private weak var inputTextField: UITextField! {
        didSet {
            inputTextField.delegate = self
        }
    }
    
    deinit {
        pendingSearchWorkItem?.cancel()
        pendingSearchWorkItem = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nibLoad()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.nibLoad()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.nibLoad()
    }
    
    private func nibLoad() {
        self.contentContainer = self.loadNib()
        self.contentContainer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(contentContainer)
        self.contentContainer.layoutIfNeeded()
    }
}

extension SearchBar: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let str = textField.text {
            pendingSearchWorkItem?.cancel()
            pendingSearchWorkItem = nil
            pendingSearchWorkItem = DispatchWorkItem { [weak self] in
                guard self?.holder != str else { return }
                self?.holder = str
                self?.delegate?.searchKeyword(str: str)
            }
            guard let pendingSearchWorkItem = pendingSearchWorkItem else { return }
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.5, execute: pendingSearchWorkItem)
        }
    }
}
