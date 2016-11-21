var exec = require('cordova/exec');

exports.shareTimeline = function(arg0, success, error) {
    exec(success, error, "WechatTimelineShare", "shareTimeline", [arg0]);
};
