package cordovawechattimelineshare;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.util.ArrayList;
import java.util.List;

/**
 * This class echoes a string called from JavaScript.
 */
public class WechatTimelineShare extends CordovaPlugin {
    private static final String LOG_TAG = "WechatTimelineSharePlugin";
    private List<String> paths = new ArrayList<String>();

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("shareTimeline")) {
            this.paths.clear();
            this.shareTimeline(args, callbackContext);
            return true;
        }
        return false;
    }

    private void shareTimeline(JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (args != null && args.length() > 0) {
            JSONObject jsonObject = args.getJSONObject(0);
            JSONArray urls = jsonObject.optJSONArray("urls") == null ? new JSONArray() : jsonObject.optJSONArray("urls");
            for (int i = 0; i < urls.length(); i++) {
              paths.add(urls.getString(i));
            }
            ShareUtils.share9PicsToWXCircle(webView.getContext(),
                jsonObject.optString("message", ""),
                paths);
            callbackContext.success("success");
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }
}
