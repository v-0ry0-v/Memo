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
    
    private lazy var memosTableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = view.frame
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
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
        
        memos = realm.objects(Memo.self).sorted(byKeyPath: "updatedAt", ascending: false)
        
        memosTableView.reloadData()
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
        
        view.addSubview(memosTableView)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inputVC = InputViewController()
        inputVC.memo = memos[indexPath.row]
        navigationController?.pushViewController(inputVC, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = memos[indexPath.row].text.replaceNewlineWithSpace
        cell.textLabel?.font = .boldSystemFont(ofSize: 25)
        cell.detailTextLabel?.text = memos[indexPath.row].updatedAt.toFormatString("yyyy/M/d H:mm:ss")
        cell.detailTextLabel?.textColor = .gray
        return cell
    }
}
