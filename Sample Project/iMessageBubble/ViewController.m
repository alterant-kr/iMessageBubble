//
//  ViewController.m
//  iMessageBubble
//
//  Created by Prateek Grover on 19/09/15.
//  Copyright (c) 2015 Prateek Grover. All rights reserved.
//

#import "ViewController.h"
#import "ContentView.h"
#import "ChatTableViewCell.h"
#import "ChatTableViewCellXIB.h"
#import "ChatCellSettings.h"


#define kUsingChatTableViewCellXIB  0


@interface iMessage: NSObject

-(id) initIMessageWithName:(NSString *)name
                     message:(NSString *)message
                        time:(NSString *)time
                      type:(NSString *)type
                    status:(NSString *)status;

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userMessage;
@property (strong, nonatomic) NSString *userTime;
@property (strong, nonatomic) NSString *messageType;
@property (strong, nonatomic) NSString *messageStatus;

@end

@implementation iMessage

-(id) initIMessageWithName:(NSString *)name
                     message:(NSString *)message
                        time:(NSString *)time
                      type:(NSString *)type
                    status:(NSString *)status
{
    self = [super init];
    if(self)
    {
        self.userName = name;
        self.userMessage = message;
        self.userTime = time;
        self.messageType = type;
        self.messageStatus = status;
    }
    
    return self;
}

@end

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *chatTable;
@property (weak, nonatomic) IBOutlet ContentView *contentView;
@property (weak, nonatomic) IBOutlet UITextView *chatTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatTextViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomConstraint;

/*Uncomment second line and comment first to use XIB instead of code*/
#if kUsingChatTableViewCellXIB
@property (strong,nonatomic) ChatTableViewCellXIB *chatCell;
#else
@property (strong,nonatomic) ChatTableViewCell *chatCell;
#endif

@property (strong,nonatomic) ContentView *handler;


@end

@implementation ViewController
{
    NSMutableArray *currentMessages;
    ChatCellSettings *chatCellSettings;
}
@synthesize chatCell;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentMessages = [[NSMutableArray alloc] init];
    chatCellSettings = [ChatCellSettings getInstance];
    
    /**
     *  Set settings for Application. They are available in ChatCellSettings class.
     */
    
    //[chatCellSettings setSenderBubbleColor:[UIColor colorWithRed:0 green:(122.0f/255.0f) blue:1.0f alpha:1.0f]];
    //[chatCellSettings setReceiverBubbleColor:[UIColor colorWithRed:(223.0f/255.0f) green:(222.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f]];
    //[chatCellSettings setSenderBubbleNameTextColor:[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f]];
    //[chatCellSettings setReceiverBubbleNameTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f]];
    //[chatCellSettings setSenderBubbleMessageTextColor:[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f]];
    //[chatCellSettings setReceiverBubbleMessageTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f]];
    //[chatCellSettings setSenderBubbleTimeTextColor:[UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f]];
    //[chatCellSettings setReceiverBubbleTimeTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f]];
    
