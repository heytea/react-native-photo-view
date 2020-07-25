package com.heyteago.photoview;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentPagerAdapter;
import androidx.viewpager.widget.ViewPager;

import java.util.ArrayList;
import java.util.List;

public class PhotoViewActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_photo_view);
        ViewPager viewPager = findViewById(R.id.vp_photo_view);

        Intent intent = getIntent();
        String[] urls = intent.getStringArrayExtra("urls");
        String current = intent.getStringExtra("current");
        int currentIndex = 0;

        final List<Fragment> fragmentList = new ArrayList<>();
        for (int i = 0; i < urls.length; i ++) {
            PhotoFragment photoFragment = new PhotoFragment(urls[i]);
            fragmentList.add(photoFragment);
            if (urls[i].equals(current)) {
                currentIndex = i;
            }
        }

        viewPager.setAdapter(new FragmentPagerAdapter(getSupportFragmentManager()) {
            @Override
            public int getCount() {
                return fragmentList.size();
            }

            @NonNull
            @Override
            public Fragment getItem(int position) {
                return fragmentList.get(position);
            }

        });
        viewPager.setCurrentItem(currentIndex, false);
    }
}