package v5mobile.pma.eiselsbe.com.v5mobile;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import com.adobe.marketing.mobile.AdobeCallback;
import com.adobe.marketing.mobile.Analytics;
import com.adobe.marketing.mobile.Identity;
import com.adobe.marketing.mobile.InvalidInitException;
import com.adobe.marketing.mobile.Lifecycle;
import com.adobe.marketing.mobile.LoggingMode;
import com.adobe.marketing.mobile.MobileCore;
import com.adobe.marketing.mobile.Signal;
import com.adobe.marketing.mobile.Target;
import com.adobe.marketing.mobile.TargetRequest;
import com.adobe.marketing.mobile.UserProfile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

public class MainActivity extends AppCompatActivity {
    public static final String EXTRA_MESSAGE = "v5mobile.pma.eiselsbe.com.v5mobile.MESSAGE";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        MobileCore.setApplication(getApplication());
        MobileCore.setLogLevel(LoggingMode.DEBUG);

        try {
            Analytics.registerExtension();
            Target.registerExtension();
            UserProfile.registerExtension();
            Identity.registerExtension();
            Lifecycle.registerExtension();
            Signal.registerExtension();
            MobileCore.start(new AdobeCallback () {
                @Override
                public void call(Object o) {
                    MobileCore.configureWithAppID("launch-EN58fdfb72764a4f81b0aaaaa3af9f8e95");
                }
            });
        } catch (InvalidInitException e) {

        }

    }
    
    /**
     * Send a message to the DisplayMessageAcitivy view.
     * @param view
     */
    public void sendMessage(View view) {
        Intent intent = new Intent(this, DisplayMessageActivity.class);
        EditText editText = (EditText) findViewById(R.id.editText);
        String message = editText.getText().toString();
        intent.putExtra(EXTRA_MESSAGE, message);
        startActivity(intent);
    }

    /**
     * Dispatch a track action.
     * @param view
     */
    public void sendAction(View view) {
        EditText editText = (EditText) findViewById(R.id.etaction);
        MobileCore.trackAction(editText.getText().toString(), null);
    }

    /**
     * Dispatch a track state.
     * @param view
     */
    public void sendState(View view) {
        EditText editText = (EditText) findViewById(R.id.etstate);
        MobileCore.trackState(editText.getText().toString(), null);
    }

    /**
     * Get a target activity for mbox buttonColor. Default content is a json color hex.
     * @param view
     */
    public void getTargetActivity(View view) {
        // define parameters for first request
        Map<String, String> mboxParameters = new HashMap<>();
        mboxParameters.put("mobileUserType", "platinum");

        TargetRequest request = new TargetRequest.Builder("buttonColor","{\"color\":\"#ff0000\"}")
                .setMboxParameters(mboxParameters)
                .setOrderParameters(new HashMap<String, Object>())
                .setProductParameters(new HashMap<String, String>())
                .setContentCallback(new AdobeCallback<String>() {
                    @Override
                    public void call(String value) {
                        // do something with target content.
                        TextView textView = findViewById(R.id.tvtarget);
                        textView.setText(value);

                    }
                }).build();

        List<TargetRequest> requestList = new ArrayList<>();
        requestList.add(request);

        // Define the profile parameters map.
        Map<String, String> profileParameters = new HashMap<>();
        profileParameters.put("ageGroup", "20-32");

        Target.loadRequests(requestList, profileParameters);
    }

    /**
     * Get the experience cloud id - ecid back from the Identity service.
     * @param view
     */
    public void login(View view) {
        Identity.getExperienceCloudId(new AdobeCallback<String>() {
            @Override
            public void call(String ecid) {
                TextView textView = findViewById(R.id.etlogin);
                textView.setText(ecid);
            }
        });
    }
}
