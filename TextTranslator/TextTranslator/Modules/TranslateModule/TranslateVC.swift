//
//  TranslateVC.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 3.01.24.
//

import UIKit
import SnapKit

final class TranslateVC: UIViewController {
    
    private lazy var selectSorceLangButton: UIButton = .selectButton(with: "Select source language").withAction(self, #selector(didSourceButtonTap))
    
    private lazy var sourceTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.isSelectable = true
        textView.backgroundColor = .secondarySystemBackground
        return textView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var selectTargetLangButton: UIButton = .selectButton(with: "Select target language").withAction(self, #selector(didTargetButtonTap))
    
    private lazy var targetTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = .secondarySystemBackground
        return textView
    }()
    
    private lazy var translateButton: UIButton = .translateButton().withAction(self, #selector(didTranslateButtonTap))
    
    private var sourceLanguage: LanguageResponseModel? {
        didSet {
            selectSorceLangButton.setTitle(sourceLanguage?.name, for: .normal)
        }
    }
    private var targetLanguage: LanguageResponseModel? {
        didSet {
            selectTargetLangButton.setTitle(targetLanguage?.name, for: .normal)
        }
    }
    
    private var networkService = NetworkService()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func openLanguageVC(with type: LanguageType) {
        
        let nextVC = LanguageAssembler.languageVC()
        nextVC.delegate = self
        nextVC.type = type
        present(nextVC, animated: true)
    }
    
    private func translate(text: String) {
        
        guard let sourceCode = sourceLanguage?.code,
              let targetCode = targetLanguage?.code else { return }
        networkService.translate(sourceCode: sourceCode, targetCode: targetCode, text: text) { [weak self] translatedText in
            self?.targetTextView.text = translatedText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.addSubview(selectSorceLangButton)
        view.addSubview(sourceTextView)
        view.addSubview(separatorView)
        view.addSubview(selectTargetLangButton)
        view.addSubview(targetTextView)
        view.addSubview(translateButton)
    }
    
    private func setupConstraints() {
        selectSorceLangButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20.0)
            make.left.equalToSuperview().inset(20.0)
            make.width.equalTo(200.0)
            make.height.equalTo(30.0)
        }
        
        sourceTextView.snp.makeConstraints { make in
            make.top.equalTo(selectSorceLangButton.snp.bottom).offset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(targetTextView.snp.height)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(sourceTextView.snp.bottom).offset(20.0)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
        selectTargetLangButton.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(20.0)
            make.left.equalToSuperview().inset(20.0)
            make.width.equalTo(200.0)
            make.height.equalTo(30.0)
        }
        
        targetTextView.snp.makeConstraints { make in
            make.top.equalTo(selectTargetLangButton.snp.bottom).offset(8.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.bottom.equalTo(translateButton.snp.top).offset(-20.0)
        }
        
        translateButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.height.equalTo(40.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20.0)
        }
    }
    
    @objc private func didSourceButtonTap() {
        
        openLanguageVC(with: .source)
    }
    
    @objc private func didTargetButtonTap() {
        
        openLanguageVC(with: .target)
    }
    
    @objc private func didTranslateButtonTap() {
        
        guard let sourceText = sourceTextView.text, !sourceText.isEmpty else { return }
        translate(text: sourceText)
    }
}

extension TranslateVC: LanguageVCDelegate {
    func didSelect(language: LanguageResponseModel, with type: LanguageType) {
        switch type {
        case .source: sourceLanguage = language
        case .target: targetLanguage = language
        case .none: break
        }
    }
}
