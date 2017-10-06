//
//  CalandarViewController.swift
//  TestPOSIX
//
//  Created by Molly Patterson on 2/08/17.
//  Copyright © 2017 Xinru Chen. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Foundation

var dates = [String]();
var plans : NSMutableArray = [];
var sched : NSMutableArray = [];



class CalandarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!

    @IBOutlet weak var header : UILabel!
   
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year : UILabel!
    @IBOutlet weak var month: UILabel!
    
    let formatter = DateFormatter()
    let red = UIColor.red
    let white = UIColor.white
    let black = UIColor.black
    let gray = UIColor.gray
    
    let todaysDate = Date()
    
    var limit : BooleanLiteralType = false
    var dateSeleted = ""
    
    
    
    //first string represents date but easier format to work with strings
    var eventsFromTheServer: [String: String] = [:]
    
    override func viewDidAppear(_ animated: Bool) {
//        plans = NSMutableArray(array:Bridging.queryForAllCalendar());
//
//        Bridging.queryForAllCalendar()
        plans = NSMutableArray(array:Bridging.queryForAllMeetings());
        plans.addObjects(from: Bridging.queryForAllAssignments());
        plans.addObjects(from: Bridging.queryForAllTasks());
        
//
        myTableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        plans = NSMutableArray(array:Bridging.queryForAllMeetings());
        plans.addObjects(from: Bridging.queryForAllAssignments());
        plans.addObjects(from: Bridging.queryForAllTasks());
//        for p in plans{
//            let dateFormattt = DateFormatter()
//            dateFormattt.dateStyle = .short
//            let d = dateFormattt.date(from: (p as! AssignmentObjc).time)
//            dates.append(dateFormattt.string(from: d!))
//        }
        
        myTableView.reloadData()
        super.viewDidLoad()
        UITextField.appearance().tintColor = .black 
        //
        DispatchQueue.global().asyncAfter(deadline: .now()){
//            let serverObjects = self.getServerEvents()
//            for (date, event) in serverObjects {
//                let stringDate = self.formatter.string(from: date)
//               // self.eventsFromTheServer[stringDate] = event
//            }
            DispatchQueue.main.async{
                self.calendarView.reloadData()
            }
        }
        
        //goes to todays date automatically
        calendarView.scrollToDate(Date(), animateScroll: false)
        calendarView.selectDates([Date()])
        // header.layer.backgroundColor = UIColor.green.cgColor
        // Do any additional setup after loading the view.
        setupCalendarView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
 /*CREATES THE TABLE TO DISPLAY ALL EVENTS*/
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if limit == true{
            return (sched.count)
        }else{
        return (plans.count)
        }
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScheduleTableViewCell
        if(plans.count == 0){
            cell.schedule.text = "You have no scheduled events"
        }else{
            
        let test = (plans[indexPath.row] as! AssignmentObjc).time
       
        if(limit == true){
            cell.schedule.text = (sched[indexPath.row] as! AssignmentObjc).lecture;
            cell.location.text = (sched[indexPath.row] as! AssignmentObjc).position;
            cell.time.text = (sched[indexPath.row] as! AssignmentObjc).time;
           // print("found")
        
        }else if (limit == false){
    print("limit is not true")
     
        
        cell.schedule.text = (plans[indexPath.row] as! AssignmentObjc).lecture;
        cell.location.text = (plans[indexPath.row] as! AssignmentObjc).position;
        cell.time.text = (plans[indexPath.row] as! AssignmentObjc).time;
        }
        }
        
        return cell
        
    
    }
    

    /*POP UP VIEW THAT ADDS A CLASS, MAYBE MOVE THIS??*/
    @IBAction func addClass(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "MainSwift", bundle:
            nil).instantiateViewController(withIdentifier:"timeTablePopUpID") as! TimeTablePopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    func setupCalendarView(){
        //calendar spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        //labels
        calendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
        
    }
    /*HANDLES CELL EVENTS*/
    func handleCellEvents(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell  else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
       
        validCell.eventDotView.isHidden = !dates.contains(dateFormatter.string(from: cellState.date))
       
        
        
    }
    /*CELL TEXT COLOUR*/
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell  else {
            return
        }
      
        let todaysDateString = formatter.string(from: todaysDate)
        let monthDateString = formatter.string(from: cellState.date)
        //TODAYS DATE
        if todaysDateString == monthDateString{
            validCell.dateLabel.textColor = UIColor.blue
            
        }
        else if cellState.isSelected {
            validCell.dateLabel.textColor = white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = black
            } else {
                validCell.dateLabel.textColor = gray
            }
        }
    }
    /*HANDLES IF CELL IS SELECTED
        CHANGES THE COLOUR OF THE CELL*/
    func handleCellSelected( view: JTAppleCell?, cellState: CellState) {
        
        guard let validcell = view as? CustomCell else {return}
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let datetoday = dateFormatter.string(from: todaysDate)
        if validcell.isSelected{
            dateSeleted = dateFormatter.string(from: cellState.date)
            //print(dateSeleted)
            for p in plans{
                if (p as! AssignmentObjc).time.contains(dateSeleted){
                    sched.add(p)
                }
                
                
            }
            if(datetoday == dateSeleted){
                print ("date is todays date")
                
            }
            limit = true
            myTableView.reloadData()
            validcell.selectedView.isHidden = false
        }else{
            limit = false
            sched.removeAllObjects()
            validcell.selectedView.isHidden = true
        }
    }
    
        func setupViewsOfCalendar (from visibleDates: DateSegmentInfo) {
            let date = visibleDates.monthDates.first!.date
            self.formatter.dateFormat = "yyyy"
            self.year.text = self.formatter.string(from: date)
            
            self.formatter.dateFormat = "MMMM"
            self.month.text = self.formatter.string(from: date)
        }
    



}

extension CalandarViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2018 02 01")!
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
           // numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            firstDayOfWeek: .sunday)
        

        return parameters
    }
    
    
        }



extension CalandarViewController : JTAppleCalendarViewDelegate {
    
    /*DISPLAYS THE CELL*/
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellEvents(view: cell, cellState: cellState)
        return cell
        
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
       
         handleCellSelected(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
                 handleCellSelected(view: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
        
    }
 

}
/*simulates getting from a server, actually gets from array of added classes*/
//extension CalandarViewController{
//    func getServerEvents() ->[Date] {
//        formatter.dateFormat = "yyyy MM dd"
//
//       // need to actually return events in data base
////        return {
////        for p in plans{
////        formatter.date(from (p as! AssignmentObjc).time)!:
////        }
////        }
//
////            formatter.date(from: "2017 09 29")!: "Test Event",
////            formatter.date(from: "2017 09 22")!: "Second Test Event",
////            formatter.date(from: "2017 10 14")!: "Third Test Event"
////    ]
//    }
//}

