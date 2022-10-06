//
//  InputViewController.swift
//  Memo
//
//  Created by Ryoya Ogura on 2022/10/07.
//

import UIKit
import SnapKit
import RealmSwift

class InputViewController: UIViewController {
    private lazy var deleteMemoBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteMemo))
    
    private lazy var textView: UITextView = {
        let width = view.frame.width
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let close = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(close))
        let inputAccessoryView = UIToolbar()
        inputAccessoryView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
        inputAccessoryView.items = [space, close]
        let textView = UITextView()
        textView.font = .boldSystemFont(ofSize: 25)
        textView.inputAccessoryView = inputAccessoryView
        textView.delegate = self
        return textView
    }()
    
    private let realm = try! Realm()
    
    var memo: Memo!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let memo = memo {
            textView.text = memo.text
        } else {
            memo = Memo()
            try! realm.write {
                realm.add(memo)
            }
        }
    }
    
    @objc private func deleteMemo() {
        let alert = UIAlertController(title: "Delete memo?", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let delete = UIAlertAction(title: "Delete", style: .destructive) { _ in
            try! self.realm.write {
                self.realm.delete(self.memo)
                self.navigationController?.popViewController(animated: true)
            }
        }
        alert.addActions([cancel, delete])
        present(alert, animated: true)
    }
    
    @objc private func close() {
        textView.resignFirstResponder()
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = deleteMemoBarButtonItem
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
    }
}

extension InputViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        try! realm.write {
            memo.changeText(text: textView.text)
        }
    }
}
