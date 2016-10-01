//
//  ChatTableViewCell.h
//  test
//
//  Created by iFlyLabs on 06/04/15.
//  Copyright (c) 2015 iFlyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AuthorType) {
    iMessageBubbleTableViewCellAuthorTypeSender = 0,
    iMessageBubbleTableViewCellAuthorTypeReceiver
};

@interface ChatTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *chatUserImage;
@property (strong, nonatomic) UILabel *chatNameLabel;
@property (strong, nonatomic) UILabel *chatTimeLabel;
@property (strong, nonatomic) UITextView *chatMessageLabel;
@property (nonatomic, assign) AuthorType authorType;

@property (strong, nonatomic) UIView *Main;
@property (strong, nonatomic) UIView *UpCurve;
@property (strong, nonatomic) UIView *DownCurve;
@property (strong, nonatomic) UIView *CoverCurve;

/*!
 *  @brief Activity Indicator
 */
@property (strong, nonatomic) UIActivityIndicatorView *activity;

/*!
 *  @brief Fail Image
 */
@property (strong, nonatomic) UIButton *failButton;

/*!
 *  @brief ProgressBar
 */
//@property (strong, nonatomic) MBProgressBar *progressBar;

/*!
 *  @brief Unread Counter
 */
@property (strong, nonatomic) UILabel *chatUnreadCountLabel;

/*!
 * @brief Multi-functional Button like 'View All'
 */
@property (strong, nonatomic) UIButton *button;


/*!
 *  Image Download Progressing from Notification
 *
 *  @param aNoti NSNotification
 */
- (void)imageDownloadProgressing:(NSNotification *)aNoti;

/*!
 *  Image Upload Progressing from Notification
 *
 *  @param aNoti NSNotification
 */
- (void)imageUploadProgressing:(NSNotification *)aNoti;

@end
