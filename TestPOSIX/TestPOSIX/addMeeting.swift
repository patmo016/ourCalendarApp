//
//  addMeeting.swift
//  TestPOSIX
//
//  Created by Luke on 13/08/17.
//  Copyright © 2017 Xinru Chen. All rights reserved.
//

import UIKit

class addMeeting: UIViewController {
    @IBOutlet weak var groupinfo: UITextField!
    @IBOutlet weak var meetingtime: UITextField!
    @IBOutlet weak var meetinglocation: UITextField!
    let datePicker = UIDatePicker()
    
    var prevGroupInfo = String()
    var prevMeetingTime = String()
    var prevMeetingLocation = String()
    var indexPathRow = Int()
    
    @IBAction func addMeeting(_ sender: UIButton)
    {
        if groupinfo.text != "" && meetingtime.text != "" && meetinglocation.text != ""
        {
            let ass: AssignmentObjc = AssignmentObjc.init(pkid: -1, lecture: groupinfo.text!, time: meetingtime.text!, position: meetinglocation.text!);
            if prevGroupInfo == "" && prevMeetingTime == "" && prevMeetingLocation == ""
            {
                Bridging.insertMeetingsObjc(ass);

            }
            if prevGroupInfo != "" && prevMeetingTime != "" && prevMeetingLocation != ""
            {
                Bridging.updateMeetingsObjc(ass)
            }
            groupinfo.text = ""
            meetingtime.text = ""
            meetinglocation.text = ""
        }
    }
    func createDatePicker()
    {
        datePicker.datePickerMode = .dateAndTime
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated:false)
        meetingtime.inputAccessoryView = toolbar
        meetingtime.inputView = datePicker
    }
    func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        meetingtime.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        createDatePicker()
        groupinfo.text = prevGroupInfo
        meetingtime.text = prevMeetingTime
        meetinglocation.text = prevMeetingLocation
    }
}
