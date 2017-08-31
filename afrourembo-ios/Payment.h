//
//  Payment.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/26/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Payment : NSObject

@property NSString *description;
@property NSString *currency;
@property NSNumber *orderTotal;
@property NSString *fName;
@property NSString *lName;
@property NSString *email;
@property NSString *mobile;
@property NSString *bookingID;

@end
