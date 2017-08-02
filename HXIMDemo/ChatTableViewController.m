//
//  ChatTableViewController.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//  会话列表

#import "ChatTableViewController.h"

#import "ChatListCustomCell.h"

@interface ChatTableViewController ()<EMChatManagerDelegate,EMGroupManagerDelegate,EaseConversationListViewControllerDataSource>

@property (nonatomic, strong) NSMutableArray *msgArray;

@end

@implementation ChatTableViewController

- (NSMutableArray *)msgArray{
    
    if (!_msgArray) {
        self.msgArray = [NSMutableArray array];
    }
    return _msgArray;
}

- (void)viewWillAppear:(BOOL)animated{
 
    [super viewWillAppear:animated];
    
    //首次进入加载数据
    [self tableViewDidTriggerHeaderRefresh];
    
}

- (void)viewWillDisappear:(BOOL)animated {
   
    [super viewWillDisappear:animated];
    
    self.hidesBottomBarWhenPushed = NO;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"会话";
    
    self.showRefreshHeader = YES;
    
    self.dataSource = self;
    
}


- (void)tableViewDidTriggerFooterRefresh{
    
    
}


/*!
 @method
 @brief 获取最后一条消息显示的内容
 @discussion 用户根据conversationModel实现,实现自定义会话中最后一条消息文案的显示内容
 @param conversationListViewController 当前会话列表视图
 @param conversationModel 会话模型
 @result 返回用户最后一条消息显示的内容
 */
- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel{
    
    NSString *lastestMsgTitle = @"";
    
    EMMessage *lastMsg = [conversationModel.conversation latestMessage];
    
    if (lastMsg) {
        
        EMMessageBody *msgBody = lastMsg.body;
        
        switch (msgBody.type) {
            case EMMessageBodyTypeImage:
            {
                //图片消息
                
            }
                break;
            case EMMessageBodyTypeText:{
                //文字消息
                
                // 表情映射
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper convertToSystemEmoticons:((EMTextMessageBody *)msgBody).text];
                
                lastestMsgTitle = didReceiveText;
                
                if ([lastMsg.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
                    lastestMsgTitle = @"[动画表情]";
                }
                
            }
                break;
            case EMMessageBodyTypeVoice:{
               
                lastestMsgTitle = NSLocalizedString(@"message.voice1", @"[voice]");
            
            } break;
            
            case EMMessageBodyTypeLocation: {
            
                lastestMsgTitle = NSLocalizedString(@"message.location1", @"[location]");
            
            }
                break;
            
            case EMMessageBodyTypeVideo: {
            
                lastestMsgTitle = NSLocalizedString(@"message.video1", @"[video]");
            }
                break;
            case EMMessageBodyTypeFile: {
               
                lastestMsgTitle = NSLocalizedString(@"message.file1", @"[file]");
            
            }
                break;
            
            default:
                break;
       
        }
    
    }
    
    [self.msgArray addObject:lastestMsgTitle];
    
    return lastestMsgTitle;
    
}


//最后一条消息展示时间样例

- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel {
   
    NSString *latestMessageTime = @"";
    
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    
    if (lastMessage) {
    
        latestMessageTime = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    
    }
    
    return latestMessageTime;

}


/*!
 @method
 @brief 构建实现协议IConversationModel的model
 @discussion 用户可以创建实现协议IConversationModel的自定义conversationModel对象，按照业务需要设置属性值
 @param conversationListViewController 当前会话列表视图
 @param conversation 会话对象
 @result 返回实现协议IConversationModel的model对象
 */
//- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
//                                    modelForConversation:(EMConversation *)conversation {
//    
//    return @"";
//
//}


@end
