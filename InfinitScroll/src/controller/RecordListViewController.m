//
//  RecordListViewController.m
//  InfinitScroll
//
//  Created by Gino Shen on 2016/10/14.
//  Copyright © 2016年 Gino. All rights reserved.
//

#import "RecordListViewController.h"
#import "RecordModel.h"
#import "SourceModel.h"
#import "DestinationModel.h"
#import "RecordViewCell.h"

@interface RecordListViewController ()
{
    BOOL isLoadingMore;         // YES or NO, set to YES if app is fetching data;
    BOOL shouldLoadMore;        // YES or NO, set to NO if response data count from server is less than maximun return data count. that means no more data.
}
@property (weak, nonatomic) IBOutlet UITableView *theTableView;
@property(nonatomic, strong) NSArray *arrayRecordList;
@property(strong, nonatomic)UIView *theLoadMoreView;
@property(strong, nonatomic)UIActivityIndicatorView* theLoadMoreIndicatorView;

@end

@implementation RecordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLoader];
    shouldLoadMore = YES;
    [self loadDataFromIdex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)arrayRecordList
{
    if (!_arrayRecordList) {
        _arrayRecordList = [[NSArray alloc] init];
    }
    return _arrayRecordList;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrayRecordList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm"];
    RecordModel *rData = self.arrayRecordList[indexPath.row];
    RecordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordViewCell" forIndexPath:indexPath];
    cell.indexLabel.text = rData.recordId.stringValue;
    [cell.indexLabel.layer setCornerRadius:15];
    cell.indexLabel.clipsToBounds = YES;
    cell.sourceLabel.text = rData.source.sender;
    cell.destinationLabel.text = rData.destination.recipient;
    cell.noteLabel.text = rData.source.note;
    cell.dataLabel.text  = [df stringFromDate:rData.created];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@ %@", rData.destination.currency, rData.destination.amount];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // detect when all visible cells have been loaded and displayed
    NSArray *visibleRows = [tableView indexPathsForVisibleRows];
    NSIndexPath *lastVisibleCellIndexPath = [visibleRows lastObject];
    if (lastVisibleCellIndexPath.row + 8>=[self.arrayRecordList count]) {
        // start next data fetch if last 8 records is displayed on screen.
        if (!isLoadingMore || [self.arrayRecordList count]<MAXIMUN_DOWNLOAD_COUNT_PER_TIME) {
            isLoadingMore = YES;
            RecordModel *nData = [self.arrayRecordList lastObject];
            NSInteger index = nData.recordId.integerValue + 1;
            [self loadDataFromIdex:index];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordModel *rData = self.arrayRecordList[indexPath.row];
    return rData.cellHeight;
}


#pragma mark - Common API

- (void) setLoader
{
    self.theLoadMoreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    self.theLoadMoreView.backgroundColor = [UIColor whiteColor];
    self.theLoadMoreIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.theLoadMoreIndicatorView.center = self.theLoadMoreView.center;
    [self.theLoadMoreView addSubview:self.theLoadMoreIndicatorView];
    [self.theLoadMoreIndicatorView startAnimating];
    self.theTableView.tableFooterView = self.theLoadMoreView;
    self.theLoadMoreView.hidden = YES;

}

- (void)loadDataFromIdex:(NSInteger )index
{
    if (!shouldLoadMore) {
        isLoadingMore = NO;
        return;
    }
    self.theLoadMoreView.hidden = NO;
    
    [RecordModel getRecordFromIndex:[NSNumber numberWithInteger:index] completion:^(id data){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray*list = (NSArray *)data;
            shouldLoadMore = list.count==MAXIMUN_DOWNLOAD_COUNT_PER_TIME;
            isLoadingMore = NO;
            if (shouldLoadMore) {
                self.arrayRecordList = [self.arrayRecordList arrayByAddingObjectsFromArray:list];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.theLoadMoreView.hidden = YES;
                    [self.theTableView reloadData];
                });
            }
        });
        
    } failure:^(NSError *error){
        isLoadingMore = NO;
        self.theLoadMoreView.hidden = YES;
    }];

}



@end
