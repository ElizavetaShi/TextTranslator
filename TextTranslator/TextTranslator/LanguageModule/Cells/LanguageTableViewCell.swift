//
//  LanguageTableViewCell.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 25.12.23.
//

import UIKit
import SnapKit

final class LanguageTableViewCell: UITableViewCell {
    
    static var identifier: String = "LanguageTableViewCell"
    
    private lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17.0)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17.0)
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(codeLabel)
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        
        codeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16.0)
            make.width.equalTo(40.0)
            make.height.equalTo(25.0)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(codeLabel.snp.centerY)
            make.left.equalTo(codeLabel.snp.right).inset(8.0)
            make.right.equalToSuperview().inset(16.0)
        }
        
    }
    
    func setupCell() {
        codeLabel.text = "code"
        nameLabel.text = "nameLanguage"
    
    }
}
