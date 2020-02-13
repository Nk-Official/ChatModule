//
//  ContactsViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 11/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import RxSwift
import RxCocoa
class ContactsViewController: UIViewController {

    //MARK: - IBOUTLET
   @IBOutlet weak var tableView : UITableView!
   //MARK: - IBACTION
   @IBAction func logOut(_ sender: UIButton){
    viewmodel.firebaseManager.logOut()
   }
    @IBAction func group(_ sender: UIButton){
      alertForGroup()
    }
   //MARK: - VARIABLES
    let viewmodel = ContactsViewModel()
    let disposablebag = DisposeBag()
    var dataSource: ContactsDataSource!
    var delegate: ContactsDelegate?
    var dateManager : DateManager!
    var prefrences: ContactsPrefrences!
    var navigator : ContactsNavigator!
   //MARK: - OVERRIDEN
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUiToViewModel()
        getContacts()
    }
   //MARK: - UI SETUP
   func setUI(){
       
   }
    //MARK: - BINDABLES
    func bindUiToViewModel(){
        viewmodel.contacts.bind(to: tableView.rx.items) { (tableV, row, item) -> UITableViewCell in
            if let cell = self.dataSource.cellForRowAt(self, for: item, at: IndexPath(row: row, section: 0)){
                return cell
            }
            let cell = tableV.dequeueReusableCell(withIdentifier: "cell", for: IndexPath(row: row, section: 0) ) as! ContactTableViewCell
            if self.dateManager == nil{
                fatalError("intitalize datebformattor")
            }
            cell.prefrences = self.prefrences
            cell.dateManager = self.dateManager
            cell.configureCell(channel: item)
            return cell
        }.disposed(by: disposablebag)
        tableView.rx.setDelegate(self).disposed(by: disposablebag)
        
    }
       //MARK: - NETWORK CALL
    func getContacts(){
        dataSource.contactsList(self) { (channels) in
            self.viewmodel.contacts.accept(channels)
        }
        
//        dataSource.startRefreshing(<#T##viewController: ContactsViewController##ContactsViewController#>, completion: { 
//            <#code#>
//        })
    }

    func alertForGroup(){
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "New Group", message: "Provide a group subject", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Type group subject here"
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            let channel = Channel(name: textField!.text!, id: "", profile: "https://firebasestorage.googleapis.com/v0/b/chatmodule-454c8.appspot.com/o/images.png?alt=media&token=24543cb4-8c75-4d6b-95e0-3e1cf5848857", lastMessage: nil, isGroup: 1)
            self.delegate?.createGroup(self, group: channel)
            self.dataSource.startRefreshing(self) { (channels) in
                self.viewmodel.contacts.accept(channels)
            }
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
}


extension ContactsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = viewmodel.contacts.value[indexPath.row]
        if channel.isGroup == 1{
            //open group chat viewcontroller
            return
        }
        if delegate == nil{
            navigator.navigateToChat(self, receiverId: channel.id)
        }else{
            delegate?.didSelectContact(self, contact: channel)
        }
    }
}
