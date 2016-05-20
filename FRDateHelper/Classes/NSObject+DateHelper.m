//
//  NSObject+DateHelper.m
//  Pods
//
//  Created by Fabiano Roberto on 20/05/16.
//
//

#import "NSObject+DateHelper.h"

@implementation NSObject (DateHelper)

#pragma mark - Calendar helpers

+ (NSCalendar *) getCalendar {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setLocale:[NSLocale currentLocale]];
    
    return calendar;
}

+ (NSDate *) firstDayOfMonthContainingDate:(NSDate *) date {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    comps.day = 1;
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *)firstDayOfNextMonthContainingDate:(NSDate *)date {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    comps.day = 1;
    comps.month = comps.month + 1;
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *)lastDayOfMonthContainingDate:(NSDate *)date {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    comps.day = 0;
    comps.month = comps.month + 1;
    
    return [calendar dateFromComponents:comps];
}

+ (NSInteger) placeInWeekForDate:(NSDate *) date {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *compsFirstDayInMonth = [calendar components:NSCalendarUnitWeekday fromDate:date];
    return (compsFirstDayInMonth.weekday - 1 - calendar.firstWeekday + 8) % 7;
}

+ (BOOL)dateIsToday:(NSDate *)date {
    return [self date:[NSDate date] isSameDayAsDate:date];
}

+ (BOOL)date:(NSDate *)date1 isSameDayAsDate:(NSDate *)date2 {
    NSCalendar *calendar = [self getCalendar];
    // Both dates must be defined, or they're not the same
    if (date1 == nil || date2 == nil) {
        return NO;
    }
    
    NSDateComponents *day = [calendar components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date1];
    NSDateComponents *day2 = [calendar components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date2];
    return ([day2 day] == [day day] &&
            [day2 month] == [day month] &&
            [day2 year] == [day year] &&
            [day2 era] == [day era]);
}

+ (NSInteger)numberOfWeeksInMonthContainingDate:(NSDate *)date {
    NSCalendar *calendar = [self getCalendar];
    
    return [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date].length;
}

+ (NSDate *) nextDay:(NSDate *) date {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [calendar dateByAddingComponents:comps toDate:date options:0];
}

+ (NSDate *) previousDay:(NSDate *) date {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:-1];
    
    return [calendar dateByAddingComponents:comps toDate:date options:0];
}

+ (NSInteger)numberOfDaysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
    NSCalendar *calendar = [self getCalendar];
    NSDate *fromDate;
    NSDate *toDate;
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:startDate];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:endDate];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

+ (NSInteger) getYearFromDate:(NSDate *)date {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    return [components year];
}

+ (NSString *) getWeekDay:(NSInteger) day {
    NSCalendar *calendar = [self getCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSArray *weekdays = [dateFormatter shortWeekdaySymbols];
    
    NSUInteger firstWeekdayIndex = [calendar firstWeekday] - 1;
    if (firstWeekdayIndex > 0) {
        weekdays = [[weekdays subarrayWithRange:NSMakeRange(firstWeekdayIndex, 7 - firstWeekdayIndex)]
                    arrayByAddingObjectsFromArray:[weekdays subarrayWithRange:NSMakeRange(0, firstWeekdayIndex)]];
    }
    
    return [[weekdays objectAtIndex:day] uppercaseString];
}

+ (NSDate *) getDateFromYear:(NSInteger) year month:(NSInteger) month andDay:(NSInteger) day {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    
    return [calendar dateFromComponents:components];
}

+ (NSDate *)addDay:(NSDate *)date {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    components.day = components.day + 1;
    
    return [calendar dateFromComponents:components];
}

+ (NSString *) getFirstDayOfThisYear {
    NSCalendar *calendar = [self getCalendar];
    NSDate *date = [NSDate date];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    [components setDay:1];
    [components setMonth:1];
    
    return [self setDateStringByDate:[calendar dateFromComponents:components] andFormat:@"yyyyMMdd"];
}

+ (NSString *) getLastDayOfThisYear {
    NSCalendar *calendar = [self getCalendar];
    NSDate *date = [NSDate date];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    [components setDay:31];
    [components setMonth:12];
    
    return [self setDateStringByDate:[calendar dateFromComponents:components] andFormat:@"yyyyMMdd"];
}

+ (NSInteger)calculateDayNumber:(NSDate *)date {
    NSInteger placeInWeek = [self placeInWeekForDate:date];
    
    return placeInWeek;
}

+ (NSDate *) calculateEasterDateByYear:(NSInteger) year {
    NSInteger C = floor(year/100);
    NSInteger N = year - (19 * floor(year/19));
    NSInteger K = floor((C - 17)/25);
    NSInteger I = C - floor(C/4) - floor((C - K)/3) + 19 * N + 15;
    
    I = I - 30 * floor((I/30));
    I = I - floor(I/28) * (1 - floor(I/28) * floor(29/(I + 1)) * floor((21 - N)/11));
    
    NSInteger J = year + floor(year/4) + I + 2 - C + floor(C/4);
    J = J - 7 * floor(J/7);
    
    NSInteger L = I - J;
    NSInteger month = 3 + floor((L + 40)/44);
    NSInteger day = L + 28 - 31 * floor(month/4);
    
    return [self getDateFromYear:year month:month andDay:day];
}

+ (BOOL) isHoliday: (NSDate *) date {
    NSCalendar *calendar = [self getCalendar];
    
    BOOL isHoliday = false;
    NSInteger year = [self getYearFromDate:date];
    NSInteger weekday = [[calendar components:NSCalendarUnitWeekday fromDate:date] weekday];
    
    NSDate *newYearDay = [self getDateFromYear:year month:1 andDay:1];
    NSDate *epiphanyDay = [self getDateFromYear:year month:1 andDay:6];
    NSDate *sundayEasterDay = [self calculateEasterDateByYear:year];
    NSDate *mondayEasterDay = [self addDay:sundayEasterDay];
    NSDate *liberationDay = [self getDateFromYear:year month:4 andDay:25];
    NSDate *laborDay = [self getDateFromYear:year month:5 andDay:1];
    NSDate *republicDay = [self getDateFromYear:year month:6 andDay:2];
    NSDate *assumptionDay = [self getDateFromYear:year month:8 andDay:15];
    NSDate *allSaintDay = [self getDateFromYear:year month:11 andDay:2];
    NSDate *immaculateDay = [self getDateFromYear:year month:12 andDay:8];
    NSDate *christmasDay = [self getDateFromYear:year month:12 andDay:25];
    NSDate *sStephanDay = [self getDateFromYear:year month:12 andDay:26];
    
    if ([date isEqualToDate:newYearDay] || [date isEqualToDate:epiphanyDay] || [date isEqualToDate:sundayEasterDay] || [date isEqualToDate:mondayEasterDay] || [date isEqualToDate:liberationDay] || [date isEqualToDate:laborDay] || [date isEqualToDate:republicDay] || [date isEqualToDate:assumptionDay] || [date isEqualToDate:allSaintDay] || [date isEqualToDate:immaculateDay] || [date isEqualToDate:christmasDay] || [date isEqualToDate:sStephanDay] || weekday == 1) {
        isHoliday = true;
    }
    
    return isHoliday;
}

+ (NSString *) setDateStringByDate: (NSDate *) date andFormat: (NSString *) format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    return stringFromDate;
}

