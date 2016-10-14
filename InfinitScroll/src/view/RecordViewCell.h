//
//  RecordViewCell.h
//  InfinitScroll
//
//  Created by Gino Shen on 2016/10/14.
//  Copyright © 2016年 Gino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@end
