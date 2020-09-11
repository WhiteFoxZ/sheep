package com.ems.action.board;


import com.octo.captcha.service.captchastore.FastHashMapCaptchaStore;
import com.octo.captcha.service.image.DefaultManageableImageCaptchaService;
import com.octo.captcha.service.image.ImageCaptchaService;


public class CaptchaServiceSingleton {
    private static ImageCaptchaService instance = initializeService();
    private static ImageCaptchaService initializeService(){
    	SimpleListImageCaptchaEngine engine = new SimpleListImageCaptchaEngine();
    	return new DefaultManageableImageCaptchaService(
    	   new FastHashMapCaptchaStore(), engine, 180, 100000, 75000);
    }
    public static ImageCaptchaService getInstance(){
        return instance;
    }
}





