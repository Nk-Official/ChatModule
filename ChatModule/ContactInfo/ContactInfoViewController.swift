//
//  ContactInfoViewController.swift
//  ChatModule
//
//  Created by user on 13/05/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class ContactInfoViewController: UIViewController {

    //MARK: - OUTLET
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!

    //MARK: - PROPERTIES
    var mediaDataSet : [ContactInfoTableData] = []
    var customiseDataSet : [ContactInfoTableData] = []
    let viewModel = ContactInfoViewModel()
    
    //MARK: - OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaDataSet = viewModel.getMediaData()
        customiseDataSet = viewModel.contactCustomiseData()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        tableViewHeight.constant = tableView.contentSize.height
    }

}
//MARK: -
extension ContactInfoViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return mediaDataSet.count
        }else if section == 1{
            return  customiseDataSet.count
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mediacell", for: indexPath) as! MediaTableViewCell
        if indexPath.section == 0{
            cell.configure(data: mediaDataSet[indexPath.row])
        }else if indexPath.section == 1{
            cell.configure(data: customiseDataSet[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: .zero)
        footer.backgroundColor = .clear
        return footer
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
}


//MARK: -UIScrollViewDelegate
extension ContactInfoViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        print(contentOffsetY)
        if contentOffsetY > 0{
            imageView.transform = CGAffineTransform(translationX: 0, y: -contentOffsetY/2.5)
        }else{
            imageView.transform = CGAffineTransform(translationX: 0, y: -contentOffsetY)
        }
    }
}
