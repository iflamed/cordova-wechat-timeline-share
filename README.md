微信分享到朋友圈多图

-------------

# iOS如何调用分享

```javascript
// when use it with ios app, the paths should be base64 data url

var paths = ['base64 image data', 'base64 image data'];
WechatTimelineShare.shareTimeline(
    {
        urls: paths
    },
    function (msg) {
        console.log(msg);
    },
    function (err) {
        console.log(err);
    }
)
```

# Android 如何调用分享

```javascript
// when use it with android app, the paths should be absolute path

var paths = [
    '/storage/emulated/0/Pictures/wechattimelineshare1.jpeg',
    '/storage/emulated/0/Pictures/wechattimelineshare0.jpeg'
]

WechatTimelineShare.shareTimeline(
    {
        urls: paths,
        message:"测试分享功能"
    },
    function (msg) {
        console.log(msg);
    },
    function (err) {
        console.log(err);
    }
)
```

