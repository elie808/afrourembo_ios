//
//  Customer+Helpers.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/27/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Customer+Helpers.h"

@implementation Customer (Helpers)

+ (Customer *)customerFromJSON:(NSString *)customerJSONString {
    
    NSData *data = [customerJSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    Customer *retrievedUser = [Customer new];
    
    [jsonDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {

        // since portfolio array (of Pictures objects) is saved as a dictionary,
        // we manually convert it to an NSArray of NSObjects. bullshit of course :[
        if ( [(NSString *)key isEqualToString:@"favorites"] ) {
            
            NSMutableArray *favoritesArray = [NSMutableArray new];
            
            for (NSDictionary *portfolioDict in [jsonDictionary valueForKey:@"favorites"]) {
                
                Favorite *favObj = [Favorite new];
                favObj.userId = [portfolioDict valueForKey:@"userId"];
                favObj.userType = [portfolioDict valueForKey:@"userType"];
                favObj.serverID = [portfolioDict valueForKey:@"serverID"];
                [favoritesArray addObject:favObj];
            }
            
            retrievedUser.favorites = [NSArray arrayWithArray:favoritesArray];
            
        } else {
            
            [retrievedUser setValue:obj forKey:(NSString *)key];
        }
    }];
    
    return retrievedUser;
}

+ (Customer *)updateCustomer:(Customer *)existingCustomer from:(Customer *)newCustomer {
    
    Customer *delta = [Customer new];
    
    delta.fName = newCustomer.fName.length > 0 ? newCustomer.fName : existingCustomer.fName;
    delta.lName = newCustomer.lName.length > 0 ? newCustomer.lName : existingCustomer.lName;
    delta.phone = newCustomer.phone.length > 0 ? newCustomer.phone : existingCustomer.phone;
    delta.email = newCustomer.email.length > 0 ? newCustomer.email : existingCustomer.email;
    delta.profilePicture = newCustomer.profilePicture.length > 0 ? newCustomer.profilePicture : existingCustomer.profilePicture;
    delta.token = newCustomer.token.length > 0 ? newCustomer.token : existingCustomer.token;
    
    delta.passwordSet = newCustomer.passwordSet;
    delta.profileComplete = newCustomer.profileComplete;
    
    delta.favorites = [NSArray arrayWithArray:newCustomer.favorites];
    
    return delta;
}

#pragma mark - Helpers

- (NSString *)convertToJSON {

    NSMutableArray *favoritesArray = [NSMutableArray new];
    for (Favorite *favObj in self.favorites) {
        
        [favoritesArray addObject:@{@"userId":favObj.userId,
                                    @"userType":favObj.userType,
                                    @"serverID":favObj.serverID
                                    }];
    }
    
    NSDictionary *details = @{
                              @"fName" : self.fName.length > 0 ? self.fName : @"",
                              @"lName" : self.lName.length > 0 ? self.lName : @"",
                              @"phone" : self.phone.length > 0 ? self.phone : @"",
                              @"email" : self.email.length > 0 ? self.email : @"",
                              @"profilePicture" : self.profilePicture.length > 0 ? self.profilePicture : @"",
                              @"token" : self.token.length > 0 ? self.token : @"",
                              @"favorites" : favoritesArray.count > 0 ? favoritesArray : [NSArray new],
                              @"profileComplete" : [NSNumber numberWithBool:self.profileComplete],
                              @"passwordSet" : [NSNumber numberWithBool:self.passwordSet],
                              };
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:details
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (!jsonData) {
        
        NSLog(@"Got an error converting to JSONString: %@", error);
        return nil;
        
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
}

@end
