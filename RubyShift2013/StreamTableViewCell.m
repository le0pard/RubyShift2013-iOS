//
//  StreamTableViewCell.m
//  RubyShift2013
//
//  Created by Alex on 9/1/13.
//  Copyright (c) 2013 Alexey Vasyliev. All rights reserved.
//

#import "StreamTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation StreamTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    self.detailTextLabel.numberOfLines = 0;
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return self;
}

- (void)setTwitterStatus:(NSDictionary *)twitterStatus {
    _twitterStatus = twitterStatus;
    
    self.textLabel.text = _twitterStatus[@"user"][@"screen_name"];
    self.detailTextLabel.text = [_twitterStatus valueForKey:@"text"];
    [self.imageView setImageWithURL:[NSURL URLWithString:_twitterStatus[@"user"][@"profile_image_url"]] placeholderImage:[UIImage imageNamed:@"first.png"]];
    
    [self setNeedsLayout];
}

+ (CGFloat)heightForCellWithTwit:(NSDictionary *)twitterStatus andWidth:(CGFloat) width {
    CGSize sizeToFit = [[twitterStatus valueForKey:@"text"] sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(width - 100, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    return fmaxf(70.0f, sizeToFit.height + 45.0f);
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10.0f, 10.0f, 50.0f, 50.0f);
    self.textLabel.frame = CGRectMake(70.0f, 10.0f, self.contentView.frame.size.width - 80, 20.0f);
    
    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
    detailTextLabelFrame.size.height = [[self class] heightForCellWithTwit:_twitterStatus andWidth:self.contentView.frame.size.width] - 45.0f;
    self.detailTextLabel.frame = detailTextLabelFrame;
}

@end
