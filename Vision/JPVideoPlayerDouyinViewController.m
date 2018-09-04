/*
 * This file is part of the JPVideoPlayer package.
 * (c) NewPan <13246884282@163.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *
 * Click https://github.com/newyjp
 * or http://www.jianshu.com/users/e2f2d779c022/latest_articles to contact me.
 */

#import "JPVideoPlayerDouyinViewController.h"
#import "JPVideoPlayerKit.h"

@interface JPDouyinProgressView: JPVideoPlayerProgressView

@end

@implementation JPDouyinProgressView

- (void)layoutThatFits:(CGRect)constrainedRect
nearestViewControllerInViewTree:(UIViewController *_Nullable)nearestViewController
  interfaceOrientation:(JPVideoPlayViewInterfaceOrientation)interfaceOrientation {
    [super layoutThatFits:constrainedRect
nearestViewControllerInViewTree:nearestViewController
            interfaceOrientation:interfaceOrientation];

    self.trackProgressView.frame = CGRectMake(0,
            constrainedRect.size.height - JPVideoPlayerProgressViewElementHeight - nearestViewController.tabBarController.tabBar.bounds.size.height,
            constrainedRect.size.width,
            JPVideoPlayerProgressViewElementHeight);
    self.cachedProgressView.frame = self.trackProgressView.bounds;
    self.elapsedProgressView.frame = self.trackProgressView.frame;
}

@end

@interface JPVideoPlayerDouyinViewController()<UIScrollViewDelegate, JPVideoPlayerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *firstImageView;

@property (nonatomic, strong) UIImageView *secondImageView;

@property (nonatomic, strong) UIImageView *thridImageView;

@property (nonatomic, strong) NSArray<NSString *> *douyinVideoStrings;

@property(nonatomic, assign) NSUInteger currentVideoIndex;

@property(nonatomic, assign) CGFloat scrollViewOffsetYOnStartDrag;

@end

@implementation JPVideoPlayerDouyinViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.contentInset = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.scrollViewOffsetYOnStartDrag = -100;
    [self scrollViewDidEndScrolling];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.secondImageView jp_stopPlay];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (decelerate == NO) {
        [self scrollViewDidEndScrolling];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrolling];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.scrollViewOffsetYOnStartDrag = scrollView.contentOffset.x;
}


#pragma mark - JPVideoPlayerDelegate

- (BOOL)shouldShowBlackBackgroundBeforePlaybackStart {
    return YES;
}

#pragma mark - Private

- (void)scrollViewDidEndScrolling {
    if(self.scrollViewOffsetYOnStartDrag == self.scrollView.contentOffset.x){
        return;
    }
    // When they equal, scrollView didn't scroll to next page, cause back to orinal offset
    

    CGSize referenceSize = UIScreen.mainScreen.bounds.size;
    [self.scrollView setContentOffset:CGPointMake(referenceSize.width, 0) animated:NO]; //changed
    [self.secondImageView jp_stopPlay];
    [self.secondImageView jp_playVideoMuteWithURL:[self fetchDouyinURL]
                               bufferingIndicator:nil
                                     progressView:[JPDouyinProgressView new]
                                    configuration:^(UIView *view, JPVideoPlayerModel *playerModel) {
                                        view.jp_muted = NO;
                                    }];
}

- (NSURL *)fetchDouyinURL {
    if(self.currentVideoIndex == (self.douyinVideoStrings.count - 1)){
        self.currentVideoIndex = 0;
    }
    NSURL *url = [NSURL URLWithString:self.douyinVideoStrings[self.currentVideoIndex]];
    self.currentVideoIndex++;
    return url;
}

- (NSArray<NSString *> *)douyinVideoStrings {
    if(!_douyinVideoStrings){
        _douyinVideoStrings = @[
                @"https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_2187.MOV",
                @"https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_2325.MOV",
                @"https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_3385.MOV",
                @"https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_4652.MOV",
        ];
    }
    return _douyinVideoStrings;
}


#pragma mark - Setup

- (void)setup {
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize referenceSize = UIScreen.mainScreen.bounds.size;
    self.currentVideoIndex = 0;

    self.scrollView = ({
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:scrollView];
        scrollView.frame = self.view.bounds;
        scrollView.contentSize = CGSizeMake(referenceSize.width * 3, referenceSize.height);
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;

        scrollView;
    });

    self.firstImageView = ({
        UIImageView *imageView = [UIImageView new];
        [self.scrollView addSubview:imageView];
        imageView.frame = CGRectMake(0, 0, referenceSize.width, referenceSize.height);
        imageView.image = [UIImage imageNamed:@"placeholder1"];

        imageView;
    });

    self.secondImageView = ({
        UIImageView *imageView = [UIImageView new];
        [self.scrollView addSubview:imageView];
        imageView.frame = CGRectMake(referenceSize.width, 0, referenceSize.width, referenceSize.height);
        imageView.image = [UIImage imageNamed:@"placeholder2"];
        imageView.jp_videoPlayerDelegate = self;

        imageView;
    });

    self.thridImageView = ({
        UIImageView *imageView = [UIImageView new];
        [self.scrollView addSubview:imageView];
        imageView.frame = CGRectMake(referenceSize.width*2, 0, referenceSize.width, referenceSize.height);
        imageView.image = [UIImage imageNamed:@"placeholder1"];

        imageView;
    });
}

@end
