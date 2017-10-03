/**
 Cosc345 Asn 2, TestPOSIX-Bridging-Header.h
 Purpose: part of code that solve the IOS sandbox environment problem.
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */
#import "AssignmentObjc.hm"
#import "CalendarObjc.hm"

@interface Bridging : NSObject

+ (NSArray *)queryForAllAssignments;

+ (NSArray *)queryForAllMeetings;

+ (NSArray *)queryForAllTasks;

+ (NSArray *)queryForAllCalendar;


+ (void)insertNewAssignmentObjc:(AssignmentObjc *)assobjc;

+ (void)insertMeetingsObjc:(AssignmentObjc *)assobjc;

+ (void)insertTasksObjc:(AssignmentObjc *)assobjc;

+ (void)insertCalendarObjc:(CalendarObjc *)calobjc;

+ (BOOL)deleteAssignmentById:(NSNumber *)pkid;

+ (BOOL)deleteMeetingsById:(NSNumber *)pkid;

+ (BOOL)deleteTasksById:(NSNumber *)pkid;




+ (BOOL)deleteCalendarById:(NSNumber *)pkid;

@end
