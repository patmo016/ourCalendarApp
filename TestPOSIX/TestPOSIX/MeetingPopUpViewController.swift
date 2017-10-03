/**
 Cosc345 Asn 2, MeetingPopUpViewController.swift
 Purpose: After user hits Add button this UI will show.
 
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

import UIKit

class MeetingPopUpViewController: UIViewController {
    

    @IBOutlet weak var group: UILabel!
    @IBOutlet weak var timeAndDate: UITextField!
    @IBOutlet weak var groupText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    let datePicker = UIDatePicker()

    @IBAction func addMeeting(_ sender: UIButton)
    {
        let ass: AssignmentObjc = AssignmentObjc.init(pkid: -1, lecture: groupText.text!, time: timeAndDate.text!, position: "");
        if (groupText.text != "" && timeAndDate.text != "" && locationText.text != "")
        {
            meetings.append(groupText.text!)
            meetingTimes.append(timeAndDate.text!)
            meetingLoc.append(locationText.text!)
            
            groupText.text = ""
            timeAndDate.text = ""
            Bridging.insertMeetingsObjc(ass);
            
        }
        self.view.removeFromSuperview()
        self.removeAnimate()
        NotificationCenter.default.post(name: .reload, object: nil)
    }
    func createDatePicker()
    {
        datePicker.datePickerMode = .dateAndTime
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated:false)
        timeAndDate.inputAccessoryView = toolbar
        timeAndDate.inputView = datePicker
    }
    func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        timeAndDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @IBAction func close(_ sender: Any) {
        self.view.removeFromSuperview()
        self.removeAnimate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UITextField.appearance().tintColor = .black 
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
        createDatePicker()
    }

    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }

    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }

}

extension Notification.Name {
    static let reload = Notification.Name("reload")
}
