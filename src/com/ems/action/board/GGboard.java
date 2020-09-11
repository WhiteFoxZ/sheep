package com.ems.action.board;

import com.ems.common.box.*;
import com.ems.common.dbcp.*;
import com.ems.common.dbcp.DataSource;
import com.ems.common.util.*;

import com.ems.action.util.*;

import com.octo.captcha.service.*;
import com.oreilly.servlet.*;
import com.oreilly.servlet.multipart.*;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.*;
import java.awt.image.BufferedImage;
import org.apache.log4j.Logger;



public class GGboard extends HttpServlet {

    private static final String CONTENT_TYPE = "text/html; charset=EUC-KR";
    private static String NEXT_PAGE = "board_list.jsp";
    private Logger log = Logger.getLogger( this.getClass() );
    
    
    
    private RequestBox rbox = null;
    private RequestMultiBox mbox = null;
    private HttpServletRequest request = null;
    private HttpServletResponse response = null;
    private MultipartRequest multi = null;    
    private DBManager dbm = null;
    private RequestDispatcher dispatcher = null;
    

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        DataSource ds = (DataSource)config.getServletContext().getAttribute("jdbc/mysql_book");
        dbm = new DBManager(ds);   
                    
    }

    /**
     * Process the HTTP doGet request.
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {        
        doPost(request, response);
    }

    /**
     * Process the HTTP doPost request.
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
        log.debug("# START ACTION " +this.getClass() );
        
        this.request = request;
        this.response = response;
        
        String act = "";

        try {

            if (request.getContentType() != null && request.getContentType().startsWith("multipart")) {

                File tmpDir = new File("C:/emslog");

                if (!tmpDir.exists()) {
                    tmpDir.mkdirs();
                }
                
                multi = new MultipartRequest(request, tmpDir.toString(), 10 * 1024 * 1024, "EUC-KR", new DefaultFileRenamePolicy());

                mbox = new RequestMultiBox(multi);                

                act = mbox.getString("act", "read");

                if (act.equals("read")) {
                    read("");
                } else if (act.equals("save")) {

                    String mode = mbox.getString("mode");

                    if (mode.equals("write")) {
                        if(validate()){
                          add();
                          NEXT_PAGE="board_read.jsp";
                        }else
                        {
                          NEXT_PAGE="board_edit.jsp";
                        }
                        
                    } else if (mode.equals("reply")) {
                        if(validate()){
                          reply();                        
                          NEXT_PAGE="board_read.jsp";
                        }else
                        {
                          NEXT_PAGE="board_edit.jsp";
                        }
  
                    } else if (mode.equals("modify")) {
                        
                        if(validate()){ //참일때만 해당패이지로 이동
                        modify();
                        NEXT_PAGE="board_read.jsp";
                        }else
                        {
                          NEXT_PAGE="board_edit.jsp";
                        }
                        
                    } 
                }

            } else {
            
                rbox = new RequestBox(request);
                
                log.debug("# rbox.toString() " + rbox.toString() );

                act = rbox.getString("act", "list");

                if (act.equals("list")) {                    
                    list();
                    NEXT_PAGE="board_list.jsp";
                    
                } else if (act.equals("read")) {
                    read("");
                    NEXT_PAGE="board_read.jsp";
                    
                } else if (act.equals("modify")) {
                    read("");
                    NEXT_PAGE="board_edit.jsp";
                    
                } else if (act.equals("write")) {                    
                    NEXT_PAGE="board_edit.jsp";
                    
                } else if (act.equals("reply")) {                    
                    read("");
                    NEXT_PAGE="board_edit.jsp";
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            error();
        } finally {            
            dispatcher = request.getRequestDispatcher(NEXT_PAGE);
            dispatcher.forward(request, response);            
            
            log.debug("# NEXT_PAGE " + NEXT_PAGE );
        }

    }
    
    
    

    /**
     * 리스트조회
     */
    public void list() {
    
      int currentPage = rbox.getInt("currentPage", 1);      
      int totalCnt = rbox.getInt("totalCnt", 0);
      
      Vector param = new Vector();
      
      /**
       * 검색조건
       */
       
      String[] s_type=request.getParameterValues("s_type");
      String s_key=rbox.getString("s_key", "");
      
      StringBuffer searchSb = new StringBuffer(" AND ");
      int k=0;
      if(s_type!=null && s_key.length()>0){
        if(s_type.length>0)
        {
          for (int i = 0; i <s_type.length ; i++) 
          {
            if(s_type[i].equals("id"))
            {
              param.add(k,s_key);
              searchSb.append("EMAIL like '%'||").append(":").append(k++).append("||'%'");
              if(i!=s_type.length-1) searchSb.append(" OR ");
            }else if(s_type[i].equals("name"))
            {
              param.add(k,s_key);
              searchSb.append("NAME like '%'||").append(":").append(k++).append("||'%'");
              if(i!=s_type.length-1) searchSb.append(" OR ");
            }else if(s_type[i].equals("title"))
            {
              param.add(k,s_key);
              searchSb.append("TITLE like '%'||").append(":").append(k++).append("||'%'");
              if(i!=s_type.length-1) searchSb.append(" OR ");
            }else if(s_type[i].equals("content"))
            {
              param.add(k,s_key);
              searchSb.append("DBMS_LOB.INSTR( CONTENT, ").append(":").append(k++).append(" )>0 ");
              if(i!=s_type.length-1) searchSb.append(" OR ");
            }
          }
          
        }else
        {
          if(!s_type[0].equals("content")){
            param.add(k,s_key);            
            searchSb.append(s_type[0]).append(" like '%'||").append(":").append(k++).append("||'%'");
          }else
          { 
            param.add(k,s_key);   
            searchSb.append("DBMS_LOB.INSTR( CONTENT, ").append(":").append(k++).append(" )>0 ");
          }
          
        }        
        
      }
      
      System.out.println("************************");
      System.out.println(searchSb.toString());
      System.out.println("************************");
      
      
      PagingAction action=null;
      Connection con = null;
            
        try {            
            
            con = dbm.getConnection();   
            
            PagingSet page = new PagingSet();
            page.setTotalCount(totalCnt);
            page.setCurrentPage(currentPage);      
            
            action=new PagingAction(page.getCurrentPage(), page.getTotalCount(), page.getBlockCount(), page.getBlockPage(), 1, "db");
            
            param.add(k++,""+action.getStartCount());
            param.add(k++,""+action.getEndCount());
            
            //쿼리를 가져오기
            String q1 = dbm.sql(this.getClass(),"FindReplyBoardList.xml");
            
            if(s_type!=null && s_key.length()>0){            
              q1 = q1.replaceAll("\\--replaceAll",searchSb.toString());            
            }
            
            //쿼리 수행
            EmsHashtable[] hash1 = dbm.selectMultipleRecord(con,q1,param);
                        
            if(hash1!=null && hash1.length>0){            
              totalCnt = Integer.parseInt(hash1[0].getString("CNT"));                                        
              log.debug("# totalCnt " + totalCnt );
            }else
            {
              totalCnt=0;
            }
            
            log.debug("# currentPage " + currentPage );

            page.setTotalCount(totalCnt);
            page.setCurrentPage(currentPage);
            
            action=new PagingAction(page.getCurrentPage(), page.getTotalCount(), page.getBlockCount(), page.getBlockPage(), 1, "db");

            request.setAttribute("hash1", hash1); // 검색된 게시물 들어있는 리스트
            request.setAttribute("action", action); //

        } catch (Exception e) {
            e.printStackTrace();
            log.debug( e.toString());

        } finally {
 
            try {
                if (con != null){
                    con.close();                    
                }                
            } catch (Exception e1) {
                log.debug( e1.toString());
                e1.printStackTrace();
            }
        }
        
    }

    /**
     * 읽기
     */
    public void read(String idx) {
    
      if(idx.equals("")) idx = rbox.getString("idx","0");
      
      int pre_rnum= Integer.parseInt(idx)-1;
      int next_rnum=Integer.parseInt(idx)+1;
              
            
      Vector param = new Vector();
      
      /**
       * 검색조건
       */
       
      String[] s_type=request.getParameterValues("s_type");
      String s_key=rbox.getString("s_key", "");
      
      StringBuffer searchSb = new StringBuffer(" AND ");
      int k=0;
      if(s_type!=null && s_key.length()>0){
        if(s_type.length>0)
        {
          for (int i = 0; i <s_type.length ; i++) 
          {
            if(s_type[i].equals("id"))
            {
              param.add(k,s_key);
              searchSb.append("EMAIL like '%'||").append(":").append(k++).append("||'%'");
              if(i!=s_type.length-1) searchSb.append(" OR ");
            }else if(s_type[i].equals("name"))
            {
              param.add(k,s_key);
              searchSb.append("NAME like '%'||").append(":").append(k++).append("||'%'");
              if(i!=s_type.length-1) searchSb.append(" OR ");
            }else if(s_type[i].equals("title"))
            {
              param.add(k,s_key);
              searchSb.append("TITLE like '%'||").append(":").append(k++).append("||'%'");
              if(i!=s_type.length-1) searchSb.append(" OR ");
            }else if(s_type[i].equals("content"))
            {
              param.add(k,s_key);
              searchSb.append("DBMS_LOB.INSTR( CONTENT, ").append(":").append(k++).append(" )>0 ");
              if(i!=s_type.length-1) searchSb.append(" OR ");
            }
          }
          
        }else
        {
          if(!s_type[0].equals("content")){
            param.add(k,s_key);            
            searchSb.append(s_type[0]).append(" like '%'||").append(":").append(k++).append("||'%'");
          }else
          { 
            param.add(k,s_key);   
            searchSb.append("DBMS_LOB.INSTR( CONTENT, ").append(":").append(k++).append(" )>0 ");
          }
          
        }        
        
      }
      
      System.out.println("************************");
      System.out.println(searchSb.toString());
      System.out.println("************************");
      
      
      PagingAction action=null;
      Connection con = null;
            
        try {            
            
            con = dbm.getConnection();   
                        
            param.add(k++,""+pre_rnum);
            param.add(k++,""+next_rnum);
            
            //쿼리를 가져오기
            String q1 = dbm.sql(this.getClass(),"FindReplyBoardList.xml");
            
            if(s_type!=null && s_key.length()>0){            
              q1 = q1.replaceAll("\\--replaceAll",searchSb.toString());            
            }
            
            //쿼리 수행
            EmsHashtable[] hash1 = dbm.selectMultipleRecord(con,q1,param);                      

            request.setAttribute("hash1", hash1); // 검색된 게시물 들어있는 리스트

        } catch (Exception e) {
            e.printStackTrace();
            log.debug( e.toString());

        } finally {
 
            try {
                if (con != null){
                    con.close();                    
                }                
            } catch (Exception e1) {
                log.debug( e1.toString());
                e1.printStackTrace();
            }
        }        
        
    }

    public void add() {
      
        String GROUP_ID           =mbox.getString("group_id");              
        String STEP               =mbox.getString("step");        
        String PARENT_ID          =mbox.getString("parent_id");     
        String TITLE              =mbox.getString("title");         
        String NAME               =mbox.getString("name");          
        String EMAIL              =mbox.getString("email");         
        String PWD                =mbox.getString("pwd");           
        String CONTENT            =mbox.getString("content");       
        String CONTENT_HEIGHT     =mbox.getString("content_height");
        String CONTENT_WIDTH      =mbox.getString("content_width");         
        String SIGNUP             =mbox.getString("signup");               
        String url                =mbox.getString("url");      
        String EMAIL_REPLY        =mbox.getString("email_reply");   
        String SECRET_ARTICLE     =mbox.getString("secret_article");
        String STORE_INFO         =mbox.getString("store_info");   

        
        HashMap map = new HashMap();                
        
        Connection con = null;
        
         
         
        try
        {
         

            con = dbm.getConnection();       
            
            String REPLY_BOARD_ID = ""+dbm.selectNextSeq("REPLY_BOARD_SEQ");
            
            map.put("REPLY_BOARD_ID",REPLY_BOARD_ID);
            map.put("GROUP_ID",REPLY_BOARD_ID);          
            map.put("STEP","0");
            map.put("PARENT_ID","0");          
            map.put("NAME",NAME);
            map.put("EMAIL",EMAIL);          
            map.put("PWD",PWD);
            map.put("TITLE",TITLE);
            map.put("CONTENT",CONTENT);          
            
           
            String tmpFile=null;          
                      
            Enumeration en = multi.getFileNames();
            
            while(en.hasMoreElements())
            {
              
              tmpFile = en.nextElement().toString();
              
               if(multi.getFile(tmpFile) !=null){
                map.put(tmpFile+"_sys",multi.getFilesystemName(tmpFile));
                map.put(tmpFile+"_ori",multi.getOriginalFileName(tmpFile));              
              }                       
            }          
            
            //링크파일명 시작
            for(int i=1; i<=mbox.getInt("link_num",1); i++)
            {
              map.put("link_url"+i,mbox.getString("link_url"+i));
            }
            
            
            dbm.add(con,map,"REPLY_BOARD");
            dbm.commitChange(con);
            
            read(REPLY_BOARD_ID);
            
          }catch(Exception e)
          {
            e.printStackTrace();
            dbm.rollbackChange(con);
          }finally
          {
            try {
                  if (con != null){
                      con.close();
                      log.debug("con 풀에 반환");
                  }
              } catch (Exception e1) {
                  log.debug( e1.toString());
              }
          }
          
        

        
    }

    public void reply() {
    
        String GROUP_ID           =mbox.getString("group_id");              
        int STEP                  =mbox.getInt("step",0)+1;        
        String PARENT_ID          =mbox.getString("reply_board_id");     
        String TITLE              =mbox.getString("title");         
        String NAME               =mbox.getString("name");          
        String EMAIL              =mbox.getString("email");         
        String PWD                =mbox.getString("pwd");           
        String CONTENT            =mbox.getString("content");       
        String CONTENT_HEIGHT     =mbox.getString("content_height");
        String CONTENT_WIDTH      =mbox.getString("content_width");         
        String SIGNUP             =mbox.getString("signup");               
        String url                =mbox.getString("url");      
        String EMAIL_REPLY        =mbox.getString("email_reply");   
        String SECRET_ARTICLE     =mbox.getString("secret_article");
        String STORE_INFO         =mbox.getString("store_info");   

        
        HashMap map = new HashMap();                
        
        Connection con = null;
        
        try
        {
          con = dbm.getConnection();       
          
          String REPLY_BOARD_ID = ""+dbm.selectNextSeq("REPLY_BOARD_SEQ");
          
          map.put("REPLY_BOARD_ID",REPLY_BOARD_ID);
          map.put("GROUP_ID",GROUP_ID);          
          map.put("STEP",""+STEP);
          map.put("PARENT_ID",PARENT_ID);          
          map.put("NAME",NAME);
          map.put("EMAIL",EMAIL);          
          map.put("PWD",PWD);
          map.put("TITLE",TITLE);
          map.put("CONTENT",CONTENT);          
         
          String tmpFile=null;          
                    
          Enumeration en = multi.getFileNames();
          
          while(en.hasMoreElements())
          {
            
            tmpFile = en.nextElement().toString();
            
             if(multi.getFile(tmpFile) !=null){
              map.put(tmpFile+"_sys",multi.getFilesystemName(tmpFile));
              map.put(tmpFile+"_ori",multi.getOriginalFileName(tmpFile));              
            }                       
          }          
          
          //링크파일명 시작
          for(int i=1; i<=mbox.getInt("link_num",1); i++)
          {
            map.put("link_url"+i,mbox.getString("link_url"+i));
          }
          
          
          dbm.add(con,map,"REPLY_BOARD");
          dbm.commitChange(con);
          
          //재조회
          read(REPLY_BOARD_ID);
          
        }catch(Exception e)
        {
          e.printStackTrace();
          dbm.rollbackChange(con);
        }finally
        {
          try {
                if (con != null){
                    con.close();
                    log.debug("con 풀에 반환");
                }
            } catch (Exception e1) {
                log.debug( e1.toString());
            }
        }
        
    }

    public void modify() {
    
    String REPLY_BOARD_ID    =mbox.getString("reply_board_id");                     
        String TITLE              =mbox.getString("title");         
        String NAME               =mbox.getString("name");          
        String EMAIL              =mbox.getString("email");         
        String PWD                =mbox.getString("pwd");           
        String CONTENT            =mbox.getString("content");       
        String CONTENT_HEIGHT     =mbox.getString("content_height");
        String CONTENT_WIDTH      =mbox.getString("content_width");         
        String SIGNUP             =mbox.getString("signup");               
        String url                =mbox.getString("url");      
        String EMAIL_REPLY        =mbox.getString("email_reply");   
        String SECRET_ARTICLE     =mbox.getString("secret_article");
        String STORE_INFO         =mbox.getString("store_info");   

        
        HashMap map = new HashMap();                
        
        Connection con = null;
        
        try
        {
          con = dbm.getConnection();                 
          
          map.put("NAME",NAME);
          map.put("EMAIL",EMAIL);          
          map.put("PWD",PWD);
          map.put("TITLE",TITLE);
          map.put("CONTENT",CONTENT);          
         
          String tmpFile=null;          
                    
          Enumeration en = multi.getFileNames();
          
          while(en.hasMoreElements())
          {
            
            tmpFile = en.nextElement().toString();
            
             if(multi.getFile(tmpFile) !=null){
              map.put(tmpFile+"_sys",multi.getFilesystemName(tmpFile));
              map.put(tmpFile+"_ori",multi.getOriginalFileName(tmpFile));              
            }                       
          }          
          
          //링크파일명 시작
          for(int i=1; i<=mbox.getInt("link_num",1); i++)
          {
            map.put("link_url"+i,mbox.getString("link_url"+i));
          }
          
          
          dbm.modify(con,map,"REPLY_BOARD","REPLY_BOARD_ID =:1 ",new String[]{REPLY_BOARD_ID});
          dbm.commitChange(con);
          
          read(REPLY_BOARD_ID);
          
        }catch(Exception e)
        {
          e.printStackTrace();
          dbm.rollbackChange(con);
        }finally
        {
          try {
                if (con != null){
                    con.close();
                    log.debug("con 풀에 반환");
                }
            } catch (Exception e1) {
                log.debug( e1.toString());
            }
        }
    }

    public void delete() {
    }

    public void deleteCheck() {
    }

    private void error() {
        try {
            response.setContentType(CONTENT_TYPE);
            PrintWriter out = response.getWriter();
            out.println("<html>");
            out.println("<head><title>GGboard</title></head>");
            out.println("<body>");
            out.println("<p>The servlet has received a POST. This is the reply.</p>");
            out.println("</body></html>");
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private void back() {
        try {
            response.setContentType(CONTENT_TYPE);
            PrintWriter out = response.getWriter();            
            out.println("<script>history.go(-1)</script>");            
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }    
    
    
    /**
     * 임시디렉토리에 파일 업로드 한것을 세션이 끝날때 지운다.
     */
    public void tmpDirDelete()
    {
      
    }
    
  public void destroy()
	{
    super.destroy();
    System.out.println(this+"destroy");
    
	}
  
  
  /**
     * CONTENTS내용에 첨부파일을 html 태그로 변환
     */
    private String contentsReplace(String CONTENTS)
    {
        String fileNmae="file";
        
        StringBuffer sb = new StringBuffer("");
        
        String sysfile=null;
        String orifile=null;
        
      
      for(int i=1; i<=10; i++){
        
        sysfile = multi.getFilesystemName(fileNmae+i);
        orifile = multi.getOriginalFileName(fileNmae+i);    
          
        if(mbox.getString(fileNmae+"_link").equals("attach"))
        { 
          sb.append("<a href='AttachServlet?");
          sb.append("dir=").append("reboard");
          sb.append("&orifile=").append(orifile);
          sb.append("&sysfile=").append(sysfile);
          sb.append(orifile);
          sb.append("</a>");
      
        }else if(mbox.getString(fileNmae+"_link").equals("down"))
        { 
          sb.append("<a href='DownloadServlet?");
          sb.append("dir=").append("reboard");
          sb.append("&mode=").append("down");
          sb.append("&orifile=").append(orifile);
          sb.append("&sysfile=").append(sysfile);
          sb.append(orifile);
          sb.append("</a>");
          
          sb.append("&nbsp;");
          
          sb.append("<a href='DownloadServlet?");
          sb.append("dir=").append("reboard");
          sb.append("&mode=").append("del");
          sb.append("&orifile=").append(orifile);
          sb.append("&sysfile=").append(sysfile);
          sb.append("삭제");
          sb.append("</a>");
      
        }  
        CONTENTS = CONTENTS.replaceAll("\\{FILE:1}",sb.toString());  
      }
      return CONTENTS;
    }
    
    private boolean validate()
    {
           
           Boolean isResponseCorrect =Boolean.FALSE;
           //remenber that we need an id to validate!
           String captchaId = request.getSession().getId();
           //retrieve the response
           String signup = mbox.getString("signup");
           
           System.out.println("signup -> "+signup);
           
           // Call the Service method
            try {
            
                isResponseCorrect = CaptchaServiceSingleton.getInstance().validateResponseForID(captchaId,signup);
                
                System.out.println(CaptchaServiceSingleton.getInstance().getQuestionForID(captchaId));
                
                System.out.println(CaptchaServiceSingleton.getInstance().getChallengeForID(captchaId));
                
                
                
                System.out.println("인증:"+isResponseCorrect.booleanValue());
                
            } catch (CaptchaServiceException e) {
                 //should not happen, may be thrown if the id is not valid
                 
                 request.setAttribute("ERROR_MESSAGE",EmsMessage.MESSAGE66);
                 e.printStackTrace();
            }
            
            return isResponseCorrect.booleanValue();
    }
    
    
    /**
     * 페이징 처리
     */
    public String indexList(int current_page, int totalCnt) {
        
        int pagenumber = 10;
        int startpage;
        int endpage;
        int curpage;
        int total_page;
        
        StringBuffer strList = new StringBuffer("");
        StringBuffer result  = new StringBuffer("");
        
        String path = request.getContextPath();
        
        String xFirstOutImg = "<img src='" + path + "/img/icon/bt_firstO.jpg'  border='0' align='absmiddle' title='처음 페이지' >";
        String xPrevOutImg = "<img src='" + path + "/img/icon/bt_beforeO.jpg' border='0' align='absmiddle' title='이전 10 페이지' >";
        String xNextOutImg = "<img src='" + path + "/img/icon/bt_nextO.jpg' border='0' align='absmiddle' title='다음 10 페이지' >";
        String xLastOutImg = "<img src='" + path + "/img/icon/bt_lastO.jpg' border='0' align='absmiddle' title='마지막 페이지' >";
        
        String imgSplit = "&nbsp;";
        
        if(totalCnt>0){
        
            if((totalCnt%pagenumber>0))
            total_page  = totalCnt/pagenumber + 1;
            else
            total_page = totalCnt%pagenumber;
            
            startpage = ((current_page - 1) / pagenumber) * pagenumber + 1;
            
            endpage = (((startpage - 1) + pagenumber) / pagenumber) * pagenumber;            
            
            log.debug("# startpage " + startpage );
            log.debug("# endpage " + endpage );
            
            if (total_page <= endpage) {
                endpage = total_page;
            }
            log.debug("# endpage " + endpage );
            
            //이전 10 페이지 
            if (current_page > pagenumber) {
                curpage = startpage - 1;
                xPrevOutImg = "<a href='javascript:setPage(" + curpage + ");' style='font-size:8pt; font-family:굴림;' >" + xPrevOutImg + "</a>";
                log.debug("# current_page > pagenumber "  );
            }             
            
            //현재 페이지
            curpage = startpage;
            while (curpage <= endpage) {
                if (curpage == current_page) {                
                    strList.append("<font style='font-size:8pt; font-family:굴림;'><b>[").append(current_page).append("]</b></font>\n");
                } else {
                    strList.append("<a href='javascript:setPage(").append(curpage).append(");' style='font-size:8pt; font-family:굴림;' >[").append(curpage).append("]</a>\n");
                }
                curpage++;
            }
            
            //다음 10 페이지
            if (total_page > endpage) {
                curpage = endpage + 1;
                xNextOutImg = "<a href='javascript:setPage(" + curpage + ");' style='font-size:8pt; font-family:굴림;' >" + xNextOutImg + "</a>";
                log.debug("# total_page > endpage "  );
            } 
            //처음 && 마지막
            String first ="<a href='javascript:setPage(1);'>" + xFirstOutImg + "</a>";
            String last = "<a href='javascript:setPage(" + total_page + ");' style='font-size:8pt; font-family:굴림;' >" + xLastOutImg + "</a>";
                                            
            result.append("<table border='0' cellspacing='0' cellpadding='0' width='100%' align='center' ><tr ><td align='center' >");
            result.append(first).append(xPrevOutImg);                        
            result.append(strList);            
            result.append(xNextOutImg).append(last);
            result.append("</td></tr></table>");
            
                    
        }
        
        return result.toString();
    }
    
}