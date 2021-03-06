//
//  ViewController.m
//  WKWebViewController
//
//  Created by gjfax on 2020/1/7.
//  Copyright © 2020 MXCoder. All rights reserved.
//

#import "BA_WKWebViewVC.h"
#import "WKWebViewController.h"
#import "BAKitVC_WKWebView2.h"

static NSString * const kCellID = @"ViewControllerCell";
static NSString * const kURL1 = @"https://www.baidu.com";

@interface BA_WKWebViewVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;
@end

@implementation BA_WKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BAWKWebView";
    self.view.backgroundColor = [UIColor lightGrayColor];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellID];
    }
    
    NSString *msg = [@(indexPath.row + 1).stringValue stringByAppendingString:@"、"];
    cell.textLabel.text = [msg stringByAppendingString:self.dataArray[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            WKWebViewController *webVC = [WKWebViewController new];
            webVC.wk_web_progressTintColor = [UIColor cyanColor];
            webVC.wk_web_progressTrackTintColor = [UIColor blueColor];
            [webVC wk_web_loadURLString:kURL1];
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case 1:
        {
            NSString *headStr = @"<head><style>img{width:100% !important}</style></head>";
            
            NSString *image1 = [NSString stringWithFormat:@"<div style=\"margin: -8px -8px;\"><img src='%@'/></div>",@"http://imgsrc.baidu.com/image/c0%3Dshijue%2C0%2C0%2C245%2C40/sign=4ea99ec2f8d3572c72ef949fe27a0952/f7246b600c338744af80e6575b0fd9f9d72aa050.jpg"];
            NSString *contentStr = @"要知道，《后会无期》不是主流类型片，是一个文艺片。不像《小时代》，是一个商业主流的偶像电影。";
            NSString *htmlURlStr = [NSString stringWithFormat:@"%@<body style='background-color:#ffffff'>%@<br><div style=\"margin: 15px 15px;\">%@</div></body>", headStr, image1, contentStr];
            
            WKWebViewController *webVC = [WKWebViewController new];
            webVC.title = @"博爱之家";
            [webVC wk_web_loadHTMLString:htmlURlStr];
            
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case 2:
        {
            NSURL *url = [[NSBundle mainBundle] URLForResource:@"BAWebView" withExtension:@"html"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            WKWebViewController *webVC = [WKWebViewController new];
            webVC.title = self.dataArray[indexPath.row];
            
            [webVC wk_web_loadRequest:request];
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case 3:
        {
            WKWebViewController *webVC = [WKWebViewController new];
            webVC.title = self.dataArray[indexPath.row];
            [webVC wk_web_loadHTMLFileName:@"BAHome"];
            
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case 4:
        {
            BAKitVC_WKWebView2 *vc2 = [BAKitVC_WKWebView2 new];
            vc2.title = self.dataArray[indexPath.row];
            
            [self.navigationController pushViewController:vc2 animated:YES];
        }
            break;
        case 5:
        {
            WKWebViewController *vc2 = [WKWebViewController new];
            vc2.title = self.dataArray[indexPath.row];
            [self.navigationController pushViewController:vc2 animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}


#pragma mark - setter / getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = [UIColor lightGrayColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [UIView new];
        self.tableView.estimatedRowHeight = 44;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (NSArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[@"加载普通 URL",
                       @"加载 后台返回 的 htmlString",
                       @"加载自定义 request",
                       @"加载本地 HTML 文件",
                       @"OC JS 互调",
                       @"cell 中添加 html"
                       ];
    }
    return _dataArray;
}

@end
