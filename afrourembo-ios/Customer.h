//
//  Customer.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/30/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject

// signup
@property NSString *email;
@property NSString *password;
@property NSString *token;

// profile
@property NSString *fName;
@property NSString *lName;
@property NSString *phone;

@end
