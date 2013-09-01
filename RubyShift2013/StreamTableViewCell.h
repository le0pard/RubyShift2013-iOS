//
//  StreamTableViewCell.h
//  RubyShift2013
//
//  Created by Alex on 9/1/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StreamTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *twitterStatus;

+ (CGFloat)heightForCellWithTwit:(NSDictionary *)twitterStatus;

@end
