import UIKit
import UserNotifications

class AddDeadlines: UIViewController {
    
    @IBOutlet weak var deadlineName: UITextField!
    @IBOutlet weak var deadlineTime: UITextField!
    
    let datePicker = UIDatePicker()
    
    var prevDeadlineName = String()
    var prevDeadlineTime = String()
    var indexPathRow = Int()
    
    @IBAction func addDeadline(_ sender: UIButton)
    {
        if deadlineName.text != "" && deadlineTime.text != "" && prevDeadlineName == "" && prevDeadlineTime == ""
        {
            deadlineNames.append(deadlineName.text!)
            deadlineTimes.append(deadlineTime.text!)
            deadlineName.text = ""
            deadlineTime.text = ""
        }
        if prevDeadlineName != "" && prevDeadlineTime != "" && deadlineName.text != "" && deadlineTime.text != ""
        {
            deadlineNames[indexPathRow] = deadlineName.text!
            deadlineTimes[indexPathRow] = deadlineTime.text!
            deadlineName.text = ""
            deadlineTime.text = ""
        }
    }
    
    override func viewDidLoad() {
        createDatePicker()
        deadlineName.text = prevDeadlineName
        deadlineTime.text = prevDeadlineTime
    }
    
    func createDatePicker() {
        datePicker.datePickerMode = .dateAndTime
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        deadlineTime.inputAccessoryView = toolbar
        
        deadlineTime.inputView = datePicker
    }
    
    func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        deadlineTime.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
}
