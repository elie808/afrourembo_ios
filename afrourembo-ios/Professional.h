//
//  Professional.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/14/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Professional : NSObject

@property NSString *fName;
@property NSString *lName;
@property NSString *email;
@property NSString *password;

@property NSString *token;

@property NSArray *schedule;
@property NSArray *services;

@end
