package com.example.fritz.livedemo;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.Menu;
import android.widget.Button;
import android.widget.TextView;

import com.unity3d.ads.IUnityAdsListener;
import com.unity3d.ads.UnityAds;

public class MainActivity extends AppCompatActivity {

    final private UnityAdsListener unityAdsListener = new UnityAdsListener();
    public int coins;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        coins = 0;
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {

        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    public void buttonOnClick(View v) {
        Button mButton = (Button) findViewById(R.id.button);
        if(UnityAds.isReady()){
            UnityAds.show(this, "video");
        }else{
            mButton.setText("Initializing");
            UnityAds.initialize(this, "1014764", unityAdsListener);
        }
    }

    public void rewardPlayer() {
        TextView mTextView = (TextView) findViewById(R.id.textView);
        coins = coins + 10;
        mTextView.setText("Coins: " + Integer.toString(coins));
    }

    private class UnityAdsListener implements IUnityAdsListener {
        @Override
        public void onUnityAdsReady(String s) {
            final Button mButton = (Button) findViewById(R.id.button);
            mButton.setText("Show Ad");
        }

        @Override
        public void onUnityAdsStart(String s) {

        }

        @Override
        public void onUnityAdsFinish(String s, UnityAds.FinishState finishState) {
            if (finishState != UnityAds.FinishState.SKIPPED) {
                rewardPlayer();
            }
        }
        @Override
        public void onUnityAdsError(UnityAds.UnityAdsError unityAdsError, String s) {

        }
    }
}