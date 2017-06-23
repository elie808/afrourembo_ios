//
//  Category+API.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Category.h"
#import "Service+API.h"
#import <RestKit/RestKit.h>
#import "EKNetworkingConstants.h"

typedef void (^CategoriesSuccessBlock)(NSArray<Category*> *categoriesArray);
typedef void (^CategoriesErrorBlock)(NSError *error, NSString *errorMessage, NSInteger statusCode);

@interface Category (API)

// categoryId, categoryName, categoryGender, categoryServices, categoryIcon
+ (RKObjectMapping *)map1;

/// Maps the returned reponse from the GET categories call
+ (RKResponseDescriptor *)categoryResponseDescriptor;

/**
 Returns all the available Categories in an array. No authentication needed.
 
 @param successBlock Server will return the categories and their corresponding services
 @param errorBlock Server error logging
 */
+ (void)getCategoriesWithBlock:(CategoriesSuccessBlock)successBlock withErrors:(CategoriesErrorBlock)errorBlock;

@end
