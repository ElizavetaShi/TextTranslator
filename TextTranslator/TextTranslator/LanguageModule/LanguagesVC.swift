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
    
    private let networkService = NetworkService()
    
    private var languages: [LanguageResponseModel] = [] {
        didSet {
            languageTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Languages"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupUI()
        setupConstraints()
        
        networkService.loadLanguages { [weak self] languages in
            self?.languages = languages
        }
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
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.identifier, for: indexPath) as! LanguageTableViewCell
        cell.setupCell(with: languages[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
