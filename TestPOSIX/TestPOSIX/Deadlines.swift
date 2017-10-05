import UIKit
import UserNotifications

var assignmentArr : NSMutableArray = [];

class Deadlines: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!
    var alertController: UIAlertController!
    
    @IBAction func addDeadline(_ sender: UIButton)
    {
        performSegue(withIdentifier: "addDeadline", sender: sender)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let send = myTableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "editDeadline", sender: send)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editDeadline"
        {
            let editDeadline = segue.destination as? AddDeadlines
            if let cell = sender as? DeadlinesCell
            {
                editDeadline?.prevDeadlineName = cell.nameLabel.text!
                editDeadline?.prevDeadlineTime = cell.timeLabel.text!
                editDeadline?.indexPathRow = assignmentArr.index(of: cell.nameLabel.text!)
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignmentArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "deadline", for: indexPath) as! DeadlinesCell
        
        cell.nameLabel.text = (assignmentArr[indexPath.row] as! AssignmentObjc).lecture;
        cell.timeLabel.text = (assignmentArr[indexPath.row] as! AssignmentObjc).time;
        
        return(cell)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let target: AssignmentObjc = assignmentArr[indexPath.row] as! AssignmentObjc;
            assignmentArr.remove(at: indexPath.row)
            assignmentArr = NSMutableArray(array: Bridging.queryForAllAssignments());
            Bridging.deleteAssignment(byId: target.pkid);
        }
        myTableView.reloadData()
    }
    override func viewDidLoad() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("DeadlineAlert"), object: nil, queue: nil) { notification in
            self.createAlert(notification: notification)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        assignmentArr = NSMutableArray(array: Bridging.queryForAllAssignments());
        myTableView.reloadData()
    }
    func createAlert(notification: Notification) -> Void
    {
        if let userinfo = notification.userInfo {
            if let dateToBeNotified = userinfo["notificationDate"] as? String {
                if let notificationIdentifier = userinfo["deadlineinfo"] as? String {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .short
                    dateFormatter.timeStyle = .short
                    let date = dateFormatter.date(from: dateToBeNotified)!
                    let calendar = Calendar.current
                    var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    
                    alertController = UIAlertController(title: "Notification Alert!", message: "When do you want to be notified", preferredStyle: UIAlertControllerStyle.actionSheet)
                    alertController.addAction(UIAlertAction(title: "1 minute", style: UIAlertActionStyle.default, handler: { action in
                        components.minute = components.minute! + 1
                        self.createNotification(at: components, with: notificationIdentifier)
                        self.alertController.dismiss(animated: true, completion: nil)
                    }))
                    alertController.addAction(UIAlertAction(title: "1 hours", style: UIAlertActionStyle.default, handler: { action in
                        components.hour = components.hour! + 1
                        self.createNotification(at: components, with: notificationIdentifier)
                        self.alertController.dismiss(animated: true, completion: nil)
                    }))
                    alertController.addAction(UIAlertAction(title: "1 day", style: UIAlertActionStyle.default, handler: { action in
                        components.day = components.day! + 1
                        self.createNotification(at: components, with: notificationIdentifier)
                        self.alertController.dismiss(animated: true, completion: nil)
                    }))
                    alertController.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: { action in
                        self.alertController.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func createNotification(at date: DateComponents, with identifier: String)
    {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Deadline Alert!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "You have an assignment alert", arguments: nil)
        content.sound = UNNotificationSound.default()
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
