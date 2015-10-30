//
//  SelfieDetailViewController.h
//  Camera
//
//  Created by Mac Bellingrath on 10/19/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
@interface SelfieDetailViewController : UIViewController
@property (nonatomic) PFObject * selfie;
@end
