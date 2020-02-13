//
//  LogInViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 12/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    //MARK: - IBOUTLET
    @IBOutlet weak var logInButton : UIButton!
    let firebaseMngr = FireBaseManager()
    //MARK: - IBACTION
       @IBAction func logIn(_ sender: UIButton){
           logInButton.setTitle("Loading...", for: .normal)
           logInButton.isUserInteractionEnabled = false
           logInButton.backgroundColor = .lightGray
           FireBaseManager().logInFirebase { (result) in
               switch result{
               case .failure(_):break
               case .success(_):
                self.openContactScreen()
               }
               self.logInButton.setTitle("LogIn", for: .normal)
               self.logInButton.isUserInteractionEnabled = true
               self.logInButton.backgroundColor = UIColor(displayP3Red: 1, green: 204/255, blue: 0, alpha: 1)
           }
           
       }
       //MARK: - VARIABLES

       //MARK: - OVERRIDEN
        override func viewDidLoad() {
            super.viewDidLoad()
            setUI()
        }
       //MARK: - UI SETUP
       func setUI(){
           
       }
    
       //MARK: -
    
    func openContactScreen(){
        
        let contactsCoordinator = ContactsScreenCoordinator(navigationController: navigationController!, delegate: nil, dataSource: self, datemanager: nil)
        contactsCoordinator.prefrences.nameColor = .red
        contactsCoordinator.start()
    }


}


extension LogInViewController: ContactsDataSource{
    
    func contactsList(_ viewController: ContactsViewController, contacts list: @escaping (([Channel]) -> ())) {
        firebaseMngr.getAllUsers { (users) in
            list(users)
        }
    }
    
    func cellForRowAt(_ viewController: ContactsViewController, for user: Channel, at indexPath: IndexPath) -> UITableViewCell? {
        return nil
    }
    
    func startRefreshing(_ viewController: ContactsViewController, completion: ([Channel]) -> ()) {
        
    }
}
