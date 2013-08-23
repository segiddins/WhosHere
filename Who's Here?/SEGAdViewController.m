#import "SEGAdViewController.h"
#import "SEGAppDelegate.h"


@interface SEGAdViewController () <ADBannerViewDelegate>

@property ADBannerView *bannerView;
@property UIViewController *contentController;

@end

@implementation SEGAdViewController {
}

- (instancetype)initWithContentViewController:(UIViewController *)contentController {
    self = [super init];
    if (self != nil) {
        _contentController = contentController;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appShouldAddBannerView:) name:SEGAppShouldDisplayBannerNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appShouldHideBannerView:) name:SEGAppShouldHideBannerNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appShouldDeleteBannerView:) name:SEGAppShouldDeleteBannerNotification object:nil];
    }
    return self;
}

- (void)loadView {
    UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self addChildViewController:_contentController];
    [contentView addSubview:_contentController.view];
    [_contentController didMoveToParentViewController:self];
    self.view = contentView;
}

- (void)appShouldAddBannerView:(NSNotification *)notification {
    //  NSLog(@"appShouldAddBannerView %@", _bannerView);
    if (! _bannerView) {
        if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
            _bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        } else {
            _bannerView = [[ADBannerView alloc] init];
        }
        _bannerView.delegate = self;
    }
    [self.view addSubview:_bannerView];
    [self.view setNeedsLayout];
}
- (void)appShouldDeleteBannerView:(NSNotification *)notification {
    //  NSLog(@"appShouldDeleteBannerView %@", _bannerView);
    if (_bannerView) {
        _bannerView.delegate = nil;
        [_bannerView removeFromSuperview];
        _bannerView = nil;
    }
}
- (void)appShouldHideBannerView:(NSNotification *)notification {
    [_bannerView removeFromSuperview];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return [_contentController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}
#endif

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [_contentController preferredInterfaceOrientationForPresentation];
}

- (NSUInteger)supportedInterfaceOrientations {
    return [_contentController supportedInterfaceOrientations];
}

- (void)viewDidLayoutSubviews {
    // NSLog(@"in viewDidLayoutSubviews _bannerView=%@", _bannerView);
    CGRect contentFrame = self.view.bounds, bannerFrame = CGRectZero;
    
    if (!_bannerView || self.view != _bannerView.superview)  {
        _contentController.view.frame = contentFrame;
        return;
    }
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
    // If configured to support iOS <6.0, then we need to set the currentContentSizeIdentifier in order to resize the banner properly.
    // This continues to work on iOS 6.0, so we won't need to do anything further to resize the banner.
    if (contentFrame.size.width < contentFrame.size.height) {
        _bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    } else {
        _bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    }
    bannerFrame = _bannerView.frame;
#else
    // If configured to support iOS >= 6.0 only, then we want to avoid currentContentSizeIdentifier as it is deprecated.
    // Fortunately all we need to do is ask the banner for a size that fits into the layout area we are using.
    // At this point in this method contentFrame=self.view.bounds, so we'll use that size for the layout.
    bannerFrame.size = [_bannerView sizeThatFits:contentFrame.size];
#endif
    
    // NSLog(@"in viewDidLayoutSubviews, _bannerView.bannerLoaded=%d", _bannerView.bannerLoaded);
    
    if (_bannerView.bannerLoaded) {
        contentFrame.size.height -= bannerFrame.size.height;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        bannerFrame.origin.y = contentFrame.size.height;
    }
    _contentController.view.frame = contentFrame;
    _bannerView.frame = bannerFrame;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    //   NSLog(@"in bannerViewDidLoadAd");
    [UIView animateWithDuration:0.25 animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    //   NSLog(@"in didFailToReceiveAdWithError");
    [UIView animateWithDuration:0.25 animations:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    //   NSLog(@"in bannerViewActionShouldBegin");
//    [[NSNotificationCenter defaultCenter] postNotificationName:SEBannerViewActionWillBeginNotification object:self];
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    //  NSLog(@"in bannerViewActionDidFinish");
//    [[NSNotificationCenter defaultCenter] postNotificationName:SEBannerViewActionDidFinishNotification object:self];
}

@end
