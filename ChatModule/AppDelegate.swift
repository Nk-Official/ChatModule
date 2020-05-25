//
//  AppDelegate.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var loginUser : Channel!
    override init() {
        FirebaseApp.configure()
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false

//        openApp()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

extension AppDelegate{
    func openApp(){
        let nvc = UINavigationController()
        if FireBaseManager().isUserLogIn{
            let contactsCoordinator = ContactsScreenCoordinator(navigationController: nvc, delegate: nil, dataSource: self, datemanager: nil)
            contactsCoordinator.start()
        }else{
            let vc = LogInViewController.initiatefromStoryboard(.example)
            nvc.viewControllers = [vc]
        }
        let keywindow = window ?? UIWindow(frame: UIScreen.main.bounds)
        window = keywindow
        keywindow.rootViewController = nvc
        keywindow.makeKeyAndVisible()
    }
}

//MARK: - ContactsDataSource
extension AppDelegate: ContactsDataSource{
    func currentUser(_ viewController: ContactsViewController, completion: @escaping (Channel) -> ()) {
        completion(loginUser)
    }
    
    
    func cellForRowAt(_ viewController: ContactsViewController, for user: Channel, at row: Int) -> UITableViewCell? {
        return nil
    }

    func contactsList(_ viewController: ContactsViewController, contacts list: @escaping (([Channel]) -> ())) {
        viewController.showAnimation()
        FireBaseManager().getAllUsers { (users,loginUser) in
            viewController.hideAnimation()
            self.loginUser = loginUser
            list(users)
        }
    }
    
    
    func startRefreshing(_ viewController: ContactsViewController, completion: @escaping ([Channel]) -> ()) {
        FireBaseManager().getAllUsers { (channels,loginUser) in
            self.loginUser = loginUser
            completion(channels)
        }
    }
    
}

extension AppDelegate: ContactsDelegate{
    func createGroup(_ viewController: ContactsViewController, group channel: Channel) {
        FireBaseManager().createGroup(group: channel)
    }
    
    func didSelectContact(_ viewController: ContactsViewController, contact: Channel) {
        
    }
}
