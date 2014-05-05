//UserProf.h
/*
Holds the user information that 
will eventaully be sent to the API
It is also used to parse results

Created by Daniel Whitcomb 2014-03-17 
*/

#import <Foundation/Foundation.h>

@interface UserProf : NSObject

@property NSString* type;
@property NSMutableArray* locations; //SimplyHired doesn't support multi-location search. Will need to make multiple requests for each location
@property NSString* radius;
@property NSString* organization;

@end
