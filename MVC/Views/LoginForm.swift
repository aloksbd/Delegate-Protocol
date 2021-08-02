//
//  LoginForm.swift
//  MVC
//
//  Created by alok subedi on 17/08/2021.
//

import UIKit

class LoginForm: UIView {
    private func createButton(title: String, fontColor: UIColor, backgroundColor: UIColor, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.tintColor = fontColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createTextField(placeholder: String, isPassword: Bool) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = isPassword
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private lazy var usernameLabel: UILabel = createLabel(text: "Username")
    private lazy var usernameTextField: UITextField = createTextField(placeholder: "username", isPassword: false)
    
    private lazy var passwordLabel: UILabel = createLabel(text: "Password")
    private lazy var passwordTextField: UITextField = createTextField(placeholder: "password", isPassword: true)
    
    private lazy var signInButton: UIButton = createButton(title: "Log in", fontColor: .green, backgroundColor: .purple, action: #selector(loginTapped))
    
    var login: (() -> Void)?
    
    var username: String? {
        usernameTextField.text
    }
    
    var password: String? {
        passwordTextField.text
    }
    
    convenience init() {
        self.init(frame: .zero)
        
        addViews()
        addConstraints()
    }
    
    @objc private func loginTapped() {
        login?()
    }
    
    private func addViews() {
        addSubview(usernameLabel)
        addSubview(usernameTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(signInButton)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 14),
            passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 14),
            signInButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            signInButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension LoginForm: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            dismissKeyboard()
            login?()
        }
        return false
    }
    
    private func dismissKeyboard() {
        endEditing(true)
    }
}
