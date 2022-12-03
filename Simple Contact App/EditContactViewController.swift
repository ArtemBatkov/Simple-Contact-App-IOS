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
    
    var fullname_edit  : String = ""
    var telephone_edit: String = ""
    
    @IBOutlet weak var FullName: UITextField!
    
    
    @IBOutlet weak var Telephone: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FullName.text = fullname_edit
        Telephone.text = telephone_edit
       
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        view.backgroundColor = .white
        
    }
    

    @objc func handleDone(){
        guard let fullname = FullName.text, let phone = Telephone.text, (FullName.hasText && Telephone.hasText) else {
            return
        }
        let contact = Contact(FullName: fullname, Telephone: phone)
        delegate?.editContact(contact: contact)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func handleCancel(){
        _ = navigationController?.popViewController(animated: true)
    }

}
