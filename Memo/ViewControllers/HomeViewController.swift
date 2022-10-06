//
//  HomeViewController.swift
//  Memo
//
//  Created by Ryoya Ogura on 2022/10/07.
//

import UIKit

class HomeViewController: UIViewController {
    private lazy var goToInputViewBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "square.and.pencil"),
        style: .done,
        target: self,
        action: #selector(goToInputView))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupViews()
    }
    
    @objc private func goToInputView() {
        let inputVC = InputViewController()
        navigationController?.pushViewController(inputVC, animated: true)
    }
    
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemIndigo
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = "Memos"
        navigationItem.rightBarButtonItem = goToInputViewBarButtonItem
    }
    
    private func setupViews() {
        view.backgroundColor = .white
    }
}
