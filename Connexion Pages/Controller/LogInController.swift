//
//  LogInController.swift
//  Connexion Pages
//
//  Created by fardi Clk on 20/06/2021.
//

import UIKit

class LogInController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: - Instant viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtons()
        setUpTextField()

    }
    
// MARK: - TexteField Methods
    
    // Passer au textField Suivant avec le bouton return et cacher le clavie à la fin
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTextField = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTextField){
            nextResponder.becomeFirstResponder()
        } else{
            textField.resignFirstResponder()
        }
        if textField.tag == 3{
            wrongPassWord()
        } else if textField.tag == 2 {
            wrongEmail()
        }
        return true
    }
    
    // MARK: -> Actions (buttons)
    
    @IBAction func backToSignUpScreen(_ sender: UIButton) {
        //dismiss(animated: true, completion: nil)
        // Permet de cacher la vue même avec l'utilisation d'un segue
        navigationController?.popViewController(animated: true)
        
        
    }
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        
    }
    
    // MARK: - Pivate methode
    
    private func setUpButtons() {
        //Custom Sign Up Button
        logInButton.layer.cornerRadius = 30
    }
    
    private func emptyTextFields() {
        passWordTextField.text = ""
        emailTextField.text = ""
        errorMessageLabel.text = ""
    }
    
    private func setUpTextField() {
        emailTextField.delegate = self
        passWordTextField.delegate = self
        passWordTextField.placeholder = "Mot de passe"
        emailTextField.placeholder = "adresse@mail.com"
        errorMessageLabel.text = ""
        //Hide PassWord when is tepped
        passWordTextField.isSecureTextEntry = true
        
        // Permet de cacher le clavier si on clique sur l'écran !
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // Complete la tapGesture
    @objc func hideKeyboard() {
        passWordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }

    // MARK: - Mot de passe
        // Message d'erreur s'affiche si le mot de passe contient moins de 8 caractères
       private func wrongPassWord(){
        #warning("Ajouter : Si le mot de passe n'est pas accèptable, faire vibrer le champs")
        #warning("Ajouter : L'éditeur reste sur le champs tant que le mot de passe est faux")
        
            if (passWordTextField.text?.utf16.count)! > 1 && (passWordTextField.text?.utf16.count)! < 8 {
                errorMessageLabel.text = "Le mot de passe doit \n contenir au moins 8 caractères"
            } else {
                print("Ok")
                errorMessageLabel.text = ""
            }
        }
        
        
    // MARK: - Email
        
        private func wrongEmail(){
            if isValidEmail(emailTextField.text!) == false {
                errorMessageLabel.text = "Veuillez entrer une \n adresse email correct"
                emailTextField.textColor = UIColor.red
            } else {
                print("Mail Ok")
                errorMessageLabel.text = ""
            }
        }
        
       private func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
    
}
