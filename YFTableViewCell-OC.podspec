Pod::Spec.new do |s|
  s.name         = "YFTableViewCell-OC"
  s.version      = "1.0.0"
  s.summary      = "方便快捷地实现类似QQ的自定义侧滑删除效果，同时支持OC和Swift，集成简单快速，同时支持code和IB。"
  s.homepage     = "https://github.com/DandreYang/YFTableViewCell"
  s.license      = "MIT"
  s.author             = { "‘Dandre’" => "mkshow@126.com" }
  s.social_media_url   = "https://yangfeng.pw"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/DandreYang/YFTableViewCell.git", :tag => "#{s.version}" }
  s.source_files  = "YFTableViewCell/YFTableViewCell/**/*.{h,m}"
  s.public_header_files = "YFTableViewCell/YFTableViewCell/**/*.h"
end