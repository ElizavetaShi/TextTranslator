//
//  LanguagesVC.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 25.12.23.
//

import UIKit
import SnapKit

final class LanguagesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var languageTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 40.0
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: LanguageTableViewCell.identifier)
        tableView.contentInset = .init(top: 20.0, left: 0.0, bottom: 20.0, right: 0.0)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Languages"
        navigationController?.navigationBar.prefersLargeTitles = true
      
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        
        view.addSubview(languageTableView)
        
    }
    
    private func setupConstraints() {
        
        languageTableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(50.0)
        }
    }
    
    
//    MARK: TableViewDataSource, TableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.identifier) as! LanguageTableViewCell
        cell.setupCell()
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       dismiss(animated: true)
    }
    
}
