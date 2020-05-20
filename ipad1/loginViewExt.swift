//
//  loginViewExt.swift
//  ipad1
//
//  Created by arrow on 5/19/20.
//  Copyright © 2020 arrow. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController {
    
    
    
    func setupLoginContentView() {
        view.addSubview(loginContentView)
        
        loginContentView.addSubview(emailTextField)
        loginContentView.addSubview(passwordTextField)
        loginContentView.addSubview(loginButton)
        
        loginContentView.translatesAutoresizingMaskIntoConstraints = false //set this for Auto Layout to work!
        loginContentView.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        
        loginContentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loginContentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loginContentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
    }
    
    func setupEmailTextField() {
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.isUserInteractionEnabled = true
//        emailTextField.backgroundColor = .white
        
//        emailTextField.textColor = .darkGray
        emailTextField.textAlignment = .center
        emailTextField.backgroundColor  = UIColor(white: 1.0, alpha: 0.5)

        emailTextField.frame.size.width = 200
        emailTextField.frame.size.height = 20
        
        emailTextField.layer.cornerRadius    = 15.0
        emailTextField.autocorrectionType    = .no
        
        emailTextField.topAnchor.constraint(equalTo: loginContentView.topAnchor, constant: 40).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor).isActive = true

        emailTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupPasswordTextField() {
        
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isUserInteractionEnabled = true
//        passwordTextField.backgroundColor = .white
        
        passwordTextField.backgroundColor  = UIColor(white: 1.0, alpha: 0.5)
        
        
        passwordTextField.textAlignment = .center
        
        
        passwordTextField.frame.size.width = 200
        passwordTextField.frame.size.height = 20
        
        passwordTextField.layer.cornerRadius    = 15.0
        passwordTextField.autocorrectionType    = .no
        
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupLoginButton() {
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.isUserInteractionEnabled = true
//        loginButton.backgroundColor = .cyan
        
        loginButton.backgroundColor  = UIColor(white: 1.0, alpha: 0.7)
        
        loginButton.layer.cornerRadius    = 15.0
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        loginButton.frame.size.width = 200
        loginButton.frame.size.height = 20
        
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor).isActive = true
        
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
