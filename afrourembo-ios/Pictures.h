//
//  Pictures.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 11/21/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pictures : NSObject

@property NSString *picture;
@property NSString *pictureID;

/// UI property
@property (assign, nonatomic) BOOL isSelected;

@end
