package v5mobile.pma.eiselsbe.com.v5mobile;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.adobe.marketing.mobile.AdobeCallback;
import com.adobe.marketing.mobile.Analytics;
import com.adobe.marketing.mobile.Campaign;
import com.adobe.marketing.mobile.Identity;
import com.adobe.marketing.mobile.InvalidInitException;
import com.adobe.marketing.mobile.Lifecycle;
import com.adobe.marketing.mobile.LoggingMode;
import com.adobe.marketing.mobile.MobileCore;
//import com.adobe.marketing.mobile.Places;
//import com.adobe.marketing.mobile.PlacesMonitor;
import com.adobe.marketing.mobile.Signal;
import com.adobe.marketing.mobile.Target;
import com.adobe.marketing.mobile.TargetParameters;
import com.adobe.marketing.mobile.TargetPrefetch;
import com.adobe.marketing.mobile.TargetRequest;
import com.adobe.marketing.mobile.UserProfile;


import com.adobe.marketing.mobile.VisitorID;
import com.google.android.gms.ads.identifier.AdvertisingIdClient;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.InstanceIdResult;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class MainActivity extends AppCompatActivity {
    public static final String EXTRA_MESSAGE = "v5mobile.pma.eiselsbe.com.v5mobile.MESSAGE";
    private static final String TAG = "MainActivity";
    Map<String, String> visitor_profiles = new HashMap<String, String>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        MobileCore.setApplication(getApplication());
        MobileCore.setLogLevel(LoggingMode.DEBUG);

        try {
            Campaign.registerExtension();
            Target.registerExtension();
            Analytics.registerExtension();
            UserProfile.registerExtension();
            Identity.registerExtension();
            Lifecycle.registerExtension();
            Signal.registerExtension();

            MobileCore.start(new AdobeCallback () {
                @Override
                public void call(Object o) {
                    /*launch*/
                    MobileCore.configureWithAppID("launch-ENf08a9f5b947c412aaf2e16fe491d71cb");

                    AdvertisingIdClient.Info idInfo;
                    String adid = null;
                    Context appContext = getApplicationContext();

                    try {
                        idInfo = AdvertisingIdClient.getAdvertisingIdInfo(appContext);
                        if (idInfo != null) {
                            adid = idInfo.getId();
                            MobileCore.setAdvertisingIdentifier(adid);
                        }
                    } catch (Exception ex) {
                        Log.e("Error", ex.getLocalizedMessage());
                    }


                    FirebaseInstanceId.getInstance().getInstanceId()
                            .addOnCompleteListener(new OnCompleteListener<InstanceIdResult>() {
                                @Override
                                public void onComplete(@NonNull Task<InstanceIdResult> task) {
                                    if (!task.isSuccessful()) {
                                        //To do
                                        return;
                                    }

                                    // Get the Instance ID token
                                    String token = task.getResult().getToken();
                                    String msg = getString(R.string.fcm_token, token);
                                    Log.d(TAG, msg);
                                    Toast.makeText(MainActivity.this, msg, Toast.LENGTH_SHORT).show();
                                    MobileCore.setPushIdentifier(token);

                                }
                            });

                    /*
                     * Get the ECID and store in the UserModel
                     */
                    Identity.getExperienceCloudId(new AdobeCallback<String>() {
                        @Override
                        public void call(String id) {
                            Log.d(TAG, id);
                        }
                    });
                }
            });


        } catch (InvalidInitException e) {
            Log.e("Error", e.getLocalizedMessage());
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

        Map<String, String> mboxParameters1 = new HashMap<>();
        mboxParameters1.put("mobileUserType", "platinum");

        // Define the profile parameters map.
        Map<String, String> profileParameters = new HashMap<>();
        profileParameters.put("ageGroup", "20-32");

        TargetParameters targetParameters1 = new TargetParameters.Builder()
                .parameters(mboxParameters1)
                .profileParameters(profileParameters)
                .build();

        /*
        TargetPrefetch prefetchRequest1 = new TargetPrefetch("buttonColor", targetParameters1);


        List<TargetPrefetch> prefetchList = new ArrayList<TargetPrefetch>();
        prefetchList.add(prefetchRequest1);

        TargetParameters targetParameters = null;

        Target.prefetchContent(prefetchList, targetParameters, new AdobeCallback<String>() {
            @Override
            public void call(String s) {
                // do something with target content.
                Log.d(TAG, s);
                TextView textView = findViewById(R.id.tvtarget);
                textView.setText(s);
            }
        });
        */


        TargetRequest request = new TargetRequest("buttonColor", targetParameters1, "{\"text\":\"default\"}", new AdobeCallback<String>() {
            @Override
            public void call(String s) {
                Log.d(TAG, s);
                TextView textView = findViewById(R.id.tvtarget);
                textView.setText(s);
            }
        });

        List<TargetRequest> requestList = new ArrayList<>();
        requestList.add(request);
        TargetParameters targetParameters = null;
        Target.retrieveLocationContent(requestList, targetParameters);
    }

    /**
     * Get the experience cloud id - ecid back from the Identity service.
     * @param view
     */
    public void login(View view) {

        Identity.getExperienceCloudId(new AdobeCallback<String>() {
            @Override
            public void call(String ecid) {
                final String eid = ecid;
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        String msg = getString(R.string.msg_ecid_fmt, eid);
                        Log.d(TAG, msg);
                        TextView textView = findViewById(R.id.etlogin);
                        textView.setText(eid);
                        Toast.makeText(MainActivity.this, msg, Toast.LENGTH_SHORT).show();
                    }
                });
            }
        });
    }

    @Override
    public void onResume() {
        Log.d("-------LOGGER", "OnResume for main activity");
        super.onResume();


        String crm_id = "";
        String authState = "";

        if(authState.equals("Logged in")){
            visitor_profiles.put("x_device_id",crm_id);
            Identity.syncIdentifiers(visitor_profiles, VisitorID.AuthenticationState.AUTHENTICATED);
        }

        MobileCore.setApplication(getApplication());
        MobileCore.lifecycleStart(null);

        //---Analytics Code - start
        String pagename = "v5mobile:home";
        Map<String, String> analyticsData = new HashMap<String, String>();
        analyticsData.put("pagename", pagename);
        analyticsData.put("device","mobile");
        analyticsData.put("category","home");
        analyticsData.put("crm_id",crm_id);
        analyticsData.put("authstate",authState);
        MobileCore.trackState(pagename, analyticsData);
        //---Analytics Code - End

    }

    @Override
    public void onPause() {
        Log.d("-------LOGGER", "OnPause for main activity");
        super.onPause();
        MobileCore.lifecyclePause();
    }

}
