#import <UIKit/UIKit.h>


#pragma GCC diagnostic ignored "-Wunused-variable"
#pragma GCC diagnostic ignored "-Wprotocol"
#pragma GCC diagnostic ignored "-Wmacro-redefined"
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#pragma GCC diagnostic ignored "-Wincomplete-implementation"
#pragma GCC diagnostic ignored "-Wunknown-pragmas"
#pragma GCC diagnostic ignored "-Wformat"
#pragma GCC diagnostic ignored "-Wunknown-warning-option"
#pragma GCC diagnostic ignored "-Wincompatible-pointer-types"




@interface TFNTwitterUser : NSObject
@property (nonatomic, assign, readonly) NSString *twitterURL;
@property (nonatomic, copy, readonly) NSString *bio;
@property (nonatomic, assign, readonly) NSInteger numberOfFollowing;
@property (nonatomic, assign, readonly) NSInteger numberOfFollowers;
@property (nonatomic, copy, readonly) NSString *displayUsername;
@end

@interface TFNTwitterUserDataSource : NSObject
@property (nonatomic, assign, readonly) TFNTwitterUser *user;
@end

@interface T1ProfileUserViewModel : NSObject
@property (nonatomic, assign, readonly) TFNTwitterUserDataSource *userDataSource;
@property NSInteger blockingViewerRelationshipState;
@end


@interface T1ProfileHeaderViewController : UIViewController <SFSafariViewControllerDelegate>
@property (nonatomic, strong, readwrite) T1ProfileUserViewModel *viewModel;
@end

@interface T1AppSplitViewController : UIView
@end

%hook T1ProfileHeaderViewController
-(void)viewDidLoad {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

  [NSThread sleepForTimeInterval:1];
        
  dispatch_async(dispatch_get_main_queue(), ^{
      NSInteger BlockOrNot = self.viewModel.blockingViewerRelationshipState;
      NSString *BlockOrNotConvertToString = [NSString stringWithFormat:@"%ld",BlockOrNot];

    if ([BlockOrNotConvertToString isEqualToString:@"1"]) {
      NSArray *Connect = [CMManager InitButtonImage:[UIImage imageNamed:@"/Library/Application Support/TWBlock.bundle/blocked.png"] InView:self.view Target:self Action:@selector(TWBlockView)];

      UIImageView *ConnectButton = [Connect objectAtIndex:1];

      [ConnectButton setTranslatesAutoresizingMaskIntoConstraints:NO];

      [NSLayoutConstraint activateConstraints:@[

      [ConnectButton.topAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-30],
      [ConnectButton.leadingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-30],
      [ConnectButton.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:30],
      [ConnectButton.bottomAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:30],

   ]];
  }
 });
});


    return %orig;


}
%new - (void)TWBlockView {

    NSString *twitterURL = self.viewModel.userDataSource.user.twitterURL;
    NSLog(@"twitterURL = %@",twitterURL);

}

%end







