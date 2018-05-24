//
//  Bank.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/16/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bank : NSObject

@property NSString *bankID; // to map the id field from responses
@property NSString *bankId; // to use when posting payment info...
@property NSString *name;

@property NSString *fName;
@property NSString *lName;
@property NSString *accountNumber;

@end
