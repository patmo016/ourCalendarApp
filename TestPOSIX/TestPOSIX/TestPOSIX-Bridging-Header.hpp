/**
 Cosc345 Asn 2, TestPOSIX-Bridging-Header.hpp
 Purpose: part of code that solve the IOS sandbox environment problem.
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

#ifndef TestPOSIX_Bridging_Header_h
#define TestPOSIX_Bridging_Header_h

#import "AssignmentObjc.h"
#import "CalendarObjc.h"
#import "vector"

AssignmentCpp assignmentCppFromAssignmentObjc(AssignmentObjc *assobjc);
CalendarCpp calendarCppFromCalendarObjc(CalendarObjc *calobjc);

@interface Bridging : NSObject

+ (NSArray *)convertToAssignmentObjcArrayWithAssignmentCppVector:(std::vector<AssignmentCpp>)vasscpp;

+ (NSArray *)convertToCalendarObjcArrayWithCalendarCppVector:(std::vector<CalendarCpp>)vcalcpp;

+ (NSArray *)queryForAllAssignments;

+ (NSArray *)queryForAllMeetings;

+ (NSArray *)queryForAllTasks;

+ (NSArray *)queryForAllCalendar;

+ (void)insertNewAssignmentCpp:(AssignmentCpp)asscpp;

+ (void)insertMeetingsObjc:(AssignmentObjc *)assobjc;

+ (void)insertTasksObjc:(AssignmentObjc *)assobjc;

+ (void)insertCalendarObjc:(CalendarObjc *)calobjc;

+ (BOOL)deleteAssignmentById:(NSNumber *)pkid;


+ (NSArray *)queryForAllCalendars;


+ (BOOL)deleteCalendarById:(NSNumber *)pkid;

@end

#endif /* TestPOSIX_Bridging_Header_h */
