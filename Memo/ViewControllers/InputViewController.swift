//
//  InputViewController.swift
//  Memo
//
//  Created by Ryoya Ogura on 2022/10/07.
//

import UIKit
import SnapKit

class InputViewController: UIViewController {
    private lazy var deleteMemoBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteMemo))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupViews()
    }
    
    @objc private func deleteMemo() {
        
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = deleteMemoBarButtonItem
    }
    
    private func setupViews() {
        view.backgroundColor = .white
    }
}
