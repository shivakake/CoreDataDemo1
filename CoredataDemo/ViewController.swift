//
//  ViewController.swift
//  CoredataDemo
//
//  Created by Kumaran on 04/07/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var saveDetailsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveDetailsButtonTapped(_ sender: UIButton) {
        guard let firstName = firstNameTextField?.text , !firstName.isEmpty else {
            openAlert(message: "Enter First Name")
            return
        }
        guard let lastName = lastNameTextField?.text , !lastName.isEmpty else {
            openAlert(message: "Enter Last Name")
            return
        }
        guard let email = emailIdTextField?.text , !email.isEmpty else {
            openAlert(message: "Enter Email-Id")
            return
        }
        guard let password = passwordTextField?.text , !password.isEmpty else {
            openAlert(message: "Enter Password")
            return
        }
        
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        guard let userEntity = NSEntityDescription.entity(forEntityName: "UserEntity", in: context) else { return }
        let user = NSManagedObject.init(entity: userEntity, insertInto: context)
        user.setValue(firstName, forKey: "firstName")
        user.setValue(lastName, forKey: "lastName")
        user.setValue(email, forKey: "email")
        user.setValue(password, forKey: "password")
        
        do {
            try context.save()
        } catch  {
            print(error.localizedDescription)
        }
    }
}

extension ViewController {
    func openAlert(message: String?){
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okay)
        present(alertController, animated: true, completion: nil)
    }
}
