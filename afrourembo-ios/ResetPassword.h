//
//  ResetPassword.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/9/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResetPassword : NSObject

@property NSString *phoneNumber;
@property NSString *resetCode;
@property NSString *userPassword; //can't use "newPassword" because of cocoa naming convetions x(

@end
