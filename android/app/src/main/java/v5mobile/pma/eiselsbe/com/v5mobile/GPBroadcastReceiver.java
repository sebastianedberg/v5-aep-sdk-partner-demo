package v5mobile.pma.eiselsbe.com.v5mobile;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class GPBroadcastReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context c, Intent i){
        Log.d("-------LOGGER","Broadcast received");
    }
}
