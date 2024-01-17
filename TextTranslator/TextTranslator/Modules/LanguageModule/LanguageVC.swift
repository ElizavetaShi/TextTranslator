//
//  LanguagesVC.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 25.12.23.
//

import UIKit
import SnapKit

enum LanguageType {
    case source
    case target
    case none
}

protocol LanguageVCDelegate: AnyObject {
    func didSelect(language: LanguageResponseModel, with type: LanguageType)
}

final class LanguageVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    var viewModel: LanguageVMProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
        viewModel.loadDataIfNeeded()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(languageTableView)
    }
    
    private func setupConstraints() {
        
        languageTableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(60.0)
        }
    }
    
    //    MARK: TableViewDataSource, TableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.identifier, for: indexPath) as! LanguageTableViewCell
        cell.setupCell(with: viewModel.languages[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.didSelect(language: viewModel.languages[indexPath.row])
        
        dismiss(animated: true)
    }
}

extension LanguageVC: LanguageVCProtocol {
    func reloadData() {
        languageTableView.reloadData()
    }
}
