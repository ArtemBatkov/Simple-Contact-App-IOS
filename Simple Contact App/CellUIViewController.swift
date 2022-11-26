//
//  CellUIViewController.swift
//  Simple Contact App
//
//  Created by user225247 on 11/26/22.
//

import UIKit

class CellUIViewController: UIViewController {

    
    
    @IBOutlet weak var Avatar: UIImageView!
    
    
    @IBOutlet weak var FullName: UILabel!
    
    
    @IBOutlet weak var Phone: UILabel!
    
    var ContactName: String = ""
    var ContactPhone: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        FullName.text = ContactName
        Phone.text = ContactPhone
    }
    
    
    @IBAction func Delete(_ sender: Any) {
        ViewController().DeleteContact(_contact_name: ContactName)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
