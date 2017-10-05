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
            let assignment: AssignmentObjc = AssignmentObjc.init(pkid: -1, lecture: deadlineName.text!, time: deadlineTime.text!, position: "")
            Bridging.insertNewAssignmentObjc(assignment);
            deadlineName.text = ""
            deadlineTime.text = ""
        }
        if prevDeadlineName != "" && prevDeadlineTime != "" && deadlineName.text != "" && deadlineTime.text != ""
        {
            let assignment: AssignmentObjc = AssignmentObjc.init(pkid: -1, lecture: deadlineName.text!, time: deadlineTime.text!, position: "")
        
            Bridging.updateNewAssignmentBynameObjc(assignment)
            deadlineName.text = ""
            deadlineTime.text = ""
        }
        
    }
    
    
    /*
    @IBAction func addDeadline(_ sender: UIButton)
    {
        if deadlineName.text != "" && deadlineTime.text != "" && prevDeadlineName == "" && prevDeadlineTime == ""
        {
            let assignment: AssignmentObjc = AssignmentObjc.init(pkid: -1, lecture: deadlineName.text!, time: deadlineTime.text!, position: "")
            Bridging.insertNewAssignmentObjc(assignment);
            deadlineName.text = ""
            deadlineTime.text = ""
        }
        if prevDeadlineName != "" && prevDeadlineTime != "" && deadlineName.text != "" && deadlineTime.text != ""
        {
            let assignment: AssignmentObjc = AssignmentObjc.init(pkid: -1, lecture: deadlineName.text!, time: deadlineTime.text!, position: "")
            
            Bridging.updateNewAssignmentBynameObjc(assignment)
            deadlineName.text = ""
            deadlineTime.text = ""
        }
        
    }
 */
    
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
