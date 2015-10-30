//
//  SelfieTableViewCell.m
//  Camera
//
//  Created by Mac Bellingrath on 10/19/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

#import "SelfieTableViewCell.h"

@interface SelfieTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *selfieImageView;
@property (weak, nonatomic) IBOutlet UILabel *selfieCaptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selfieProfileImage;

@end

@implementation SelfieTableViewCell

-(void)setSelfie:(PFObject *)selfie {
    
     _selfie = selfie;
    
    [self updateInfo];
   
}

-(void)updateInfo{
   
    NSLog(@"%@", self.selfie);
    self.selfieCaptionLabel.text = self.selfie[@"caption"];
    PFFile *userImageFile = self.selfie[@"imageFile"];
   
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
           
            self.selfieImageView.image = [UIImage imageWithData:imageData];
            [self setNeedsDisplay];
            
        }
    }];

}



- (void)didMoveToWindow {
    [self updateInfo];
}


@end
