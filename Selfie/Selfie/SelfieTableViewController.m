//
//  SelfieTableViewController.m
//  Camera
//
//  Created by Mac Bellingrath on 10/19/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

#import "SelfieTableViewController.h"
#import "SelfieTableViewCell.h"
#import "SelfieDetailViewController.h"
#import "Parse/Parse.h"
#import "CaptureViewController.h"


@interface SelfieTableViewController ()
-(void)logout;
- (IBAction)takeSelfieButtonPressed:(UIBarButtonItem *)sender;

@end

@implementation SelfieTableViewController {
    NSMutableArray *selfies;

}



-(void)viewDidLoad{
    
    [super viewDidLoad];

    NSLog(@"View did load");
    
    // Create image
    UIImage *image = [UIImage imageNamed: @"logo_white"];
    UIImageView *imageview = [[UIImageView alloc] initWithImage: image];
    
    // set the text view to the image view
    self.navigationItem.titleView = imageview;
   
 
    
    

    
    
    UIBarButtonItem *moreButton = [[UIBarButtonItem alloc] initWithTitle:@"..." style:UIBarButtonItemStylePlain target:self action: @selector(showMore)];
    [self navigationItem].leftBarButtonItem = moreButton;
    selfies = [@[] mutableCopy];
    
    PFQuery * selfieQuery = [PFQuery queryWithClassName:@"Selfie"];
    
    [selfieQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        for (PFObject *selfie in objects) {
           
            
            [selfies addObject: selfie];
            
        }
        
        NSLog(@"Query Completed");
       [self.tableView reloadData];
        
    }];
    
    NSLog(@"%@", selfies);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    NSLog(@"Current selfie count %d", (int)selfies.count);
    return selfies.count;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
#pragma mark: - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier  isEqual: @"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        SelfieDetailViewController *vc = (SelfieDetailViewController *)segue.destinationViewController;
        
        [vc setSelfie: selfies[indexPath.row]];
        
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    SelfieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.selfie = selfies[indexPath.row];
    return cell;
}
-(void)showMore {
    
  
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"More" message: @"Choose an option" preferredStyle: UIAlertControllerStyleActionSheet];
    

    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self logout];
    }];
    
    
    
    UIAlertAction *showProfileAction = [UIAlertAction actionWithTitle:@"Profile" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIStoryboard *userSB = [UIStoryboard storyboardWithName:@"User" bundle:nil];
        UINavigationController * nc = [userSB instantiateViewControllerWithIdentifier:@"AvatarVC"];
        
        [[self navigationController] presentViewController:nc animated:true completion:nil];
        

    }];
    [ac addAction:logoutAction];
    [ac addAction:showProfileAction];
    
    [self presentViewController:ac animated:YES completion:nil];
    
}

-(void)logout{
    [PFUser logOut];
    
  
   
    UIStoryboard *userSB = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    UINavigationController * nc = [userSB instantiateInitialViewController];
    
      [[self navigationController] presentViewController:nc animated:true completion:nil];


    
}

- (IBAction)takeSelfieButtonPressed:(UIBarButtonItem *)sender {
   
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Create" bundle:nil];
    UINavigationController *nc = [main instantiateInitialViewController];
    
    [[self navigationController] presentViewController:nc animated:true completion:nil];}


@end
