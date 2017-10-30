# YFTableViewCell for Objective-C And Swift - version 1.1
> 方便快捷地实现类似QQ的自定义侧滑删除效果，同时支持OC和Swift，集成简单快速，同时支持code和IB。

## 优点：
- 1.按钮支持文字、图标、文字+图标
- 2.支持任一自定义按钮（UIButton或其子类）
- 3.集成简单，继承于YFTableViewCell即可
- 4.同时支持code和IB创建cell
- 5.同时支持OC和Swift
  
## 演示

![演示动画 演示动画](https://github.com/saxueyang/YFTableViewCell/blob/master/YFTableViewCell/YFTableViewCell.gif)

## 使用步骤：
- 1.将你的tableViewCell继承于YFTableViewCell
- 2.设置cell.delegate = self;
- 3.设置cell.editButtonArray = array;(array为存有 __kindof UIButton 的数组)
- 4.实现两个代理方法
    - OC<br />
        `- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath`<br />
        `- (void)tableView:(UITableView *)tableView didClickedEditButtonAtButtonIndex:(NSInteger)buttonIndex atIndexPath:(NSIndexPath *)indexPath`
    - Swift<br />
        `func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)`<br />
        `func tableView(_ tableView: UITableView, didClickedEditButtonAt buttonIndex: Int, At IndexPath:IndexPath)`

##  version 1.1 更新内容

- 1.重构部分方法，使其兼容iOS11
- 2.支持Swift
