 //
//  ViewController.swift
//  Connexion Pages
//
//  Created by fardi Clk on 16/05/2021.
//

// Objectif : Gerer les evenements de la touche "Return"
import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpController: UIViewController, UITextFieldDelegate {
    
// MARK: - IBOutlets
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTexteField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var LogInButton: UIButton!
    
// MARK: - Propriétés
    
    
// MARK: - ViewDidload
    
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
    



//MARK: - Button Methods
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        if userNameTextField.text != "" && emailTexteField.text != "" && passwordTextField.text != "" {
            // Alors inscription
            Auth.auth().createUser(withEmail: emailTexteField.text!, password: passwordTextField.text!) { (authResult, error) in
                if error != nil {
                    print(error.debugDescription)
                } else {
                    print("Inscription de \(self.userNameTextField.text ?? "Default") réussie✅")
                    
                    // Je rajoute le nom d'utilisateur de mon user pour le stocker dans la base de donnée
                    let ref = Database.database().reference()
                    let userID = Auth.auth().currentUser?.uid
                    ref.child("users").child(userID!).setValue(["userName": self.userNameTextField.text!])
                    print(ref)
                    
                    // On passe à l'écran suivant !
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                    self.emptyTextFields()
                    
                    
                }
            }
        } else {
            // On affiche un message d'erreur
            errorMessageLabel.text = "Vos champs de texte \n ne sont pas completes !"
            print("Error")
        }
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        print("Go to LogIn Page")
        emptyTextFields()
    }
    
    
// MARK: - Private Methods
    
    private func setUpButtons() {
        //Custome CreateButton
        SignUpButton.layer.cornerRadius = 30
        
        //Custom Sign Up Button
        LogInButton.layer.cornerRadius = 30
        LogInButton.layer.borderWidth = 2
        LogInButton.layer.borderColor = UIColor.white.cgColor
        
    }
    
    private func emptyTextFields() {
        userNameTextField.text = ""
        passwordTextField.text = ""
        emailTexteField.text = ""
        errorMessageLabel.text = ""
    }
    
    private func setUpTextField() {
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        emailTexteField.delegate = self
        userNameTextField.placeholder = "Nom d'utilisateur"
        passwordTextField.placeholder = "Mot de passe"
        emailTexteField.placeholder = "adresse@mail.com"
        errorMessageLabel.text = ""
        //Hide PassWord when is tepped
        passwordTextField.isSecureTextEntry = true
        
        // Permet de cacher le clavier si on clique sur l'écran !
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // Complete la tapGesture
    @objc func hideKeyboard() {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        emailTexteField.resignFirstResponder()
    }
    
    
    // MARK: - Mot de passe
        // Message d'erreur s'affiche si le mot de passe contient moins de 8 caractères
       private func wrongPassWord(){
            if (passwordTextField.text?.utf16.count)! > 1 && (passwordTextField.text?.utf16.count)! < 8 {
                errorMessageLabel.text = "Le mot de passe doit \n contenir au moins 8 caractères"
            } else {
                print("Ok")
                errorMessageLabel.text = ""
            }
        }
        
        
    // MARK: - Email
        
        private func wrongEmail(){
            if isValidEmail(emailTexteField.text!) == false {
                errorMessageLabel.text = "Veuillez entrer une \n adresse email correct"
                emailTexteField.textColor = UIColor.red
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



 
 // MARK: - Autre
     // Le lien video Youtube pour le email texte field : https://www.youtube.com/watch?v=H0U7nFb45Ss
     // https://www.youtube.com/watch?v=GczyH6sPBbI
     

