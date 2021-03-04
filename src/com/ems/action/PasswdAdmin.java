package com.ems.action;

import com.ems.common.util.*;


import com.ems.common.dbcp.DBManager;
import com.ems.common.dbcp.DataSource;

import java.sql.*;
import java.util.HashMap;

import javax.servlet.ServletRequest;
import javax.servlet.ServletContext;;


public class PasswdAdmin {

	private org.apache.log4j.Logger log = org.apache.log4j.Logger.getLogger( this.getClass() );

	ServletRequest request = null;

	EmsHashtable userinfo=null;
	int sessionHashCode;

	DBManager dbm = null;

	String msg="";




	public PasswdAdmin(ServletContext application,ServletRequest request, EmsHashtable userinfo, int sessionHashCode) {
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
					dbm.selectMultipleRecord("SELECT * FROM user_info where LOGINID=? ",
				    		new String[] {LOGINID});


			request.setAttribute("hash", hash);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}


	public void modify() {

		String chk[] = request.getParameterValues("chk");
        String PK_LOGINID[] = request.getParameterValues("PK_LOGINID");
        String USERNAME[] = request.getParameterValues("USERNAME");
        String TEL1[] = request.getParameterValues("TEL1");
        String LOGINPW[] = request.getParameterValues("LOGINPW");
        String ACCESSPW[] = request.getParameterValues("ACCESSPW");


        Connection con = null;

		try {

			 con  = dbm.getConnection();

			int idx=0;

			for (int i = 0; i < chk.length; i++) {

				HashMap map = new HashMap();

				map.put("USERNAME", USERNAME[i]);
				map.put("TEL1", TEL1[i]);
				map.put("LOGINPW", LOGINPW[i]);
				map.put("ACCESSPW", ACCESSPW[i]);

  	        idx = Integer.parseInt(chk[i]);
            log.info(Integer.valueOf(idx));

            dbm.modify(con, map, "user_info", " LOGINID=? ", new String[] {PK_LOGINID[0]} );


			}

			msg="수정되었습니다.";


			dbm.commitChange(con);

		} catch (Exception e) {
			e.printStackTrace();
			dbm.rollbackChange(con);
			msg="에러발생."+e.getMessage();

		}finally {
			request.setAttribute("msg", msg);
		}

	}


}
