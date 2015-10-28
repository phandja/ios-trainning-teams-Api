//
//  TeamsVC.m
//  ios-teams-API
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import "TeamsVC.h"
#import "Teams.h"
#import "AFNetworking.h"
#import "TitleDC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TeamsVC ()

@property (nonatomic, strong) NSArray *clubes;

@end

@implementation TeamsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://mockbrasileirao.herokuapp.com/api/teams" parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSArray *teamsParsed = [responseObject objectForKey:@"teams" ];
             NSError *error;
             self.clubes = [MTLJSONAdapter modelsOfClass:Teams.class fromJSONArray:teamsParsed error:&error];
             
             [self.tableView reloadData];
             NSLog(@"Teste");
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

#pragma mark - Navigation


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.clubes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleDC *cel = [tableView dequeueReusableCellWithIdentifier:@"TeamCellIdentifier" forIndexPath:indexPath];
    
    Teams *team = self.clubes[indexPath.row];
    
    cel.nameLabel.text = team.name ;
    cel.image.image = nil;
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [cel.imageView sd_setImageWithURL:[NSURL URLWithString:team.logo_url]];
            [cel setNeedsDisplay];
            
            });
        });
    
    return cel;
}
@end
