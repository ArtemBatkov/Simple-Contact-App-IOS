//
//  AddContactViewController.swift
//  Simple Contact App
//
//  Created by user225247 on 11/30/22.
//

import UIKit
import Fakery

protocol AddContactDelegate{
    func addContact(contact:Contact)
}




class AddContactViewController: UIViewController {
    var name: String = ""
    var surname: String = ""
    var telephone: String = ""
    var description_: String = ""
    var date_string: String = ""
    
    var delegateAdd: AddContactDelegate?
    
    private let faker = Faker()
    
    @IBOutlet weak var Surname: UITextField!
    
    @IBOutlet weak var Name: UITextField!
    
    @IBOutlet weak var Telephone: UITextField!
    
    
    @IBOutlet weak var Date: UIDatePicker!
    
    
    
    @IBOutlet weak var Description: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.text = name
        Surname.text = surname
        Telephone.text = telephone
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        
    }
    
    @objc func handleDone(){
        guard let name = Name.text, let surname = Surname.text , let phone = Telephone.text, (Name.hasText && Telephone.hasText && Surname.hasText) else{
            let msgname = "A name must be inserted"
            let msgsurname = "A surname must be inserted"
            let msgtele = "A telephone must be inserted"
            if !Name.hasText {Toast().showToast(vc:self,message: msgname, font: .systemFont(ofSize: 14.0))}
            else if   !Surname.hasText {Toast().showToast(vc:self,message: msgsurname, font: .systemFont(ofSize: 14.0))}
            else{Toast().showToast(vc:self, message: msgtele, font: .systemFont(ofSize: 14.0))}
            return
        }
        let set = CharacterSet(charactersIn: phone)
        if !CharacterSet.decimalDigits.isSuperset(of: set){
            Toast().showToast(vc: self ,message: "Phone must contain ONLY digits!", font: .systemFont(ofSize: 14.0))
            return
        }
                
        let birthday: DateComponents = Date.calendar.dateComponents([.month,.day,.year], from: Date.date)
        var birthday_string : String = ""
        
        let calendar = Calendar.current
        let date = Foundation.Date()
        let today =  calendar.dateComponents([.month, .day,.year], from: date)
        
       
        if( birthday.day == today.day && birthday.year == today.year && birthday.month == today.month){
            birthday_string = ""
        }
        else{
            birthday_string = "\(birthday.month!)-\(birthday.day!)-\(birthday.year!)"
        }
        
        let contact = Contact(_Name: name, _Surname: surname, _Telephone: phone, _BirthDate: birthday_string, _Description: Description.text)
        delegateAdd?.addContact(contact: contact)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func handleCancel(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    
   

}
