//
//  CellUIViewController.swift
//  Simple Contact App
//
//  Created by user225247 on 11/26/22.
//

import UIKit

protocol DeleteContactDelegate{
    func deleteContact(contact:Contact, indexPath: IndexPath)
}

protocol CancelDelegate{
    func cancelAndsaveChanges(contact: Contact, indexPath: IndexPath)
}


class CellUIViewController: UIViewController {

    var delegate: DeleteContactDelegate?
    var delegateCancel :   CancelDelegate?
    
    @IBOutlet weak var DeleteButton: UIButton!
    
    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var Surname: UILabel!
    
    @IBOutlet weak var Phone: UILabel!
    
    @IBOutlet weak var BirthDate: UILabel!
    
    @IBOutlet weak var Description: UILabel!
    
    var name : String = ""
    var surname = ""
    var phone: String = ""
    var birthdate = ""
    var description_: String = ""
    var indexPath  : IndexPath = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEdit))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        view.backgroundColor = .white
        
        Name.text = name
        Surname.text = surname
        Phone.text =  phone
        Description.text = description_
        if(birthdate.isEmpty){
            birthdate = "-"
        }
        BirthDate.text = "Birthday date: \(birthdate)"
        
        DeleteButton.layer.cornerRadius = 5
        DeleteButton.layer.borderWidth = 1
        Phone.layer.cornerRadius = 5
        
        Name.layer.cornerRadius = 5
        Surname.layer.cornerRadius = 5
        BirthDate.layer.cornerRadius = 5
        Description.layer.cornerRadius = 5
    }
    
    @objc func handleEdit(){
        if let vc = storyboard?.instantiateViewController(identifier: "EditContactViewController") as? EditContactViewController{
            let controller = EditContactViewController()
            controller.delegate = self
            vc.delegate = controller.delegate
            vc.telephone_edit = Phone.text!
            vc.name_edit = Name.text!
            vc.surname_edit = Surname.text!
            vc.description_edit = Description.text!
            if(birthdate != "-"){
                vc.birthdate_edit = birthdate
            }            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleCancel(){
        var birthdate_string = BirthDate.text!.components(separatedBy: " ").last!
        if(birthdate_string=="-") {birthdate_string =  ""}
        
        let contact = Contact(_Name: Name.text!, _Surname: Surname.text!,_Telephone: Phone.text!,
                              _BirthDate: birthdate_string, _Description: Description.text!)
        
        delegateCancel?.cancelAndsaveChanges(contact: contact, indexPath: indexPath)
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func Delete(_ sender: Any) {
        var birth_string = BirthDate.text!.components(separatedBy: " ").last!
        if(birth_string=="-") {birth_string =  ""}
        let contact = Contact(_Name: Name.text!, _Surname: Surname.text!,_Telephone: Phone.text!,
                              _BirthDate: birth_string, _Description: Description.text!)
        delegate?.deleteContact(contact: contact, indexPath: indexPath)
        _ = navigationController?.popViewController(animated: true)
    }
    
}


extension CellUIViewController: EditContactDelegate{
    func editContact(contact:Contact){
        self.dismiss(animated: true){
            self.Name.text = contact.getName()
            self.Phone.text = contact.getTelephone()
            self.Surname.text = contact.getSurname()
            self.Description.text = contact.getDescription()
            self.BirthDate.text = "Birthday date: \(contact.getBirthDate())"
        }
    }
}
