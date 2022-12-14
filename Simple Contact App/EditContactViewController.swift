//
//  EditContactViewController.swift
//  Simple Contact App
//
//  Created by user225247 on 11/29/22.
//

import UIKit

protocol EditContactDelegate{
    func editContact(contact:Contact)
}

class EditContactViewController: UIViewController {
    
    var delegate: EditContactDelegate?
    
    var name_edit  : String = ""
    var surname_edit  = ""
    var telephone_edit: String = ""
    var birthdate_edit: String = ""
    var description_edit: String = ""
    
   
    @IBOutlet weak var Name: UITextField!
    
     
    @IBOutlet weak var Surname: UITextField!
    
    
    
    @IBOutlet weak var Telephone: UITextField!
    
    
    @IBOutlet weak var Date: UIDatePicker!
    
    
    
    @IBOutlet weak var Description: UITextView!
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        Name.text = name_edit
        Surname.text = surname_edit
        Telephone.text = telephone_edit
        Description.text = description_edit
        
        if(birthdate_edit == "-"){
            Date.setDate(Foundation.Date(), animated: true)
        }else{
            let formatter = DateFormatter()
            formatter.dateFormat = "MM'-'dd'-'yyyy"
            let calendar = Calendar.current
            let date = formatter.date(from: birthdate_edit)
            
            if(date != nil){
                let birthday = calendar.dateComponents([.month, .day, .year], from: date!)
                Date.setDate(date!, animated: true)
            }          
        }
       
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        view.backgroundColor = .white        
    }
    

    @objc func handleDone(){
        guard let name = Name.text, let surname = Surname.text, let phone = Telephone.text, (Name.hasText && Telephone.hasText) else {
            let msgname = "A name must be inserted"
            let msgsurname = "A surname must be inserted"
            let msgtele = "A telephone must be inserted"
            if !Name.hasText {Toast().showToast(vc:self,message: msgname, font: .systemFont(ofSize: 14.0))}
            else if !Surname.hasText{Toast().showToast(vc:self,message: msgsurname, font: .systemFont(ofSize: 14.0))}
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
        let date = NSDate()
        let today =  calendar.dateComponents([.month, .day,.year], from: date as Date)
        
       
        if( birthday.day == today.day && birthday.year == today.year && birthday.month == today.month){
            birthday_string = ""
        }
        else{
            birthday_string = "\(birthday.month!)-\(birthday.day!)-\(birthday.year!)"
        }
        
        let contact = Contact(_Name: name, _Surname: surname, _Telephone: phone, _BirthDate: birthday_string, _Description: Description.text)
        delegate?.editContact(contact: contact)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func handleCancel(){
        _ = navigationController?.popViewController(animated: true)
    }

}
