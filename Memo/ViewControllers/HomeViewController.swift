//
//  HomeViewController.swift
//  Memo
//
//  Created by Ryoya Ogura on 2022/10/07.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    private lazy var goToInputViewBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "square.and.pencil"),
        style: .done,
        target: self,
        action: #selector(goToInputView))
    
    private let realm = try! Realm()
    
    private var memos: Results<Memo>!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isEmptyMemos = realm.objects(Memo.self).filter({ $0.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })
        try! realm.write {
            realm.delete(isEmptyMemos)
        }
        
        memos = realm.objects(Memo.self)
        print(memos)
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
