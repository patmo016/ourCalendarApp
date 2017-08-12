/**
 Cosc345 Asn 2, DeadlinesTableCell.swift
 Purpose: the table cell for deadline UI.
 
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

import UIKit
import UserNotifications

class DeadlinesCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBAction func addNotification(_ sender: UISwitch)
    {
        if sender.isOn == true
        {
            NotificationCenter.default.post(name: NSNotification.Name("DeadlineAlert"), object: nil, userInfo: ["notificationDate" : timeLabel.text!, "deadlineinfo" : nameLabel.text!])
        }
        else
        {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [nameLabel.text!])
        }
    }
    
    
}
