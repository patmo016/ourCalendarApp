/**
 Cosc345 Asn 2, MeetingsViewController.swift
 Purpose: the Meeting UI.
 
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

import UIKit

var assignmentArry : NSMutableArray = [];

class MeetingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var meetingsList: UITableView!
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let send = meetingsList.cellForRow(at: indexPath)
        performSegue(withIdentifier: "editMeeting", sender: send)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editMeeting"
        {
            let editMeeting = segue.destination as? addMeeting
            if let cell = sender as? MeetingsTableViewCell
            {
                editMeeting?.prevGroupInfo = cell.meetingLabel.text!
                editMeeting?.prevMeetingTime = cell.dateAndTime.text!
                editMeeting?.prevMeetingLocation = cell.location.text!
                editMeeting?.indexPathRow = assignmentArry.index(of: cell.meetingLabel.text!)
            }
        }
    }
    
    @IBAction func addMeeting(_ sender: UIButton)
    {
        performSegue(withIdentifier: "addMeeting", sender: sender)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (assignmentArry.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MeetingsTableViewCell
        cell.meetingLabel.text = (assignmentArry[indexPath.row] as! AssignmentObjc).lecture;
        cell.dateAndTime.text = (assignmentArry[indexPath.row] as! AssignmentObjc).time;
        cell.location.text = (assignmentArry[indexPath.row] as! AssignmentObjc).position;
        return (cell)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        meetingsList.reloadData()
        UITextField.appearance().tintColor = .black 
        //NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData), name: .reload, object: nil)

    }
    
    func reloadTableData(_ notification: Notification) {
        meetingsList.reloadData()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let target: AssignmentObjc = assignmentArry[indexPath.row] as! AssignmentObjc;
            assignmentArry.remove(at: indexPath.row)
            assignmentArry = NSMutableArray(array:Bridging.queryForAllMeetings());
            Bridging.deleteMeetings(byId: target.pkid);
        }
        meetingsList.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        assignmentArry = NSMutableArray(array:Bridging.queryForAllMeetings());
        meetingsList.reloadData()
    }
}
