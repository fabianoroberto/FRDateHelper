//
//  DateHelper.h
//  Pods
//
//  Created by Fabiano Roberto on 20/05/16.
//
//

#import <Foundation/Foundation.h>

@interface DateHelper

+ (NSCalendar *) getCalendar;

+ (NSDate *) firstDayOfMonthContainingDate:(NSDate *) date;
+ (NSDate *) firstDayOfNextMonthContainingDate:(NSDate *)date;
+ (NSDate *) lastDayOfMonthContainingDate:(NSDate *)date;
+ (NSDate *) nextDay:(NSDate *) date;
+ (NSDate *) previousDay:(NSDate *) date;
+ (NSDate *) getDateFromYear:(NSInteger) year month:(NSInteger) month andDay:(NSInteger) day;
+ (NSDate *) addDay:(NSDate *)date;
+ (NSDate *) calculateEasterDateByYear:(NSInteger) year;
+ (NSDate *) setDateByDateString: (NSString *) date andFormat: (NSString *) format;
+ (NSDate *) getFirstDayOfThisMonth;
+ (NSDate *) getLastDayOfThisMonth;
+ (NSDate *) getFirstDayOfLastMonth;
+ (NSDate *) getLastDayOfLastMonth;
+ (NSDate *) getFirstDayOfThisSemester;
+ (NSDate *) getLastDayOfThisSemester;
+ (NSDate *) getFirstDayOfLastYear;
+ (NSDate *) getLastDayOfLastYear;
+ (NSDate *) getDateKeyByDate: (NSDate *) date;
+ (NSDate *) getStartDateByDate: (NSDate *) date;
+ (NSDate *) getEndDateByDate: (NSDate *) date;

+ (NSInteger) placeInWeekForDate:(NSDate *) date;
+ (NSInteger) numberOfWeeksInMonthContainingDate:(NSDate *)date;
+ (NSInteger) numberOfDaysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;
+ (NSInteger) getYearFromDate:(NSDate *)date;
+ (NSInteger) calculateDayNumber:(NSDate *)date;
+ (NSInteger) getMinutesFromTotalMinute: (NSNumber *) totalMinute;
+ (NSInteger) getHoursFromTotalMinute: (NSNumber *) totalMinute;
+ (NSInteger) getMinutesFromHour: (NSInteger) hour andMinute: (NSInteger) minute;

+ (BOOL) dateIsToday:(NSDate *)date;
+ (BOOL) date:(NSDate *)date1 isSameDayAsDate:(NSDate *)date2;
+ (BOOL) isHoliday: (NSDate *) date;

+ (NSString *) getWeekDay:(NSInteger) day;
+ (NSString *) getFirstDayOfThisYear;
+ (NSString *) getLastDayOfThisYear;
+ (NSString *) getFormattedStringByMinute: (NSNumber *) m sign: (NSInteger) sign andFormat: (NSString *) format;
+ (NSString *) setDateStringByDate: (NSDate *) date andFormat: (NSString *) format;
+ (NSString *) timeFormatted: (NSNumber *) totalMinute;

+ (NSNumber *) getThisYear;
+ (NSNumber *) getLastYear;

@end
