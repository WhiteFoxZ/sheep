// 
// Decompiled by Procyon v0.5.36
// 

package com.ems.common.captch;

import java.io.IOException;
import javax.servlet.ServletOutputStream;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import java.awt.image.BufferedImage;
import com.octo.captcha.service.image.ImageCaptchaService;
import com.octo.captcha.service.CaptchaServiceException;
import java.io.OutputStream;
import com.sun.image.codec.jpeg.JPEGCodec;
import java.io.ByteArrayOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import org.apache.log4j.Logger;
import javax.servlet.http.HttpServlet;

public class ImageCaptchaServlet extends HttpServlet
{
    private Logger log;
    private static final long serialVersionUID = 1L;
    
    public ImageCaptchaServlet() {
        this.log = Logger.getLogger((Class)this.getClass());
    }
    
    public void init(final ServletConfig servletConfig) throws ServletException {
        super.init(servletConfig);
    }
    
    protected void doGet(final HttpServletRequest httpServletRequest, final HttpServletResponse httpServletResponse) throws ServletException, IOException {
        byte[] captchaChallengeAsJpeg = null;
        final ByteArrayOutputStream jpegOutputStream = new ByteArrayOutputStream();
        try {
            final String captchaId = httpServletRequest.getSession().getId();
            final ImageCaptchaService imgcp = CaptchaServiceSingleton.getInstance();
            final BufferedImage challenge = imgcp.getImageChallengeForID(captchaId, httpServletRequest.getLocale());
            final JPEGImageEncoder jpegEncoder = JPEGCodec.createJPEGEncoder((OutputStream)jpegOutputStream);
            jpegEncoder.encode(challenge);
        }
        catch (IllegalArgumentException e) {
            httpServletResponse.sendError(404);
            return;
        }
        catch (CaptchaServiceException e2) {
            httpServletResponse.sendError(500);
            return;
        }
        captchaChallengeAsJpeg = jpegOutputStream.toByteArray();
        httpServletResponse.setHeader("Cache-Control", "no-store");
        httpServletResponse.setHeader("Pragma", "no-cache");
        httpServletResponse.setDateHeader("Expires", 0L);
        httpServletResponse.setContentType("image/jpeg");
        final ServletOutputStream responseOutputStream = httpServletResponse.getOutputStream();
        responseOutputStream.write(captchaChallengeAsJpeg);
        responseOutputStream.flush();
        responseOutputStream.close();
        System.out.println("responseOutputStream.close");
    }
}
