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
    private var animateTable : BehaviorRelay<Bool> = BehaviorRelay(value: true)
//    private var animation : ((ContactsViewController)->())?
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
        tableView.rx.setDataSource(self).disposed(by: disposablebag)
        tableView.rx.setDelegate(self).disposed(by: disposablebag)
        viewmodel.contacts.subscribe { (_) in
            self.tableView.reloadData()
        }.disposed(by: disposablebag)
        animateTable.subscribe { (_) in
            self.tableView.reloadData()
        }.disposed(by: disposablebag)
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
    
    //ANIMATION
    func showAnimation(animation : ((ContactsViewController)->())? = nil){
        if animation != nil{
//            self.animation = animation
            animation!(self)
            animateTable.accept(false)
            return
        }
        animateTable.accept(true)
    }
    func hideAnimation(){
        animateTable.accept(false)
    }
}

//MARK: - UITableViewDelegate
extension ContactsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = viewmodel.contacts.value[indexPath.row]
        if channel.isGroup == 1{
            //open group chat viewcontroller
            return
        }
        if delegate == nil{
            navigator.navigateToChat(self, receiver: channel)
        }else{
            delegate?.didSelectContact(self, contact: channel)
        }
    }
}
//MARK: - UITableViewDataSource
extension ContactsViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : (animateTable.value ? 5 : viewmodel.contacts.value.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        if section == 0{ // cell for add group and broad cast list
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath)
            return cell
        }else{
            // default cell
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: IndexPath(row: row, section: 0) ) as! ContactTableViewCell
            if self.dateManager == nil{
                fatalError("intitalize dateformattor")
            }
            if animateTable.value{
                cell.showLoaderSkelton()
                return cell
            }
            let item = viewmodel.contacts.value[row]
            // custom cell by user
            if let cell = self.dataSource.cellForRowAt(self, for: item, at: row){
                return cell
            }
            cell.hideLoaderSkelton()
            cell.prefrences = self.prefrences
            cell.dateManager = self.dateManager
            cell.configureCell(channel: item)
            return cell
            
        }
        
    }
}
