//
//  ViewController.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 13/01/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    var viewModel = LoginViewModel()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    fileprivate func configureView() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        self.view.endEditing(true)
        viewModel.validateInput(emailTextField.text, password: passwordTextField.text) { [weak self] (success, message) in
            if success {
                self?.performAPICall()
            } else {
                self?.showAlert(Constants.Message.error, message: message!, actions: [Constants.Message.ok]) { (actionTitle) in
                    print(actionTitle)
                }
            }
        }
    }
    
    private func performAPICall() {
        let request = LoginRequestModel(username: emailTextField.text!, password: passwordTextField.text!)
        viewModel.login(request) { (responseModel) in
            if responseModel.success {
                RedirectionHelper.redirectToDashboard()
            }
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            self.loginAction(loginButton)
        }
        return true
    }
}

