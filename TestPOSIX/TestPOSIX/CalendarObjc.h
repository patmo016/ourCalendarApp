/**
 Cosc345 Asn 2, CalendarObjc.h
 Purpose: part of code that solve the IOS sandbox environment problem.
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

#import <Foundation/Foundation.h>
#import "sqlite_operations.hpp"

@interface CalendarObjc : NSObject

@property (readonly) NSNumber *pkid;
@property (readonly) NSString *classes;
@property (readonly) NSString *starttime;
@property (readonly) NSString *days;
@property (readonly) NSString *weekly;
@property (readonly) NSString *fortnightly;
@property (readonly) NSString *location;


- (instancetype)initWithPkid:(NSNumber *)pkid classes:(NSString *)classes starttime:(NSString *)starttime days:(NSString *)days weekly:(NSString *)weekly fortnightly:(NSString *)fortnightly location:(NSString *)location;

- (instancetype)initWithCalendarCpp:(CalendarCpp)calCpp;

+ (instancetype)calendarObjcWithPkid:(NSNumber *)pkid classes:(NSString *)classes starttime:(NSString *)starttime days:(NSString *)days weekly:(NSString *)weekly fortnightly:(NSString *)fortnightly location:(NSString *)location;

+ (instancetype)calendarObjcWithCalendarCpp:(CalendarCpp)calCpp;

- (CalendarCpp)toCalendarCpp;

@end

CalendarCpp calendarCppFromCalendarObjc(CalendarObjc *calobjc);

