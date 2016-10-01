//
//  ChatTableViewCell.m
//  test
//
//  Created by iFlyLabs on 06/04/15.
//  Copyright (c) 2015 iFlyLabs. All rights reserved.
//

#import "ChatTableViewCell.h"
#import "ChatCellSettings.h"

@interface ChatTableViewCell ()

@property (strong, nonatomic) UIView *Bubble;
@property (strong, nonatomic) UIView *HidingLayerTop;
@property (strong, nonatomic) UIView *HidingLayerSide;

@end

@implementation ChatTableViewCell


@synthesize Bubble;
@synthesize Main;
@synthesize UpCurve;
@synthesize DownCurve;
@synthesize CoverCurve;
@synthesize HidingLayerTop;
@synthesize HidingLayerSide;
@synthesize chatUserImage;
@synthesize chatNameLabel;
@synthesize chatTimeLabel;
@synthesize chatMessageLabel;
@synthesize activity;
@synthesize failButton;
//@synthesize progressBar;
@synthesize chatUnreadCountLabel;

NSLayoutConstraint *height;
NSLayoutConstraint *width;
NSArray *horizontal;
NSArray *vertical;

CGFloat red;
CGFloat blue;
CGFloat green;

static ChatCellSettings *chatCellSettings = nil;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        chatCellSettings = [ChatCellSettings getInstance];
    });
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    Bubble = [[UIView alloc] init];
    
    [Bubble setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    Main = [[UIView alloc] init];
    
    [Main setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UpCurve = [[UIView alloc] init];
    
    [UpCurve setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    CoverCurve = [[UIView alloc] init];
    
    [CoverCurve setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    DownCurve = [[UIView alloc] init];
    
    [DownCurve setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    HidingLayerTop = [[UIView alloc] init];
    
    [HidingLayerTop setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    HidingLayerSide = [[UIView alloc] init];
    
    [HidingLayerSide setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    chatUserImage = [[UIImageView alloc] init];
    
    [chatUserImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    chatNameLabel = [[UILabel alloc] init];
    
    [chatNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    chatTimeLabel = [[UILabel alloc] init];
    
    [chatTimeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    activity.hidesWhenStopped = YES;
    
    [activity setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    failButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [failButton setImage:[UIImage imageNamed:@"icon_fail_balloon"] forState:UIControlStateNormal];
    [failButton setImage:[UIImage imageNamed:@"icon_fail_balloon_pressed"] forState:UIControlStateHighlighted];
    
    [failButton setTranslatesAutoresizingMaskIntoConstraints:NO];

    chatUnreadCountLabel = [[UILabel alloc] init];
    chatUnreadCountLabel.font = [UIFont boldSystemFontOfSize:9.0f];
    chatUnreadCountLabel.textColor = [UIColor colorWithRed:(255.0f/255.0f) green:(136.0f/255.0f) blue:(0.0f/255.0f) alpha:1.0f];
    
    [chatUnreadCountLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
//    progressBar = [[MBBarProgressView alloc] init];
//    progressBar.progressColor = [UIColor colorWithRed:(235.0f/255.0f) green:(108.0/255.0f) blue:(89.0f/255.0f) alpha:1.0f];
//    progressBar.progressRemainingColor = [UIColor colorWithWhite:0.67f alpha:1.0f];
//    progressBar.lineColor = [UIColor clearColor];
//    progressBar.backgroundColor = [UIColor clearColor];
//    ADD_NOTI(self, @selector(imageDownloadProgressing:), noti_ChatDataDownloadRatio, nil)
//    
//    [progressBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    chatMessageLabel = [[UITextView alloc] initWithFrame:CGRectMake(Main.bounds.origin.x, Main.bounds.origin.y, 220.0f, 20.0f)];
    chatMessageLabel.textAlignment = NSTextAlignmentLeft;
    chatMessageLabel.userInteractionEnabled = YES;
    chatMessageLabel.layoutMargins = UIEdgeInsetsZero;
    chatMessageLabel.backgroundColor = [UIColor clearColor];
    //chatMessageLabel.numberOfLines = INT_MAX;
    chatMessageLabel.scrollEnabled = NO;
    chatMessageLabel.editable = NO;
    chatMessageLabel.selectable = YES;
    chatMessageLabel.dataDetectorTypes = UIDataDetectorTypePhoneNumber | UIDataDetectorTypeLink;
    chatMessageLabel.textContainer.lineBreakMode = NSLineBreakByWordWrapping;
    chatMessageLabel.textContainer.lineFragmentPadding = 0.0f;
    chatMessageLabel.textContainerInset = UIEdgeInsetsZero;
    chatMessageLabel.contentInset = UIEdgeInsetsZero;

    [chatMessageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.contentView addSubview:Bubble];
    [self.contentView addSubview:chatTimeLabel];
    [self.contentView addSubview:failButton];
    failButton.hidden = YES;
//    [self.contentView addSubview:progressBar];
//    progressBar.hidden = YES;
    [self.contentView addSubview:chatUnreadCountLabel];
    [self.contentView addSubview:activity]; // Activity Indicator
    
    [Bubble addSubview:DownCurve];
    [Bubble addSubview:HidingLayerTop];
    [Bubble addSubview:UpCurve];
    [Bubble addSubview:CoverCurve];
    [Bubble addSubview:Main];
    [Bubble addSubview:HidingLayerSide];
    [Bubble addSubview:chatUserImage];
    [Bubble addSubview:chatNameLabel];

    [Main addSubview:chatMessageLabel];
    
    chatUserImage.image = [UIImage imageNamed:@"defaultUser.png"];
    
    chatNameLabel.text = @"chatNameLabel";
    
    chatTimeLabel.text = @"chatTimeLabel";
    
    chatMessageLabel.text = @"chatMessageLabel";
    
    [chatNameLabel setNumberOfLines:1];
    [chatTimeLabel setNumberOfLines:1];
    
    chatNameLabel.lineBreakMode = NSLineBreakByClipping;
    chatTimeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    //Common placement of the different views
    
    //Setting constraints for Bubble. It should be at a zero distance from top, bottom and 8 distance right hand side of the superview, i.e., self.contentView (The default superview for all tableview cell elements)
    
    
    vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(<=8)-[Bubble]-(<=8)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(Bubble)];
    
    width = [NSLayoutConstraint constraintWithItem:Bubble attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:5.0f];
    
    [self.contentView addConstraint:width];
    
    
    [self.contentView addConstraints:vertical];
    
    // /////////////////////////////////////////////////////////////////////////////////////////////
    
    //Setting constraints for Main block. It contains name, message and time labels. Main should be at a zero distance from bottom and left of its superview, i.e., Bubble
    
    vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[Main]-(0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(Main)];
    
    [Bubble addConstraints:vertical];
    
    height = [NSLayoutConstraint constraintWithItem:Main attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:32.0f];
    
    width = [NSLayoutConstraint constraintWithItem:Main attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:38.0f];
    
    
    [Bubble addConstraints:@[height,width]];
    
    // /////////////////////////////////////////////////////////////////////////////////////////////
    
    //Setting constraints for UpCurve. It should be at zero distance from Main on left side, -1 distance from bottom and 10 distance from right of the superview, i.e., Bubble. Height and Width should be 32 and 20 respectively
    
    height = [NSLayoutConstraint constraintWithItem:UpCurve attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:32.0f];
    
    width = [NSLayoutConstraint constraintWithItem:UpCurve attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:20.0f];
    
    
    [Bubble addConstraints:@[height,width]];
    
    
    vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[UpCurve]-(-1)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(UpCurve)];
    
    [Bubble addConstraints:vertical];
    
    // /////////////////////////////////////////////////////////////////////////////////////////////
    
    //Setting constraints for DownCurve. It should be at a 0 distance from right and bottom of superview and -20 distance from Main on the left. Its superview is Bubble. The height and width should be 25 and 50 respectively.
    
    height = [NSLayoutConstraint constraintWithItem:DownCurve attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:25.0f];
    
    width = [NSLayoutConstraint constraintWithItem:DownCurve attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:50.0f];
    
    
    [Bubble addConstraints:@[height,width]];
    
    
    vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[DownCurve]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(DownCurve)];
    
    [Bubble addConstraints:vertical];
  
    
    // /////////////////////////////////////////////////////////////////////////////////////////////
    
    //Setting constraints for CoverCurve. It should be at a 0 distance from right and bottom of superview and -20 distance from Main on the left. Its superview is Bubble. The height and width should be 25 and 50 respectively.
    
    height = [NSLayoutConstraint constraintWithItem:CoverCurve attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:25.0f];
    
    width = [NSLayoutConstraint constraintWithItem:CoverCurve attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:50.0f];
    
    
    [Bubble addConstraints:@[height,width]];
    
    
    vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[CoverCurve]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(CoverCurve)];
    
    [Bubble addConstraints:vertical];
    
    // /////////////////////////////////////////////////////////////////////////////////////////////
    
    //Setting constraints for HidingLayerSide. Superview is Bubble. Right and bottom distances should be 0 and top should be greater than 0. Height and Width are 32 and 15 respectively.
    
    height = [NSLayoutConstraint constraintWithItem:HidingLayerSide attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:32.0f];
    
    width = [NSLayoutConstraint constraintWithItem:HidingLayerSide attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:15.0f];
    
    
    vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[HidingLayerSide]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(HidingLayerSide)];
    
    [Bubble addConstraints:@[height,width]];
    
    [Bubble addConstraints:vertical];
    
    
    // /////////////////////////////////////////////////////////////////////////////////////////////
    
    //Setting constraints for HidingLayerTop. Superview is Bubble. Right, left and top distances should be 0 and bottom should be 20.
    
    
    vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[HidingLayerTop]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(HidingLayerTop)];
    
    
    [Bubble addConstraints:vertical];
    
    // /////////////////////////////////////////////////////////////////////////////////////////////
    
    //Setting constraints for chatUserImage. Its superview is Bubble. It should be at 0 distance from right and bottom of superview and 5 distance from Main. Height and width should be 25 and 25.
    
    height = [NSLayoutConstraint constraintWithItem:chatUserImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:44.0f];
    
    width = [NSLayoutConstraint constraintWithItem:chatUserImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:44.0f];
    
    [Bubble addConstraints:@[height,width]];

    
    // /////////////////////////////////////////////////////////////////////////////////////////////
    
    //Setting the constraints for chatNameLabel. It should be at 16 distance from right and left of superview, i.e., Main and 8 distance from top and chatMessageLabel which is at 8 distance from chatTimeLabel which is at 8 distance from bottom of superview.
    
    vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(5)-[chatNameLabel]-(>=5)-[chatUserImage]-(0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(chatNameLabel,chatUserImage)];
    
    [Bubble addConstraints:vertical];
    

    //[self.contentView addConstraints:vertical];

    // ////////////////////////////////////////////////////////////////////////////////////////////
    
    //Setting width constraint for chatNameLabel
    
    NSLayoutConstraint *proportionalWidth = [NSLayoutConstraint constraintWithItem:chatNameLabel
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:chatUserImage
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:1.5
                                                                          constant:0];
    
    proportionalWidth.priority = 750;
    
    [Bubble addConstraint:proportionalWidth]; //Main => Bubble
    
    [chatNameLabel setContentCompressionResistancePriority:250 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    // ////////////////////////////////////////////////////////////////////////////////////////////

    
    //Setting the constraints for chatNameLabel. It should be at 16 distance from right and left of superview, i.e., Main and 8 distance from top and chatMessageLabel which is at 8 distance from chatTimeLabel which is at 8 distance from bottom of superview.
    
    
    // Move vertical to -[updateFrameFromAuthorType:]
//    vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[chatNameLabel]-8-[chatMessageLabel]-8-[chatTimeLabel]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(chatNameLabel,chatMessageLabel,chatTimeLabel)];
//    
//    [Main addConstraints:vertical];

    
    vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[chatTimeLabel]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(chatTimeLabel)];
    
    [self.contentView addConstraints:vertical]; // Main => Bubble => self.contentView

    // /////////////////////////////////////////////////////////////////////////////////////////////
    
    // Modify background color to clear color by neoroman
    self.contentView.backgroundColor = [chatCellSettings getTableViewBackgroundColor];
    [self setBackgroundColor:[UIColor clearColor]];
    
    Bubble.backgroundColor = [UIColor clearColor];
    
    UpCurve.backgroundColor = [chatCellSettings getTableViewBackgroundColor];
    CoverCurve.backgroundColor = UpCurve.backgroundColor;
    
    HidingLayerTop.backgroundColor = [UIColor clearColor];
    
    HidingLayerSide.backgroundColor = [UIColor clearColor];
    
    chatTimeLabel.textAlignment = NSTextAlignmentCenter;
    
    return self;
}

-(void)layoutSubviews
{
    CGSize size = chatMessageLabel.superview.frame.size;
    [chatMessageLabel setCenter:CGPointMake(size.width/2, size.height/2)];
    
    Main.layer.cornerRadius = 16.0f;
    UpCurve.layer.cornerRadius = 10.0f;
    DownCurve.layer.cornerRadius = 25.0f;
    chatUserImage.layer.cornerRadius = 22.0f;
    chatUserImage.layer.masksToBounds = YES;
}

- (void)updateFramesForAuthorType:(AuthorType)type
{
    
    if(type == iMessageBubbleTableViewCellAuthorTypeSender)
    {
        // /////////////////////////////////////////////////////////////////////////////////////////////

        //Setting the constraints for chatMessageLabel. It should be constrained by width, i.e., Main.
        
        width = [NSLayoutConstraint constraintWithItem:chatMessageLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:[chatCellSettings getSenderChatMessageLabelWidth]];
        [Main addConstraints:@[width]];

        // /////////////////////////////////////////////////////////////////////////////////////////////

        //Setting constraints for Bubble. It should be at a zero distance from top, bottom and 8 distance right hand side of the superview, i.e., self.contentView (The default superview for all tableview cell elements)
        
        if ([chatCellSettings getShowSenderUserImage]) {
            horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[Bubble]-8-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(Bubble)];
        }
        else {
            horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[Bubble]-(-25)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(Bubble)];
        }
        
        [self.contentView addConstraints:horizontal];
        
        // /////////////////////////////////////////////////////////////////////////////////////////////
        
        //Setting constraints for Main block. It contains name, message and time labels. Main should be at a zero distance from bottom and left of its superview, i.e., Bubble
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[Main]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(Main)];
        
        [Bubble addConstraints:horizontal];
        
        if ([chatCellSettings getShowSenderUserImage]) {
            // /////////////////////////////////////////////////////////////////////////////////////////////
            
            //Setting constraints for chatUserImage. Its superview is Bubble. It should be at 0 distance from right and bottom of superview and 5 distance from Main. Height and width should be 25 and 25.
            
            horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[Main]-5-[chatUserImage]-0-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(Main,chatUserImage)];
            
            [Bubble addConstraints:horizontal];
            
            // /////////////////////////////////////////////////////////////////////////////////////////////
            
            //Setting constraints for UpCurve. It should be at zero distance from Main on left side, -1 distance from bottom and 10 distance from right of the superview, i.e., Bubble. Height and Width should be 32 and 20 respectively
            
            
            horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[Main]-(-2)-[UpCurve]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(Main,UpCurve)];
            
            
            [Bubble addConstraints:horizontal];
            
            // /////////////////////////////////////////////////////////////////////////////////////////////
            
            //Setting constraints for DownCurve. It should be at a 0 distance from right and bottom of superview and -20 distance from Main on the left. Its superview is Bubble. The height and width should be 25 and 50 respectively.
            
            
            horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[Main]-(-20)-[DownCurve]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(Main,DownCurve)];
            
            [Bubble addConstraints:horizontal];
            
            // /////////////////////////////////////////////////////////////////////////////////////////////
            
            //Setting constraints for CoverCurve. It should be at a 0 distance from left and bottom of superview and -20 distance from Main on the right. Its superview is Bubble. The height and width should be 25 and 50 respectively.
            
            horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[Main]-(5)-[CoverCurve]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(Main,CoverCurve)];
            
            [Bubble addConstraints:horizontal];
            
        }
        else {
            // /////////////////////////////////////////////////////////////////////////////////////////////
            
            //Setting constraints for chatUserImage. Its superview is Bubble. It should be at 0 distance from right and bottom of superview and 5 distance from Main. Height and width should be 25 and 25.
            
            chatUserImage.hidden = YES;

            // /////////////////////////////////////////////////////////////////////////////////////////////
            
            //Setting constraints for UpCurve. It should be at zero distance from Main on left side, -1 distance from bottom and 10 distance from right of the superview, i.e., Bubble. Height and Width should be 32 and 20 respectively
            
            
            horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[Main]-(-6)-[UpCurve]-14-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(Main,UpCurve)];
            
            
            [Bubble addConstraints:horizontal];
            
            // /////////////////////////////////////////////////////////////////////////////////////////////
            
            //Setting constraints for DownCurve. It should be at a 0 distance from right and bottom of superview and -20 distance from Main on the left. Its superview is Bubble. The height and width should be 25 and 50 respectively.
            
            
            horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[Main]-(-20)-[DownCurve]-0-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(Main,DownCurve)];
            
            [Bubble addConstraints:horizontal];
            
            
            // /////////////////////////////////////////////////////////////////////////////////////////////
            
            //Setting constraints for CoverCurve. It should be at a 0 distance from left and bottom of superview and -20 distance from Main on the right. Its superview is Bubble. The height and width should be 25 and 50 respectively.
            
            horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[Main]-(16)-[CoverCurve]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(CoverCurve,Main)];
            
            [Bubble addConstraints:horizontal];
            
        }
        // /////////////////////////////////////////////////////////////////////////////////////////////
       
        if ([chatCellSettings getShowSenderUserImage]) {
            horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[Main]-2-[chatNameLabel]-0-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(Main,chatNameLabel)];
            
            [Bubble addConstraints:horizontal];
            
        }
        else {
            chatNameLabel.hidden = YES;
        }

        // /////////////////////////////////////////////////////////////////////////////////////////////

        //Setting constraints for HidingLayerSide. Superview is Bubble. Right and bottom distances should be 0 and top should be greater than 0. Height and Width are 32 and 15 respectively.
        
        if ([chatCellSettings getShowSenderUserImage]) {
            horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[HidingLayerSide]-0-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(HidingLayerSide)];
            
            [Bubble addConstraints:horizontal];
        }
        
        // /////////////////////////////////////////////////////////////////////////////////////////////

        //Setting constraints for HidingLayerTop. Superview is Bubble. Right, left and top distances should be 0 and bottom should be 20.
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[HidingLayerTop]-0-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(HidingLayerTop)];
        
        
        [Bubble addConstraints:horizontal];
        
        // /////////////////////////////////////////////////////////////////////////////////////////////
        
        //Setting the constraints for chatTimeLabel. It should be 16 distance from right and left of superview, i.e., Main.
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[chatTimeLabel]-4-[Bubble]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(chatTimeLabel,Bubble)];
        
        [self.contentView addConstraints:horizontal];
        
        
        // /////////////////////////////////////////////////////////////////////////////////////////////
        
        //Setting the constraints for chatMessageLabel. It should be 16 distance from right and left of superview, i.e., Main.
        
        vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[chatMessageLabel]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(chatMessageLabel)];
        
        [Main addConstraints:vertical];
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[chatMessageLabel]-16-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(chatMessageLabel)];
        
        [Main addConstraints:horizontal];
        
        // /////////////////////////////////////////////////////////////////////////////////////////////
        
        if(![chatCellSettings getSenderBubbleTail])
        {
            [DownCurve setHidden:YES];
            [UpCurve setHidden:YES];
            [CoverCurve setHidden:YES];
        }
        else
        {
            [DownCurve setHidden:NO];
            [UpCurve setHidden:NO];
            [CoverCurve setHidden:NO];
        }
        
        
        Main.backgroundColor = [chatCellSettings getSenderBubbleColor];
        
        DownCurve.backgroundColor = [chatCellSettings getSenderBubbleColor];
        
        NSArray *textColor = [chatCellSettings getSenderBubbleTextColor];
        
        chatNameLabel.textColor = textColor[0];
        chatMessageLabel.textColor = textColor[1];
        chatTimeLabel.textColor = textColor[2];
        
        NSArray *fontWithSize = [chatCellSettings getSenderBubbleFontWithSize];
        
        chatNameLabel.font = fontWithSize[0];
        chatMessageLabel.font = fontWithSize[1];
        chatTimeLabel.font = fontWithSize[2];
                
    }
    else
    {
        //Setting the constraints for chatMessageLabel. It should be constrained by width, i.e., Main.

        width = [NSLayoutConstraint constraintWithItem:chatMessageLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:[chatCellSettings getReceiverChatMessageLabelWidth]];
        [Main addConstraints:@[width]];

        //Setting constraints for Bubble. It should be at a zero distance from top, bottom and 8 distance from left hand side of the superview, i.e., self.contentView (The default superview for all tableview cell elements)
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[Bubble]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(Bubble)];
        
        
        [self.contentView addConstraints:horizontal];
        
        // /////////////////////////////////////////////////////////////////////////////////////////////
        
        vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[chatMessageLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(chatMessageLabel)];
        
        [Main addConstraints:vertical];
        
        // /////////////////////////////////////////////////////////////////////////////////////////////
        
        //Setting constraints for Main block. It contains name, message and time labels. Main should be at a zero distance from bottom and right of its superview, i.e., Bubble
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[chatUserImage]-5-[Main]-0-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(chatUserImage,Main)];
        
        [Bubble addConstraints:horizontal];
        
        // /////////////////////////////////////////////////////////////////////////////////////////////
        
        //Setting constraints for UpCurve. It should be at zero distance from Main on right side, -1 distance from bottom and 10 distance from left of the superview, i.e., Bubble. Height and Width should be 32 and 20 respectively
        
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[UpCurve]-(-2)-[Main]|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(UpCurve,Main)];
        
        
        [Bubble addConstraints:horizontal];
        
        // /////////////////////////////////////////////////////////////////////////////////////////////
        
        //Setting constraints for DownCurve. It should be at a 0 distance from left and bottom of superview and -20 distance from Main on the right. Its superview is Bubble. The height and width should be 25 and 50 respectively.
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(5)-[chatUserImage]-(-25)-[DownCurve]-(-20)-[Main]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(chatUserImage,DownCurve,Main)];
        
        [Bubble addConstraints:horizontal];
        
        // /////////////////////////////////////////////////////////////////////////////////////////////
        
        //Setting constraints for CoverCurve. It should be at a 0 distance from left and bottom of superview and -20 distance from Main on the right. Its superview is Bubble. The height and width should be 25 and 50 respectively.
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[CoverCurve]-(16)-[Main]|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(CoverCurve,Main)];
        
        [Bubble addConstraints:horizontal];
        
       // /////////////////////////////////////////////////////////////////////////////////////////////
        
        //Setting constraints for HidingLayerSide. Superview is Bubble. Left and bottom distances should be 0 and top should be greater than 0. Height and Width are 32 and 15 respectively.
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[HidingLayerSide]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(HidingLayerSide)];
        
        vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[HidingLayerSide]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(HidingLayerSide)];
        
        
        [Bubble addConstraints:horizontal];
        
        
        // /////////////////////////////////////////////////////////////////////////////////////////////
        
        //Setting constraints for HidingLayerTop. Superview is Bubble. Right, left and top distances should be 0 and bottom should be 20.
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[HidingLayerTop]-0-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(HidingLayerTop)];
        
        
        
        [Bubble addConstraints:horizontal];
        
        
        // /////////////////////////////////////////////////////////////////////////////////////////////

        //Setting constraints for chatNameLabel
        
        chatNameLabel.hidden = NO;
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-1-[chatNameLabel]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(chatNameLabel)];
        
        [Bubble addConstraints:horizontal]; //Main => Bubble
        
        // /////////////////////////////////////////////////////////////////////////////////////////////
        
        //Setting constraints for chatUserImage. Its superview is Bubble. It should be at 0 distance from left and bottom of superview and 5 distance from Main on the right. Height and width should be 25 and 25.
        
