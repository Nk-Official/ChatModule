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
    var contactDetailDataSet : [ContactInfoTableData] = []
    var chatDataSet : [ContactInfoTableData] = []
    var contactManupulateDataSet : [ContactInfoTableData] = []
    let viewModel = ContactInfoViewModel()
    
    //MARK: - OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaDataSet = viewModel.getMediaData()
        customiseDataSet = viewModel.contactCustomiseData()
        contactDetailDataSet = viewModel.contactDetailData()
        chatDataSet = viewModel.chatOptionData()
        contactManupulateDataSet = viewModel.contactManupulateData()
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tableView.layer.removeAllAnimations()
        tableViewHeight.constant = tableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.setContentOffset(CGPoint(x: 0, y: 104) , animated: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
//MARK: -
extension ContactInfoViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return mediaDataSet.count
        }else if section == 1{
            return  customiseDataSet.count
        }
        else if section == 2{
            return  contactDetailDataSet.count
        }
        else if section == 3{
            return  chatDataSet.count
        }
        else if section == 4{
            return contactManupulateDataSet.count
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mediacell", for: indexPath) as! MediaTableViewCell
        cell.headingLbl.textColor = UIColor.black
        cell.accessoryType = .disclosureIndicator
        if indexPath.section == 0{
            cell.configure(data: mediaDataSet[indexPath.row])
        }else if indexPath.section == 1{
            cell.configure(data: customiseDataSet[indexPath.row])
        }
        else if indexPath.section == 2{
            cell.configure(data: contactDetailDataSet[indexPath.row])
        }else if indexPath.section == 3{
            cell.configure(data: chatDataSet[indexPath.row])
            cell.accessoryType = .none
        }
        else if indexPath.section == 4{
            cell.configure(data: contactManupulateDataSet[indexPath.row])
            cell.headingLbl.textColor = UIColor.red
            cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: .zero)
        footer.backgroundColor = .clear
        return footer
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (cell.responds(to: #selector(getter: UIView.tintColor))) {
            let upframe = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1)
            let downframe = CGRect(x: 0, y: cell.bounds.height-1, width: tableView.frame.width, height: 1)
            let upview = UIView(frame: upframe)
            let downview = UIView(frame: downframe)
            upview.backgroundColor = UIColor.seperatorColor
            downview.backgroundColor = UIColor.seperatorColor
            upview.tag = 100
            downview.tag = 101
            for i in cell.subviews where (i.tag == 100 || i.tag == 101){
                i.removeFromSuperview()
            }
            let numberOfrows = tableView.numberOfRows(inSection: indexPath.section)
            if indexPath.row == 0{
                cell.addSubview(upview)
            }
            if indexPath.row == numberOfrows-1{
                cell.addSubview(downview)
            }
        }
    }
}


//MARK: -UIScrollViewDelegate
extension ContactInfoViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY > 0{
            imageView.transform = CGAffineTransform(translationX: 0, y: -contentOffsetY/2.5)
        }else{
            imageView.transform = CGAffineTransform(translationX: 0, y: -contentOffsetY)
        }
        if contentOffsetY < -70{
            
        }
    }
}
