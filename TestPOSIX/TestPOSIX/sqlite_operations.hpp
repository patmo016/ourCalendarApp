/**
 Cosc345 Asn 2, sqlite_operations.hpp
 Purpose: provide a database to interact with the UI.
 
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

#ifndef sqlite_operations_hpp
#define sqlite_operations_hpp

#include <sqlite3.h>
#include <vector>
#include <string>

extern sqlite3 *db;
extern char *zErrMsg;
extern int rc;
extern const char *sql;
extern const char* data;

extern int callback(void *data, int argc, char **argv, char **azColName);
extern void deleter(char* times);
extern void selectBytime(char *times);
extern void view();
extern void updateName(char* timer, char* name);
extern void updatePosition(char* timer, char* positioner);
extern void insertAssignment(const char* lectures, const char* times, const char* positions);
extern void insertCalendarInfo(const char* classes, const char* starttime, const char* days, const char* weekly, const char* fortnightly, const char* location);
extern void insertCalendar(const char *row, const char *col, const char *content, const char *color); // TODO: Mr. Chen, I will leave this to you. You'll implement it in sqlite_operations.cpp file, just like insertAssignment. I'm too lazy to write those boilerplate codes. -- Yutong Zhang

extern long rowNumberInAssignmentsTable();
extern long rowNumberInNewAssignmentsTable();

class CalendarCpp {
public:
    int pkid;
    std::string classes;
    std::string starttime;
    std::string days;
    std::string weekly;
    std::string fortnightly;
    std::string location;
    
    CalendarCpp(int pkid, std::string classes, std::string starttime, std::string days, std::string weekly, std::string fortnightly, std::string location);
};
class AssignmentCpp {
public:
    int pkid;
    std::string lecture;
    std::string time;
    std::string position;
    
    AssignmentCpp(int pkid, std::string lecture, std::string time, std::string position);
};
extern std::vector<AssignmentCpp> queryForAllAssignments();
extern std::vector<AssignmentCpp> queryForAllMeetings();
extern std::vector<AssignmentCpp> queryForAllTasks();
extern std::vector<CalendarCpp> queryForAllCalendar();


extern void insertNewAssignmentCpp(AssignmentCpp asscpp);
extern void insertMeetingsCpp(AssignmentCpp asscpp);
extern void insertTasksCpp(AssignmentCpp asscpp);
extern void insertCalendarCpp(CalendarCpp calcpp);
extern bool deleteAssignmentById(int pkid);
extern bool deleteMeetingsById(int pkid);
extern bool deleteTasksById(int pkid);
extern bool deleteCalendarById(int pkid);

#endif /* sqlite_operations_hpp */