+ (NSDate *) setDateByDateString: (NSString *) date andFormat: (NSString *) format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    NSDate *dateFromString = [formatter dateFromString:date];
    
    return dateFromString;
}

+ (NSDate *) getFirstDayOfThisMonth {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    
    [comps setDay:1];
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *) getFirstDayOfLastMonth {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    
    [comps setDay:1];
    [comps setMonth:comps.month - 1];
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *) getLastDayOfThisMonth {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    
    NSUInteger numberOfDaysInMonth = range.length;
    [comps setDay:numberOfDaysInMonth];
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *) getLastDayOfLastMonth {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    
    [comps setMonth:comps.month - 1];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[calendar dateFromComponents:comps]];
    
    NSUInteger numberOfDaysInMonth = range.length;
    [comps setDay:numberOfDaysInMonth];
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *) getFirstDayOfThisSemester {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    
    if (comps.month <= 6) {
        comps.month = 1;
    } else {
        comps.month = 7;
    }
    
    comps.day = 1;
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *) getLastDayOfThisSemester {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    
    if (comps.month <= 6) {
        comps.month = 6;
    } else {
        comps.month = 12;
    }
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[calendar dateFromComponents:comps]];
    
    NSUInteger numberOfDaysInMonth = range.length;
    [comps setDay:numberOfDaysInMonth];
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *) getDateKeyByDate: (NSDate *) date {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:date];
    
    return [calendar dateFromComponents:components];
}

+ (NSNumber *) getThisYear {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return [NSNumber numberWithInteger:[comps year]];
}

+ (NSNumber *) getLastYear {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    comps.year = comps.year -1;
    
    return [NSNumber numberWithInteger:[comps year]];
}

+ (NSDate *) getFirstDayOfLastYear {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    comps.year = comps.year -1;
    comps.month = 1;
    comps.day = 1;
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *) getLastDayOfLastYear {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    comps.year = comps.year -1;
    comps.month = 12;
    comps.day = 31;
    
    return [calendar dateFromComponents:comps];
}

+ (NSDate *) getStartDateByDate: (NSDate *) date {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    return [calendar dateFromComponents:components];
}

+ (NSDate *) getEndDateByDate: (NSDate *) date {
    NSCalendar *calendar = [self getCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    components.day = components.day + 1;
    
    return [calendar dateFromComponents:components];
}

+ (NSString *) getFormattedStringByMinute: (NSNumber *) m sign: (NSInteger) sign andFormat: (NSString *) format {
    NSString *toReturn;
    
    if (m == 0) {
        toReturn = @"";
    } else {
        NSInteger calcH = [self getHoursFromTotalMinute:m] * sign;
        NSInteger calcM = [self getMinutesFromTotalMinute:m];
        
        toReturn = [NSString stringWithFormat:format, (long)calcH, (long)calcM];
    }
    
    return toReturn;
}

+ (NSString *) timeFormatted: (NSNumber *) totalMinute {
    NSInteger minutes = [self getMinutesFromTotalMinute:totalMinute];
    NSInteger hours = [self getHoursFromTotalMinute:totalMinute];
    
    return [NSString stringWithFormat:@"%ld:%02ld", (long) hours, labs(minutes)];
}

+ (NSInteger) getMinutesFromTotalMinute: (NSNumber *) totalMinute {
    return [totalMinute intValue] % 60;
}

+ (NSInteger) getHoursFromTotalMinute: (NSNumber *) totalMinute {
    return [totalMinute intValue] / 60;
}

+ (NSInteger) getMinutesFromHour: (NSInteger) hour andMinute: (NSInteger) minute {
    return (hour * 60) + minute;
}

@end