//    [chatCellSettings setSenderBubbleColorHex:@"007AFF"];
//    [chatCellSettings setReceiverBubbleColorHex:@"DFDEE5"];
//    [chatCellSettings setSenderBubbleNameTextColorHex:@"FFFFFF"];
//    [chatCellSettings setReceiverBubbleNameTextColorHex:@"000000"];
//    [chatCellSettings setSenderBubbleMessageTextColorHex:@"FFFFFF"];
//    [chatCellSettings setReceiverBubbleMessageTextColorHex:@"000000"];
//    [chatCellSettings setSenderBubbleTimeTextColorHex:@"FFFFFF"];
//    [chatCellSettings setReceiverBubbleTimeTextColorHex:@"000000"];
//    
//    [chatCellSettings setSenderBubbleFontWithSizeForName:[UIFont boldSystemFontOfSize:11]];
//    [chatCellSettings setReceiverBubbleFontWithSizeForName:[UIFont boldSystemFontOfSize:11]];
//    [chatCellSettings setSenderBubbleFontWithSizeForMessage:[UIFont systemFontOfSize:14]];
//    [chatCellSettings setReceiverBubbleFontWithSizeForMessage:[UIFont systemFontOfSize:14]];
//    [chatCellSettings setSenderBubbleFontWithSizeForTime:[UIFont systemFontOfSize:11]];
//    [chatCellSettings setReceiverBubbleFontWithSizeForTime:[UIFont systemFontOfSize:11]];
//    
//    [chatCellSettings senderBubbleTailRequired:YES];
//    [chatCellSettings receiverBubbleTailRequired:YES];

    // Set table view background color to R: 245, G: 237, B: 228
    [[self chatTable] setBackgroundColor:[UIColor colorWithRed:(245.0f/255.0f) green:(237.0f/255.0f) blue:(228.0f/255.0f) alpha:1.0f]];
    

    self.navigationItem.title = @"iMessageBubble Demo";
    
    [[self chatTable] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    
    
    
    
    /*Uncomment second para and comment first to use XIB instead of code*/
    //Registering custom Chat table view cell for both sending and receiving
#if kUsingChatTableViewCellXIB
     UINib *nib = [UINib nibWithNibName:@"ChatSendCell" bundle:nil];
    
    [[self chatTable] registerNib:nib forCellReuseIdentifier:@"chatSend"];
    
    nib = [UINib nibWithNibName:@"ChatReceiveCell" bundle:nil];
    
    [[self chatTable] registerNib:nib forCellReuseIdentifier:@"chatReceive"];
#else
    [[self chatTable] registerClass:[ChatTableViewCell class] forCellReuseIdentifier:@"chatSend"];

    [[self chatTable] registerClass:[ChatTableViewCell class] forCellReuseIdentifier:@"chatReceive"];
#endif
    
    
    //Instantiating custom view that adjusts itself to keyboard show/hide
    self.handler = [[ContentView alloc] initWithTextView:self.chatTextView ChatTextViewHeightConstraint:self.chatTextViewHeightConstraint contentView:self.contentView ContentViewHeightConstraint:self.contentViewHeightConstraint andContentViewBottomConstraint:self.contentViewBottomConstraint];
    
    //Setting the minimum and maximum number of lines for the textview vertical expansion
    [self.handler updateMinimumNumberOfLines:1 andMaximumNumberOfLine:3];
    
    //Tap gesture on table view so that when someone taps on it, the keyboard is hidden
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.chatTable addGestureRecognizer:gestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dismissKeyboard
{
    [self.chatTextView resignFirstResponder];
}

- (IBAction)sendMessage:(id)sender
{
    if([self.chatTextView.text length]!=0)
    {
        iMessage *sendMessage;
    
        sendMessage = [[iMessage alloc] initIMessageWithName:@"Prateek Grover" message:self.chatTextView.text time:@"23:14" type:@"self" status:@"sending"];
    
        [self updateTableView:sendMessage];
    }
}

- (IBAction)receiveMessage:(id)sender
{
    if([self.chatTextView.text length]!=0)
    {
        iMessage *receiveMessage;
    
        receiveMessage = [[iMessage alloc] initIMessageWithName:@"Prateek Grover" message:self.chatTextView.text time:@"23:14" type:@"other" status:@"received"];
    
        [self updateTableView:receiveMessage];
    }
}

-(void) updateTableView:(iMessage *)msg
{
    [self.chatTextView setText:@""];
    [self.handler textViewDidChange:self.chatTextView];
    
    [self.chatTable beginUpdates];
    
    NSIndexPath *row1 = [NSIndexPath indexPathForRow:currentMessages.count inSection:0];
    
    [currentMessages insertObject:msg atIndex:currentMessages.count];
    
    [self.chatTable insertRowsAtIndexPaths:[NSArray arrayWithObjects:row1, nil] withRowAnimation:UITableViewRowAnimationBottom];
    
    [self.chatTable endUpdates];
    
    //Always scroll the chat table when the user sends the message
    if([self.chatTable numberOfRowsInSection:0]!=0)
    {
        NSIndexPath* ip = [NSIndexPath indexPathForRow:[self.chatTable numberOfRowsInSection:0]-1 inSection:0];
        [self.chatTable scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:UITableViewRowAnimationLeft];
    }
}


#pragma mark - UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return currentMessages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    iMessage *message = [currentMessages objectAtIndex:indexPath.row];
    
    if([message.messageType isEqualToString:@"self"])
    {
        /*Uncomment second line and comment first to use XIB instead of code*/
#if kUsingChatTableViewCellXIB
        chatCell = (ChatTableViewCellXIB *)[tableView dequeueReusableCellWithIdentifier:@"chatSend"];
#else
        chatCell = (ChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"chatSend"];
#endif
       
        //chatCell.chatMessageLabel.text = message.userMessage;
        chatCell.chatMessageLabel.attributedText = [chatCellSettings replaceEmoticonTextToImageWithString:message.userMessage withAttributes:[chatCellSettings getSenderAttributes]];
        
        chatCell.chatNameLabel.text = message.userName;
        
        chatCell.chatTimeLabel.text = message.userTime;
        
        chatCell.chatUserImage.image = [UIImage imageNamed:@"defaultUser"];
        
        /*Comment this line is you are using XIB*/
#if (! kUsingChatTableViewCellXIB)
        chatCell.authorType = iMessageBubbleTableViewCellAuthorTypeSender;
#endif
    }
    else
    {
        /*Uncomment second line and comment first to use XIB instead of code*/
#if kUsingChatTableViewCellXIB
        chatCell = (ChatTableViewCellXIB *)[tableView dequeueReusableCellWithIdentifier:@"chatReceive"];
#else
        chatCell = (ChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"chatReceive"];
#endif
        
        //chatCell.chatMessageLabel.text = message.userMessage;
        chatCell.chatMessageLabel.attributedText = [chatCellSettings replaceEmoticonTextToImageWithString:message.userMessage withAttributes:[chatCellSettings getReceiverAttributes]];
        
        chatCell.chatNameLabel.text = message.userName;
        
        chatCell.chatTimeLabel.text = message.userTime;
        
        chatCell.chatUserImage.image = [UIImage imageNamed:@"defaultUser"];

        /*Comment this line is you are using XIB*/
#if (! kUsingChatTableViewCellXIB)
        chatCell.authorType = iMessageBubbleTableViewCellAuthorTypeReceiver;
#endif
    }
    
    return chatCell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    iMessage *message = [currentMessages objectAtIndex:indexPath.row];
    
    CGSize size;
    
    CGSize Namesize;
    CGSize Timesize;
    CGSize Messagesize;
    
    NSArray *fontArray = [[NSArray alloc] init];
    CGFloat bubbleWidth = 220.f;
    NSAttributedString *userMessage = nil;
    //Get the chal cell font settings. This is to correctly find out the height of each of the cell according to the text written in those cells which change according to their fonts and sizes.
    //If you want to keep the same font sizes for both sender and receiver cells then remove this code and manually enter the font name with size in Namesize, Messagesize and Timesize.
    
    CGFloat compHeight = 0.0f;
    if([message.messageType isEqualToString:@"self"])
    {
        fontArray = chatCellSettings.getSenderBubbleFontWithSize;
        [chatCellSettings setSenderChatMessageLabelWidth:190.0f];
        bubbleWidth = [chatCellSettings getSenderChatMessageLabelWidth];
        userMessage = [chatCellSettings replaceEmoticonTextToImageWithString:message.userMessage withAttributes:[chatCellSettings getSenderAttributes]];
    }
    else
    {
        fontArray = chatCellSettings.getReceiverBubbleFontWithSize;
        [chatCellSettings setReceiverChatMessageLabelWidth:165.0f];
        bubbleWidth = [chatCellSettings getReceiverChatMessageLabelWidth];
        userMessage = [chatCellSettings replaceEmoticonTextToImageWithString:message.userMessage withAttributes:[chatCellSettings getReceiverAttributes]];
        compHeight = 15.0f;
    }
    
    //Find the required cell height
    Namesize = [@"Name" boundingRectWithSize:CGSizeMake(bubbleWidth, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:fontArray[0]}
                                     context:nil].size;
    
    /* Change this for AttributedString -[boundingRectWithSize:...]
    Messagesize = [message.userMessage boundingRectWithSize:CGSizeMake(bubbleWidth, CGFLOAT_MAX)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:fontArray[1]}
                                                   context:nil].size;
     */
    Messagesize = [userMessage boundingRectWithSize:CGSizeMake(bubbleWidth, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                            context:nil].size;
    
    
    Timesize = [@"Time" boundingRectWithSize:CGSizeMake(bubbleWidth, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:fontArray[2]}
                                     context:nil].size;
    
    
    size.height = Messagesize.height + Namesize.height + Timesize.height + compHeight;// + 48.0f;
    
    return size.height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([chatCellSettings getUseSendingBubbleEffect]) {
        iMessage *message = [currentMessages objectAtIndex:indexPath.row];
        if([message.messageType isEqualToString:@"self"] && [message.messageStatus isEqualToString:@"sending"]) {
            if ([cell isKindOfClass:NSClassFromString(@"ChatTableViewCell")]) {
                ChatTableViewCell *aCell = (ChatTableViewCell *)cell;
                
                aCell.chatUserImage.alpha = 0.0;
                aCell.UpCurve.alpha = 0.0;
                aCell.DownCurve.alpha = 0.0;
                aCell.Main.alpha = 0.0f;
                
                [self animateSendingBubble:aCell.Main others:@[aCell.chatUserImage, aCell.UpCurve, aCell.DownCurve]];

            }
            else {
                ChatTableViewCellXIB *aCell = (ChatTableViewCellXIB *)cell;
                
                aCell.chatUserImage.alpha = 0.0;
                aCell.UpCurve.alpha = 0.0;
                aCell.DownCurve.alpha = 0.0;
                aCell.Main.alpha = 0.0f;
                
                [self animateSendingBubble:aCell.Main others:@[aCell.chatUserImage, aCell.UpCurve, aCell.DownCurve]];

            }
            
            message.messageStatus = @"sent";
        }
    }
}

- (void)animateSendingBubble:(UIView *)targetView others:(NSArray *)objects
{
    if (targetView) {
        CGFloat xDist = -targetView.frame.size.width;
        CGFloat yDist = 10.0f;
        
        targetView.layer.transform = CATransform3DMakeTranslation(xDist, yDist, 10.0f);
        //targetView.layer.transform = CATransform3DScale(targetView.layer.transform, 0.5f, 1.5f, 1.5f);
        targetView.layer.zPosition = 1000.0f;
        
       [UIView animateWithDuration:0.001 delay:0.4 options:UIViewAnimationOptionTransitionNone animations:^{

           [UIView animateWithDuration:0.2f
                                 delay:0.0f
                               options:UIViewAnimationOptionCurveEaseIn
                            animations:^{
                                
                                targetView.alpha = 1.0f;
                                
                            } completion:^(BOOL finished) {
                                
                                if (finished) {
                                    [UIView animateWithDuration:0.5f
                                                          delay:0.0f
                                         usingSpringWithDamping:0.3f
                                          initialSpringVelocity:0.1f
                                                        options:UIViewAnimationOptionCurveEaseInOut
                                                     animations:^{
                                                         
                                                         targetView.layer.transform = CATransform3DIdentity;
                                                         
                                                     } completion:^(BOOL finished) {
                                                
                                                         if (finished) {
                                                             if (objects && objects.count) {
                                                                 for (UIView *obj in objects) {
                                                                     obj.alpha = 1.0f;
                                                                 }
                                                             }
                                                         }
                                                         
                                                     }];
                                }
                                
                            }];

       } completion:nil];
        
    }
}


@end
