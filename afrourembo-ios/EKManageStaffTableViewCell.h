//
//  EKManageStaffTableViewCell.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 12/2/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EKManageStaffCellDelegate <NSObject>
- (void)acceptStaffAtIndex:(NSIndexPath *)indexPath;
- (void)declineStaffAtIndex:(NSIndexPath *)indexPath;
@end

@interface EKManageStaffTableViewCell : UITableViewCell

@property (assign, nonatomic) id<EKManageStaffCellDelegate> cellDelegate;
@property (strong, nonatomic) NSIndexPath *cellIndexPath;

@property (strong, nonatomic) IBOutlet UIImageView *cellImageView;
@property (strong, nonatomic) IBOutlet UILabel *cellProfessionalNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellEmailLabel;
@property (strong, nonatomic) IBOutlet UIButton *cellAcceptButton;
@property (strong, nonatomic) IBOutlet UIButton *cellDeclineButton;

@end
