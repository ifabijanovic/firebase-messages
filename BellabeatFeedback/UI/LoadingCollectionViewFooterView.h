//
//  LoadingCollectionViewFooterView.h
//  BellabeatFeedback
//
//  Created by Ivan Fabijanović on 23/11/15.
//  Copyright © 2015 Bellabeat. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLoadingViewIdentifier @"loadingView"

@interface LoadingCollectionViewFooterView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
