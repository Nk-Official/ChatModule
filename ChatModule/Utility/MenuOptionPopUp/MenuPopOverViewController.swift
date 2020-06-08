//
//  MessageAccessiblityPopUpViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 28/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class MenuPopOverViewController: UIViewController {

    
    //MARK: - OUTLETS
    @IBOutlet weak var tableHeightCConstraint : NSLayoutConstraint!
    @IBOutlet weak var tableView : UITableView!
    
    var menuItems: [PopUpMenuItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popoverPresentationController?.backgroundColor = UIColor(displayP3Red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        tableHeightCConstraint.constant = tableView.contentSize.height
        preferredContentSize = CGSize(width: 150, height: tableView.contentSize.height)
        view.layoutIfNeeded()
    }

}


//MARK: - UITableViewDataSource
extension MenuPopOverViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PopUpMenuItemTableViewCell
        let item = menuItems[indexPath.row]
        cell.configureCell(menu: item)
        return cell
    }
    
}

//MARK: - UITableViewDelegate{
extension MenuPopOverViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        updateViewConstraints()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let item = menuItems[row]
        item.tapAction(row,item)
        dismiss(animated: true, completion: nil)
    }
}
