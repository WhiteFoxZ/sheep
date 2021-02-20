// 
// Decompiled by Procyon v0.5.36
// 

package com.ems.common.captch;

import com.octo.captcha.service.CaptchaServiceException;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.simple.JSONObject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import org.apache.log4j.Logger;
import javax.servlet.http.HttpServlet;

public class ImagePasswdServlet extends HttpServlet
{
    private Logger log;
    private static final long serialVersionUID = 1L;
    
    public ImagePasswdServlet() {
        this.log = Logger.getLogger((Class)this.getClass());
    }
    
    public void init(final ServletConfig servletConfig) throws ServletException {
        super.init(servletConfig);
    }
    
    protected void doGet(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        final String signup = request.getParameter("signup");
        this.log.debug((Object)("signup : " + signup));
        final PrintWriter writer = response.getWriter();
        request.setCharacterEncoding("UTF-8");
        final JSONObject jsono = new JSONObject();
        try {
            jsono.put((Object)"result", (Object)this.validate(request));
        }
        catch (Exception ex) {}
        if (request.getHeader("accept").indexOf("application/json") != -1) {
            response.setContentType("application/json; charset=UTF-8");
        }
        else {
            response.setContentType("text/plain; charset=UTF-8");
        }
        writer.print(jsono);
        writer.close();
    }
    
    private boolean validate(final HttpServletRequest request) {
        Boolean isResponseCorrect = Boolean.FALSE;
        final String captchaId = request.getSession().getId();
        final String signup = request.getParameter("signup");
        this.log.debug((Object)("captchaId = " + captchaId + "    signup -> " + signup));
        try {
            isResponseCorrect = CaptchaServiceSingleton.getInstance().validateResponseForID(captchaId, (Object)signup);
        }
        catch (CaptchaServiceException e) {
            e.printStackTrace();
        }
        return isResponseCorrect;
    }
}
