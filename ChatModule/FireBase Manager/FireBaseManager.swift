//
//  FireBaseManager.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 11/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Firebase
import FirebaseDatabase
import FirebaseAuth
struct FireBaseManager {
    
    
    
    var udid : String{
        return CommonFunctions.loginUserUdId()
    }
    var isUserLogIn: Bool{
        Auth.auth().currentUser != nil
    }
    init(){
//        FirebaseApp.configure()
        databaseRefrence = Database.database().reference()
    }
    private var databaseRefrence : DatabaseReference
    
    //MARK: - firebase child path
    private let chat = "Chat"
    private let channel = "Channel"
    
    
    
    func logOut(){
        do{
            try Auth.auth().signOut()
            print("sign out firebase")
        }catch{
            fatalError(error.localizedDescription)
        }
        
    }
    func logInFirebase(completion : @escaping (Result<Bool,Error>)->()){
        
        guard let currentUser = Auth.auth().currentUser else{
            
            Auth.auth().signIn(withEmail: "komal45@gmail.com", password: "1234567890") { (result, error) in
                if error != nil{
                    debugPrint("error while login",error!.localizedDescription)
                    completion(.failure(error!))
                }else{
                    print(result?.additionalUserInfo?.profile as Any)
                    print("uid ",result?.user.uid  as Any)
                    self.addUserToDataBase()
                    completion(.success(true))
                }
            }
            return
        }
        
        print("already present user user id",currentUser.uid)
       completion(.success(true))
    }
    
    
    
    func addUserToDataBase(){
        
        do{
            let user = try Channel(name: "Rohan", id: udid, profile: "", lastMessage: nil).toDictionary()
            databaseRefrence.child(channel).child(udid).updateChildValues(user)
        }
        catch{
            fatalError("can not decode")
        }
        
    }
    
    func createGroup(group : Channel){
        
        do{
            let ref = databaseRefrence.child(self.channel).childByAutoId()
            var grp = group
            grp.id = ref.key!
            let channel = try grp.toDictionary()
            ref.updateChildValues(channel)
        }
        catch(let error){
            fatalError(error.localizedDescription)
        }
    }
    
    
    //MARK: - sendMessage

    func sendMessage(toUser: String, message : Message){
        do{
            let message = try message.toDictionary()
            databaseRefrence.child(chat).child(udid).child(toUser).childByAutoId().updateChildValues(message)
            databaseRefrence.child(chat).child(toUser).child(udid).childByAutoId().updateChildValues(message)
            databaseRefrence.child(channel).child(udid).updateChildValues(["lastMessage":message])
            databaseRefrence.child(channel).child(toUser).updateChildValues(["lastMessage":message])

        }
        catch(let error){
            fatalError(error.localizedDescription)
        }
    }
    
    //MARK: - getAllChat
    func getAllChat(of friendId: String, completion : @escaping ([Message])->()){
        var messages = [Message]()
        databaseRefrence.child(chat).child(udid).child(friendId).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists(){
                if let userData = snapshot.value as? NSDictionary{
                    for (_,value) in userData {
                        if let message: Message = CommonFunctions.dictionaryDecode(dictionary: value as! Dictionary<AnyHashable, Any>){
                            messages.append(message)
                        }
                    }
                }
            }
            completion(messages)
        }
    }
    //MARK: - getAllUsers
    func getAllUsers( completion : @escaping ([Channel])->()){
        var users = [Channel]()
        databaseRefrence.child(channel).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists(){
                if let userData = snapshot.value as? NSDictionary{
                    for (_,value) in userData {
                        print("user \n\n",value)
                        if let user:Channel = CommonFunctions.dictionaryDecode(dictionary: value as! Dictionary<AnyHashable, Any>){
                            if user.id != self.udid{ // user himself not visible in chat list
                                users.append(user)
                            }
                            
                        }
                    }
                }
                
            }
            completion(users)
        }
    }
    func splitMessagesaccordingToTime(all messages : [Message]) -> [DayMessages] {
        
        var dayMessages = [DayMessages]()
        
        var dateMngr = DateManager()
        let allDateTimeMessageSent = messages.compactMap({$0.sendDateTime}) as [String]
        let allDatesMessageSent: [String] = allDateTimeMessageSent.compactMap({dateMngr.getDate(from: $0) ?? ""})
        var dates = Array(Set(allDatesMessageSent))
        dates.sort()
        
        for date in dates{
            var dayMsg = DayMessages(date: date, messages: [])
            for message in messages where message.sendDateTime.contains(date){
                dayMsg.messages.append(message)
            }
            dayMessages.append(dayMsg)
        }
        
        
        return dayMessages
    }
}
