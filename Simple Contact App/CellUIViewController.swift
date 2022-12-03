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
    
    
    @IBOutlet weak var Avatar: UIImageView!
    
    
    @IBOutlet weak var FullName: UILabel!
    
    
    @IBOutlet weak var Phone: UILabel!
    

    var fullname : String = ""
    var phone: String = ""
    var indexPath  : IndexPath = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEdit))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        view.backgroundColor = .white
        
        FullName.text = fullname
        Phone.text =  phone
        
    }
    
    @objc func handleEdit(){
        if let vc = storyboard?.instantiateViewController(identifier: "EditContactViewController") as? EditContactViewController{
            let controller = EditContactViewController()
            controller.delegate = self
            vc.delegate = controller.delegate
            vc.telephone_edit = Phone.text!
            vc.fullname_edit = FullName.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func handleCancel(){
        let contact = Contact(FullName: FullName.text!, Telephone: Phone.text!)
        delegateCancel?.cancelAndsaveChanges(contact: contact, indexPath: indexPath)
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func Delete(_ sender: Any) {
        let contact = Contact(FullName: fullname , Telephone: phone)
        delegate?.deleteContact(contact: contact, indexPath: indexPath)
        _ = navigationController?.popViewController(animated: true)
    }
    
}


extension CellUIViewController: EditContactDelegate{
    func editContact(contact:Contact){
        self.dismiss(animated: true){
            self.FullName.text = contact.FullName
            self.Phone.text = contact.Telephone
        }
    }
}
