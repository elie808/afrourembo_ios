//
//  ProfilePicture+API.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 8/19/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "ProfilePicture+API.h"

@implementation ProfilePicture (API)

#pragma mark - Mapping

#pragma mark - Response

+ (RKResponseDescriptor *)postUserProfilePictureResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Customer map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kUserProfilePictureAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)postProfessionalProfilePictureResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kProfessionalPictureAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

+ (RKResponseDescriptor *)postProfessionalPortfolioPictureResponseDescriptor {
    
    RKResponseDescriptor *response = [RKResponseDescriptor
                                      responseDescriptorWithMapping:[Professional map1]
                                      method:RKRequestMethodPOST
                                      pathPattern:kProfessionalPortfolioAPIPath
                                      keyPath:nil
                                      statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return response;
}

#pragma mark - APIs

+ (void)uploadCustomerProfilePicture:(NSData *)imageData withToken:(NSString *)userToken withBlock:(UserProfilePictureSuccessBlock)successBlock withErrors:(UserProfilePictureErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:userToken];
    
    NSMutableURLRequest *request = [[RKObjectManager sharedManager]
                                    multipartFormRequestWithObject:nil
                                    method:RKRequestMethodPOST
                                    path:kUserProfilePictureAPIPath
                                    parameters:nil
                                    constructingBodyWithBlock:^(id<AFRKMultipartFormData> formData) {
                                        
//                                        NSLog(@"Original image size: %@",[NSByteCountFormatter stringFromByteCount:imageData.length countStyle:NSByteCountFormatterCountStyleFile]);
                                        
                                        [formData appendPartWithFileData:imageData
                                                                    name:@"stream"
                                                                fileName:@"profilePicture.png"
                                                                mimeType:@"image/png"];
                                        
                                    }];
    
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] objectRequestOperationWithRequest:request success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSLog(@"!!! SUCCESS PUTTING PROFILE PICTURE !!!");
        
        if (mappingResult.array.count > 0) {
            
            Customer *customer = [mappingResult.array firstObject];
            successBlock(customer);
            
        } else {
            
            successBlock(nil);
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        if (operation.HTTPRequestOperation.responseData) {
            
            // exctract error message
            NSDictionary *myDic = [NSJSONSerialization
                                   JSONObjectWithData:operation.HTTPRequestOperation.responseData
                                   options:NSJSONReadingMutableLeaves
                                   error:nil];
            
            NSString *errorMessage = [myDic valueForKey:@"message"];
            
            NSNumber *statusCode = [myDic valueForKey:@"statusCode"];
            
            NSLog(@"-------ERROR MESSAGE: %@", errorMessage);
            errorBlock(error, errorMessage, [statusCode integerValue]);
            
        } else {
            
            errorBlock(error, @"You are not connected to the internet.", 0);
        }
    }];
    
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation]; // NOTE: Must be enqueued rather than started
}

+ (void)uploadProfessionalProfilePicture:(NSData *)imageData withToken:(NSString *)userToken withBlock:(ProfessionalProfilePictureSuccessBlock)successBlock withErrors:(UserProfilePictureErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:userToken];
    
    NSMutableURLRequest *request = [[RKObjectManager sharedManager]
                                    multipartFormRequestWithObject:nil
                                    method:RKRequestMethodPOST
                                    path:kProfessionalPictureAPIPath
                                    parameters:nil
                                    constructingBodyWithBlock:^(id<AFRKMultipartFormData> formData) {
                                        
                                        //                                        NSLog(@"Original image size: %@",[NSByteCountFormatter stringFromByteCount:imageData.length countStyle:NSByteCountFormatterCountStyleFile]);
                                        
                                        [formData appendPartWithFileData:imageData
                                                                    name:@"stream"
                                                                fileName:@"profilePicture.png"
                                                                mimeType:@"image/png"];
                                        
                                    }];
    
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] objectRequestOperationWithRequest:request success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSLog(@"!!! SUCCESS PUTTING PROFILE PICTURE !!!");
        
        if (mappingResult.array.count > 0) {
            
            Professional *professional = [mappingResult.array firstObject];
            successBlock(professional);
            
        } else {
            
            successBlock(nil);
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        if (operation.HTTPRequestOperation.responseData) {
            
            // exctract error message
            NSDictionary *myDic = [NSJSONSerialization
                                   JSONObjectWithData:operation.HTTPRequestOperation.responseData
                                   options:NSJSONReadingMutableLeaves
                                   error:nil];
            
            NSString *errorMessage = [myDic valueForKey:@"message"];
            
            NSNumber *statusCode = [myDic valueForKey:@"statusCode"];
            
            NSLog(@"-------ERROR MESSAGE: %@", errorMessage);
            errorBlock(error, errorMessage, [statusCode integerValue]);
            
        } else {
            
            errorBlock(error, @"You are not connected to the internet.", 0);
        }
    }];
    
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation]; // NOTE: Must be enqueued rather than started
}

+ (void)uploadProfessionalPortfolioPicture:(NSData *)imageData withToken:(NSString *)userToken withBlock:(ProfessionalProfilePictureSuccessBlock)successBlock withErrors:(UserProfilePictureErrorBlock)errorBlock {
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Authorization" value:userToken];
    
    NSMutableURLRequest *request = [[RKObjectManager sharedManager]
                                    multipartFormRequestWithObject:nil
                                    method:RKRequestMethodPOST
                                    path:kProfessionalPortfolioAPIPath
                                    parameters:nil
                                    constructingBodyWithBlock:^(id<AFRKMultipartFormData> formData) {
                                        
                                        //                                        NSLog(@"Original image size: %@",[NSByteCountFormatter stringFromByteCount:imageData.length countStyle:NSByteCountFormatterCountStyleFile]);
                                        
                                        [formData appendPartWithFileData:imageData
                                                                    name:@"stream"
                                                                fileName:@"profilePicture.png"
                                                                mimeType:@"image/png"];
                                        
                                    }];
    
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] objectRequestOperationWithRequest:request success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSLog(@"!!! SUCCESS PUTTING PORTFOLIO PICTURE !!!");
        
        if (mappingResult.array.count > 0) {
            
            Professional *professional = [mappingResult.array firstObject];
            successBlock(professional);
            
        } else {
            
            successBlock(nil);
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        if (operation.HTTPRequestOperation.responseData) {
            
            // exctract error message
            NSDictionary *myDic = [NSJSONSerialization
                                   JSONObjectWithData:operation.HTTPRequestOperation.responseData
                                   options:NSJSONReadingMutableLeaves
                                   error:nil];
            
            NSString *errorMessage = [myDic valueForKey:@"message"];
            
            NSNumber *statusCode = [myDic valueForKey:@"statusCode"];
            
            NSLog(@"-------ERROR MESSAGE: %@", errorMessage);
            errorBlock(error, errorMessage, [statusCode integerValue]);
            
        } else {
            
            errorBlock(error, @"You are not connected to the internet.", 0);
        }
    }];
    
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation]; // NOTE: Must be enqueued rather than started
}

@end
