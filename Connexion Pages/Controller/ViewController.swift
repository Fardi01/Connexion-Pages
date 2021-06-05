//
//  ViewController.swift
//  Connexion Pages
//
//  Created by fardi Clk on 16/05/2021.
//

// Objectif : Gerer les evenements de la touche "Return"
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameTexteFiel: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTexteField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTexteFiel.delegate = self
        passwordTextField.delegate = self
        emailTexteField.delegate = self
        nameTexteFiel.placeholder = "Prenom"
        passwordTextField.placeholder = "Mot de passe"
        emailTexteField.placeholder = "adresse@mail.com"
        errorMessageLabel.text = ""
        
        //Pour cacher le mot de passe quand il est tapé
        passwordTextField.isSecureTextEntry = true
        
        //Custome CreateButton
        createButton.layer.cornerRadius = 30
        
        //setupTextField()
        
        
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
        
        if textField.tag == 2{
            wrongPassWord()
        } else if textField.tag == 3 {
            setupTextField()
        }
        
        return true
    }
    

// MARK: - Mot de passe
    // Message d'erreur s'affiche si le mot de passe contient moins de 8 caractères
    func wrongPassWord(){
        if (passwordTextField.text?.utf16.count)! > 1 && (passwordTextField.text?.utf16.count)! < 8 {
            errorMessageLabel.text = "Le mot de passe doit \n contenir au moins 8 caractères"
        } else {
            print("Ok")
            errorMessageLabel.text = ""
        }
    }
    
    
// MARK: - Email
    
    private func setupTextField(){
        if isValidEmail(emailTexteField.text!) == false {
            errorMessageLabel.text = "Veuillez entrer un \n adresse email correct"
            emailTexteField.textColor = UIColor.red
        } else {
            print("Mail Ok")
            errorMessageLabel.text = ""
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    

    
    
    
    
// MARK: - Autre
    // Le lien video Youtube pour le email texte field : https://www.youtube.com/watch?v=H0U7nFb45Ss
    // https://www.youtube.com/watch?v=GczyH6sPBbI
    
    
    //Cette methode permet de caché le clavier avec le bouton return
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        //le texteField selectionner n'est plus légitime
//        textField.resignFirstResponder()
//        return true
//    }
    
    
    //Cette methode signifie qu'une fois le texteField Completer et le bouton return cliqué, le texte est remplacé
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if (textField == nameTexteFiel){
//            welcomeLabel.text = "Bonjour \(nameTexteFiel.text!)"
//        }
//    }
    


//MARK: - Button Methods
    
    @IBAction func createProfileButton(_ sender: UIButton) {
        validationAccount()
    }
    
    private func validationAccount(){
        nameTexteFiel.text = ""
        passwordTextField.text = ""
        emailTexteField.text = ""
        errorMessageLabel.text = ""
    }
    
}


