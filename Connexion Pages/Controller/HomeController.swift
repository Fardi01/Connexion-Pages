//
//  HomeController.swift
//  Connexion Pages
//
//  Created by fardi Clk on 20/06/2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Le méthode permet de vérifier si un utilisateur est déjà connecter ou pas lors de l'ouverture de l'app
        if let user = Auth.auth().currentUser {
            
            let ref = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
            ref.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let userName = value?["userName"] as? String ?? "No user name"
                
                self.nameLabel.text = userName
            }
            
        } else {
            fatalError("❌ Error :Aucun utilisateur connecter à l'affichage d'écran d'accuiel")
        }

    }
    
    // MARK: - Private func

    @IBAction func LogOutButtonTapped(_ sender: UIButton) {
        do {
            // On déconnecte l'utilisateur
            try Auth.auth().signOut()
            // On ramène sur l'écran en arrière. (Je peux changer pour ramener à l'écran principal
            navigationController?.popViewController(animated: true)
        } catch {
            print("🚫 Erreur : Déconnexion impossible")
        }
        
    }
}
