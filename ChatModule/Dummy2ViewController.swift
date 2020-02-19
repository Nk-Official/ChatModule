//
//  Dummy2ViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 14/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class Dummy2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
var data = ["kcjbjkbjdbsbfueryfghrjfgrgfuerjhbjvdchd\njhbfjhruhfuerhfu\nuferyfiueryiu\n","fkernfknkjernfnkerfn","vnncbvc","kcjbjkbjdbsbfueryfghrjfgrgfuerjhbjvdchd\njhbfjhruhfuerhfu\nuferyfiueryiu\ncbergyfgyuegdhf\ncfegryufguyeu0","cmbnxcvnyrtuwuoeoiufdjgfgudguygruygeuyftrueufyu\nhfgyrtyteyfte","rektuerutfvuggvchfg\nfrguyrturuyefiu\njjhvcvrefgyegfjhegjefjhdjdjjhfdjh","kcjbjkbjdbsbfueryfghrjfgrgfuerjhbjvdchd\njhbfjhruhfuerhfu\nuferyfiueryiu\n","fkernfknkjernfnkerfn","vnncbvc","kcjbjkbjdbsbfueryfghrjfgrgfuerjhbjvdchd\njhbfjhruhfuerhfu\nuferyfiueryiu\ncbergyfgyuegdhf\ncfegryufguyeu0","cmbnxcvnyrtuwuoeoiufdjgfgudguygruygeuyftrueufyu\nhfgyrtyteyfte","rektuerutfvuggvchfg\nfrguyrturuyefiu\njjhvcvrefgyegfjhegjefjhdjdjjhfdjh"]
}
extension Dummy2ViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DummyTableViewCell", owner: self, options: nil)?.first as! DummyTableViewCell
        cell.label.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
