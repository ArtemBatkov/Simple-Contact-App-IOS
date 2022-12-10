//
//  AddContactViewController.swift
//  Simple Contact App
//
//  Created by user225247 on 11/30/22.
//

import UIKit

protocol AddContactDelegate{
    func addContact(contact:Contact)
}




class AddContactViewController: UIViewController {
    var fullname: String = ""
    var telephone: String = ""
    var delegateAdd: AddContactDelegate?
    
    
    @IBOutlet weak var FullName: UITextField!
    
    @IBOutlet weak var Telephone: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FullName.text = fullname
        Telephone.text = telephone
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
    }
    
    @objc func handleDone(){
        guard let fullname = FullName.text, let telephone = Telephone.text, (FullName.hasText && Telephone.hasText) else{
            let msgfull = "A full name must be inserted"
            let msgtele = "A telephone must be inserted"
            if !FullName.hasText {Toast().showToast(vc:self,message: msgfull, font: .systemFont(ofSize: 14.0))}
            else{Toast().showToast(vc:self, message: msgtele, font: .systemFont(ofSize: 14.0))}
            return
        }
        let set = CharacterSet(charactersIn: telephone)
        if !CharacterSet.decimalDigits.isSuperset(of: set){
            Toast().showToast(vc: self ,message: "Phone must contain ONLY digits!", font: .systemFont(ofSize: 14.0))
            return
        }
        let contact = Contact(_FullName: fullname, _Telephone: telephone)
        delegateAdd?.addContact(contact: contact)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func handleCancel(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    
   

}
