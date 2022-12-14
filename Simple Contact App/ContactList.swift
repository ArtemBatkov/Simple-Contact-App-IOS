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
            var loop_contact = self.contacts[i]
            if((self.contacts[i].getName() == _contact.getName())
               && (self.contacts[i].getSurname() == _contact.getSurname())
               && (self.contacts[i].getBirthDate() == _contact.getBirthDate())
               && (self.contacts[i].getDescription() == _contact.getDescription())
               && (self.contacts[i].getTelephone() == _contact.getTelephone())){
                self.contacts.remove(at: i)
                break
            }
        }
    }
    
    func EditContact(_newcontact: Contact, _position: Int){
        //edit the information
        self.contacts[_position].setName(_newName: _newcontact.getName())
        self.contacts[_position].setSurname(_newSurname: _newcontact.getSurname())
        self.contacts[_position].setTelephone(_newTelephone: _newcontact.getTelephone())
        self.contacts[_position].setBirthDate(_newBirthDate: _newcontact.getBirthDate())
        self.contacts[_position].setDescription(_newDescription: _newcontact.getDescription())
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
    
    func getPosition(_contact: Contact)->Int{
        var position = -1
        for i in 0...self.contacts.count{
            var loop_contact = self.contacts[i]
            if((self.contacts[i].getName() == _contact.getName())
               && (self.contacts[i].getSurname() == _contact.getSurname())
               && (self.contacts[i].getBirthDate() == _contact.getBirthDate())
               && (self.contacts[i].getDescription() == _contact.getDescription())
               && (self.contacts[i].getTelephone() == _contact.getTelephone())){
                position = i
                return position
            }
        }
        return position
    }
}
