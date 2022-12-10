//
//  ContactList.swift
//  Simple Contact App
//
//  Created by user225247 on 12/10/22.
//

import Foundation

class ContactList{
    private var contacts = [Contact]()
    
    func AddContact(_contact: Contact){
        // add contact to list
        self.contacts.append(_contact)
    }
    
    func DeleteContact(_contact: Contact){
        //delete the contact
        for i in 0...self.contacts.count{
            if((self.contacts[i].getFullName() == _contact.getFullName()) // the same name and the same phone
               && (self.contacts[i].getTelephone() == _contact.getTelephone())){
                self.contacts.remove(at: i)
                break
            }
        }
    }
    
    func EditContact(_newcontact: Contact, _position: Int){
        //edit the information
        self.contacts[_position].setFullName(_newName: _newcontact.getFullName())
        self.contacts[_position].setTelephone(_newTelephone: _newcontact.getTelephone())
    }
    
    func getContactList()->[Contact]{
        return self.contacts
    }
    
    func getContact(_position:Int)->Contact?{
        return self.contacts[_position]
    }
    
    func LoadContacts(_loadedContacts: [Contact]){
        if _loadedContacts != nil{
            self.contacts = _loadedContacts
        }
    }
}