//        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[chatUserImage]-5-[Main]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(chatUserImage,Main)];
//
//        [Bubble addConstraints:horizontal];

        // /////////////////////////////////////////////////////////////////////////////////////////////
        
        //Setting the constraints for chatTimeLabel. It should be 16 distance from right and left of superview, i.e., Main.
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[Bubble]-4-[chatTimeLabel]" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(Bubble,chatTimeLabel)];
        
        [self.contentView addConstraints:horizontal];
        
        // /////////////////////////////////////////////////////////////////////////////////////////////
        
        //Setting the constraints for chatMessageLabel. It should be 16 distance from right and left of superview, i.e., Main.
        
        horizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[chatMessageLabel]-16-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(chatMessageLabel)];
        
        [Main addConstraints:horizontal];
        
        // /////////////////////////////////////////////////////////////////////////////////////////////

        if(![chatCellSettings getReceiverBubbleTail])
        {
            [DownCurve setHidden:YES];
            [UpCurve setHidden:YES];
            [CoverCurve setHidden:YES];
        }
        else
        {
            [DownCurve setHidden:NO];
            [UpCurve setHidden:NO];
            [CoverCurve setHidden:NO];
        }
        
        Main.backgroundColor = [chatCellSettings getReceiverBubbleColor];
        
        DownCurve.backgroundColor = [chatCellSettings getReceiverBubbleColor];
        
        NSArray *textColor = [chatCellSettings getReceiverBubbleTextColor];
        
        chatNameLabel.textColor = textColor[0];
        chatMessageLabel.textColor = textColor[1];
        chatTimeLabel.textColor = textColor[2];
        
        NSArray *fontWithSize = [chatCellSettings getReceiverBubbleFontWithSize];
        
        chatNameLabel.font = fontWithSize[0];
        chatMessageLabel.font = fontWithSize[1];
        chatTimeLabel.font = fontWithSize[2];
        
    }
}

- (void)setAuthorType:(AuthorType)type
{
    _authorType = type;
    [self updateFramesForAuthorType:_authorType];
}

@end
