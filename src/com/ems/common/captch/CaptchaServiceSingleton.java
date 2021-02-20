// 
// Decompiled by Procyon v0.5.36
// 

package com.ems.common.captch;

import com.octo.captcha.engine.CaptchaEngine;
import com.octo.captcha.service.captchastore.CaptchaStore;
import com.octo.captcha.service.image.DefaultManageableImageCaptchaService;
import com.octo.captcha.service.captchastore.FastHashMapCaptchaStore;
import com.octo.captcha.service.image.ImageCaptchaService;

public class CaptchaServiceSingleton
{
    private static ImageCaptchaService instance;
    
    static {
        CaptchaServiceSingleton.instance = initializeService();
    }
    
    private static ImageCaptchaService initializeService() {
        final SimpleListImageCaptchaEngine engine = new SimpleListImageCaptchaEngine();
        return (ImageCaptchaService)new DefaultManageableImageCaptchaService((CaptchaStore)new FastHashMapCaptchaStore(), (CaptchaEngine)engine, 180, 100000, 75000);
    }
    
    public static ImageCaptchaService getInstance() {
        return CaptchaServiceSingleton.instance;
    }
}
