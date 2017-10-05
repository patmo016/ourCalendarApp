/**
 Cosc345 Asn 2, TestPOSIX-Bridging-Header.mm
 Purpose: part of code that solve the IOS sandbox environment problem.
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

#import <Foundation/Foundation.h>
#import "TestPOSIX-Bridging-Header.hpp"
#import "AssignmentObjc.h"
#import "CalendarObjc.h"
#import "sqlite_operations.hpp"

#import "vector"
#import "string"
#import "functional"

using namespace std;

@interface Bridging ()

@end

@implementation Bridging

+ (NSArray *)convertToAssignmentObjcArrayWithAssignmentCppVector:(vector<AssignmentCpp>)vasscpp {
    vector<AssignmentObjc *> outVec;
    outVec.resize(vasscpp.size());
    transform(vasscpp.begin(), vasscpp.end(), outVec.begin(), [](AssignmentCpp asscpp){
        return [AssignmentObjc assignmentObjcWithAssignmentCpp:asscpp];
    });
    return [NSArray arrayWithObjects:&outVec[0] count:outVec.size()];
}

+ (NSArray *)convertToCalendarObjcArrayWithCalendarCppVector:(vector<CalendarCpp>)vcalcpp {
    vector<CalendarObjc *> outcalVec;
    outcalVec.resize(vcalcpp.size());
    transform(vcalcpp.begin(), vcalcpp.end(), outcalVec.begin(), [](CalendarCpp calcpp){
        return [CalendarObjc calendarObjcWithCalendarCpp:calcpp];
    });
    return [NSArray arrayWithObjects:&outcalVec[0] count:outcalVec.size()];
}




+ (NSArray *)queryForAllAssignments {
    auto assVec = queryForAllAssignments();
    return [Bridging convertToAssignmentObjcArrayWithAssignmentCppVector:assVec];
}

+ (NSArray *)queryForAllMeetings {
    auto assVec = queryForAllMeetings();
    return [Bridging convertToAssignmentObjcArrayWithAssignmentCppVector:assVec];
}

+ (NSArray *)queryForAllTasks {
    auto assVec = queryForAllTasks();
    return [Bridging convertToAssignmentObjcArrayWithAssignmentCppVector:assVec];
}

+ (NSArray *)queryForAllCalendars {
    auto calVec = queryForAllCalendar();
    return [Bridging convertToCalendarObjcArrayWithCalendarCppVector:calVec];
}



+ (void)updateNewAssignmentBynameCpp:(AssignmentCpp)asscpp {
    updateNewAssignmentBynameCpp(asscpp);
}

+ (void)updateTasksCpp:(AssignmentCpp)asscpp {
    updateTasksCpp(asscpp);
}

+ (void)updateMeetingsCpp:(AssignmentCpp)asscpp {
    updateMeetingsCpp(asscpp);
}

+ (void)updateNewAssignmentByposCpp:(AssignmentCpp)asscpp {
    updateNewAssignmentByposCpp(asscpp);
}

+ (void)updateNameByNameCpp:(AssignmentCpp)asscpp {
    updateNameByNameCpp(asscpp);
}


+ (void)insertNewAssignmentCpp:(AssignmentCpp)asscpp {
    insertNewAssignmentCpp(asscpp);
}

+ (void)insertMeetingsCpp:(AssignmentCpp)asscpp {
    insertMeetingsCpp(asscpp);
}

+ (void)insertTasksCpp:(AssignmentCpp)asscpp {
    insertTasksCpp(asscpp);
}

+ (void)insertCalendarCpp:(CalendarCpp)calcpp {
    insertCalendarCpp(calcpp);
}


+ (void)updateNewAssignmentBynameObjc:(AssignmentObjc *)assobjc {
    [Bridging updateNewAssignmentBynameCpp:assignmentCppFromAssignmentObjc(assobjc)];
}

+ (void)updateNewAssignmentByposObjc:(AssignmentObjc *)assobjc {
    [Bridging updateNewAssignmentByposCpp:assignmentCppFromAssignmentObjc(assobjc)];
}

+ (void)updateNameByNameObjc:(AssignmentObjc *)assobjc {
    [Bridging updateNameByNameCpp:assignmentCppFromAssignmentObjc(assobjc)];
}


+ (void)updateTasksObjc:(AssignmentObjc *)assobjc {
    [Bridging updateTasksCpp:assignmentCppFromAssignmentObjc(assobjc)];
}


+ (void)updateMeetingsObjc:(AssignmentObjc *)assobjc {
    [Bridging updateMeetingsCpp:assignmentCppFromAssignmentObjc(assobjc)];
}

+ (void)insertNewAssignmentObjc:(AssignmentObjc *)assobjc {
    [Bridging insertNewAssignmentCpp:assignmentCppFromAssignmentObjc(assobjc)];
}

+ (void)insertMeetingsObjc:(AssignmentObjc *)assobjc {
    [Bridging insertMeetingsCpp:assignmentCppFromAssignmentObjc(assobjc)];
}

+ (void)insertTasksObjc:(AssignmentObjc *)assobjc {
    [Bridging insertTasksCpp:assignmentCppFromAssignmentObjc(assobjc)];
}

+ (void)insertCalendarObjc:(CalendarObjc *)calobjc {
    [Bridging insertCalendarCpp:calendarCppFromCalendarObjc(calobjc)];
}

+ (BOOL)deleteAssignmentById:(NSNumber *)pkid {
    return deleteAssignmentById([pkid intValue]);
}

+ (BOOL)deleteMeetingsById:(NSNumber *)pkid {
    return deleteMeetingsById([pkid intValue]);
}

+ (BOOL)deleteTasksById:(NSNumber *)pkid {
    return deleteTasksById([pkid intValue]);
}

+ (BOOL)deleteCalendarById:(NSNumber *)pkid {
    return deleteCalendarById([pkid intValue]);
}




/*+ (void)insertNewCalendarCpp:(CalendarCpp)calcpp {
 insertNewCalendarCpp(calcpp);
 }*/






@end

