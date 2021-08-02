//
//  LoginFormViewController.swift
//  MVC
//
//  Created by alok subedi on 06/08/2021.
//

import UIKit

class LoginFormViewController: UIViewController {
    private lazy var form: LoginForm = {
        let form = LoginForm()
        form.login = { self.login() }
        return form
    }()
    
    var delegate: LoginControllerDelegate!
    
    @objc private func login() {
        guard let username = form.username,
              let password = form.password
        else {
            delegate.errorOnLogin("some fields empty")
            return
        }
        
        if password.count < 8 {
            delegate.errorOnLogin("password should be at least 8 character long")
            return
        }
        
        let url = URL(string: "https://someurl.com")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: Any] = [
            "username": username,
            "password": password
        ]
        let bodyData = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = bodyData
    
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.delegate.errorOnLogin(error.localizedDescription)
                return
            }
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                self.delegate.errorOnLogin("login failed")
                return
            }
            self.delegate.loggedIn()
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = form
    }
}
