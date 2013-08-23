#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface SEGAdViewController : UIViewController  <ADBannerViewDelegate>

- (instancetype)initWithContentViewController:(UIViewController *)contentController;

@end
