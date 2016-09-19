//
//  ChatTableViewCellXIB.m
//  iMessageBubble
//
//  Created by Prateek Grover on 19/09/15.
//  Copyright (c) 2015 Prateek Grover. All rights reserved.
//

#import "ChatTableViewCellXIB.h"

@implementation ChatTableViewCellXIB

@synthesize chatUserImage;
@synthesize chatMessageLabel;
@synthesize chatNameLabel;
@synthesize chatTimeLabel;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.chatMessageLabel.editable = NO;
    self.chatMessageLabel.selectable = YES;
    self.chatMessageLabel.userInteractionEnabled = YES;
    self.chatMessageLabel.dataDetectorTypes = UIDataDetectorTypePhoneNumber | UIDataDetectorTypeLink;
    self.chatMessageLabel.textContainer.lineBreakMode = NSLineBreakByWordWrapping;
    self.chatMessageLabel.textContainer.lineFragmentPadding = 0.0f;
    self.chatMessageLabel.textContainerInset = UIEdgeInsetsZero;
    self.chatMessageLabel.contentInset = UIEdgeInsetsZero;
    self.chatMessageLabel.layoutMargins = UIEdgeInsetsZero;
    self.chatMessageLabel.backgroundColor = [UIColor clearColor];
}

@end
