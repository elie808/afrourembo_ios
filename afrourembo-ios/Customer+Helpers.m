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
        
        [retrievedUser setValue:obj forKey:(NSString *)key];
    }];
    
    return retrievedUser;
}

+ (Customer *)updateCustomer:(Customer *)existingCustomer from:(Customer *)newCustomer {
    
    Customer *delta = [Customer new];
    
    delta.token = newCustomer.token.length > 0 ? newCustomer.token : existingCustomer.token;
    
    return delta;
}

#pragma mark - Helpers

- (NSString *)convertToJSON {
    
    NSDictionary *details = @{
                              @"token" : self.token.length > 0 ? self.token : @""
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
