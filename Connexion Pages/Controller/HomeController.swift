//
//  HomeController.swift
//  Connexion Pages
//
//  Created by fardi Clk on 20/06/2021.
//

import UIKit
import FirebaseAuth

class HomeController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Le méthode permet de vérifier si un utilisateur est déjà connecter ou pas lors de l'ouverture de l'app
        if let user = Auth.auth().currentUser {
            nameLabel.text = user.email
        } else {
            fatalError("❌ Error :Aucun utilisateur connecter à l'affichage d'écran d'accuiel")
        }

    }
    
    // MARK: - Private func

}
