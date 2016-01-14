//
//  DetailViewController.swift
//  Addresses
//
//  Created by John Frost on 1/13/16.
//  Copyright © 2016 Pair-A-Dice. All rights reserved.
//

import UIKit
import Contacts


class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let contact = self.detailItem {
            if let label = self.contactNameLabel {
                label.text = CNContactFormatter.stringFromContact(contact as! CNContact, style: .FullName)
            }
            
            if let conData = contact.imageData {
                imageView.image = UIImage(data: conData!)
                
            }else {
                imageView.image = nil
            }
            
            if let phoneNumberLabel = self.contactPhoneNumberLabel {
                var numberArray = [String]()
                for number in contact.phoneNumbers {
                    let phoneNumber = number.value as! CNPhoneNumber
                    numberArray.append(phoneNumber.stringValue)
                }
                phoneNumberLabel.text = numberArray.joinWithSeparator(", ")
                
            }
            
            if let addr = contact.postalAddresses.first {
                let firstAddress = addr.value as! CNPostalAddress
                let formatter = CNPostalAddressFormatter()
                let formattedAddress = formatter.stringFromPostalAddress(firstAddress)
               
                if let label = addressLabel {
                    label.text = formattedAddress
                }
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

