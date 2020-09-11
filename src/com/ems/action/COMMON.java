package com.ems.action;

import com.ems.common.util.*;


import com.ems.common.dbcp.DBManager;
import com.ems.common.dbcp.DataSource;

import java.sql.*;

import javax.servlet.ServletRequest;
import javax.servlet.ServletContext;;


public class COMMON {
	
	private org.apache.log4j.Logger log = org.apache.log4j.Logger.getLogger( this.getClass() );

	ServletRequest request = null;	
	
	EmsHashtable userinfo=null;
	int sessionHashCode;
	
	DBManager dbm = null;
	
	String msg="";
	
	
	

	public COMMON(ServletContext application,ServletRequest request, EmsHashtable userinfo, int sessionHashCode) {
		this.request = request;
		this.userinfo = userinfo;
		this.sessionHashCode=sessionHashCode;
		
		
		DataSource ds = (DataSource)application.getAttribute("jdbc/mysql_ds");

		dbm = new DBManager(ds);
		
		
	    String event = request.getParameter("event");
	    if (event == null) {
	        event = "find";
	    }
	    
	    
	    
	    if(event.equals("find")){
	    	list();
	    }else if(event.equals("modify")){
	    	modify();
	    	list();
	    }
	    
	}

	public void list() {



		String LOGINID = userinfo.getString("LOGINID");

		try {
			
			log.info("LOGINID  "+ LOGINID);
 
			EmsHashtable[] hash = 
				dbm.selectMultipleRecord(QueryXMLParser.getQuery(this.getClass(), "common.xml", "list_sql"),new String[] {  LOGINID });
														
			request.setAttribute("hash", hash);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	
	public void modify() {
				
		String chk[] = request.getParameterValues("chk");
        String PK_CD_ID[] = request.getParameterValues("PK_CD_ID");
        String CD_ID[] = request.getParameterValues("CD_ID");
        String CD_MEANING[] = request.getParameterValues("CD_MEANING");
        String CD_GROUP_ID[] = request.getParameterValues("CD_GROUP_ID");
        String PRICE[] = request.getParameterValues("PRICE");
        String EXT1[] = request.getParameterValues("EXT1");
        String EXT2[] = request.getParameterValues("EXT2");
        String SORT_SEQ[] = request.getParameterValues("SORT_SEQ");
        String LOGINID = userinfo.getString("LOGINID");
        Connection con = null;

		try {
								
			 con  = dbm.getConnection();
			
			int idx=0;
			
			for (int i = 0; i < chk.length; i++) {
				
  	        idx = Integer.parseInt(chk[i]);
            log.info(Integer.valueOf(idx));
            dbm.insert(con, QueryXMLParser.getQuery(getClass(), "common.xml", "update_sql"), new String[] {
                CD_ID[idx], CD_MEANING[idx], SORT_SEQ[idx], PRICE[idx], EXT1[idx], EXT2[idx], CD_GROUP_ID[idx], PK_CD_ID[idx], LOGINID
            });
				
				msg="수정되었습니다.";
				
			}
				
						
			dbm.commitChange(con);
																	
		} catch (Exception e) {
			e.printStackTrace();
			dbm.rollbackChange(con);
			msg="에러발생."+e.getMessage();
			request.setAttribute("msg", msg);
		}

	}
	

}
