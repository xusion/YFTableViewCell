# YFTableViewCell
支持Cell滑动删除


#优点：
  1.支持代码和.xib等方式自定义tableViewCell
  2.使用简单，继承于YFTableViewCell即可

#使用步骤：
  1.将你的tableViewCell继承于YFTableViewCell
  2.设置cell.delegate = self;
  3.设置cell.editButtonArray = array;(array为存有 __kindof UIButton 的数组)
  4.实现两个代理方法
      - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
      - (void)tableView:(UITableView *)tableView didClickedEditButtonAtButtonIndex:(NSInteger)buttonIndex atIndexPath:(NSIndexPath *)indexPath
  注：第二个代理方法里的操作相见Demo
     下一版本将支持swift
