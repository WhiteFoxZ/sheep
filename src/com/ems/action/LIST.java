package com.ems.action;

import com.ems.common.util.*;
import com.ems.common.dbcp.DBManager;
import com.ems.common.dbcp.DataSource;

import java.sql.*;

import javax.servlet.ServletRequest;
import javax.servlet.ServletContext;


public class LIST {

	private org.apache.log4j.Logger log = org.apache.log4j.Logger.getLogger( this.getClass() );

	ServletRequest request = null;

	EmsHashtable userinfo=null;
	int sessionHashCode;

	DBManager dbm = null;

	String msg="";
	String LOGINID=null;

	public LIST(ServletContext application,ServletRequest request, EmsHashtable userinfo, int sessionHashCode) {
		this.request = request;
		this.userinfo = userinfo;
		this.sessionHashCode=sessionHashCode;

		LOGINID = userinfo.getString("LOGINID");

		DataSource ds = (DataSource)application.getAttribute("jdbc/mysql_ds");

		dbm = new DBManager(ds);

	    String event = request.getParameter("event");
	    String pageid = request.getParameter("pageid");	//pageid 값을 체크해서 미입급 리스트로 갈지를 체크한다.


	    if (event == null) {
	        event = "find";
	    }



	    if(event.equals("find")){
	    	if(pageid==null)
	    	list();
	    	else
	    	list2();

	    }else if(event.equals("modify")){
	    	modify();
	    	list();

	    	if(pageid==null)
		    	list();
		    	else
		    	list2();

	    }else if(event.equals("delete")){
	    	delete();

	    	if(pageid==null)
		    	list();
		    	else
		    	list2();

	    }else if(event.equals("cancel")){
	    	cancel();

	    	if(pageid==null)
		    	list();
		    	else
		    	list2();

	    }else if(event.equals("deletePK")){
	    	deletePK();
	    	if(pageid==null)
		    	list();
		    	else
		    	list2();

	    }

	}




	public void initLov(){



	}

	public void list() {

		try {

			log.info("LOGINID  "+ LOGINID);

			String TO_DAY = EmsDateUtil.getCurrentDate("yyyy-MM-dd");

		    String rdate=request.getParameter("rdate")!=null?request.getParameter("rdate").toString():TO_DAY;

		    String P_SDATE = request.getParameter("P_SDATE");
		    String P_EDATE = request.getParameter("P_EDATE");
		    String P_NAME = request.getParameter("P_NAME");




		    if(P_NAME==null){
		    	P_NAME="";
		    }else{
		    	P_NAME = "%"+P_NAME+"%";
		    }



		    if(P_SDATE==null){
		    	if(rdate!=null)	P_SDATE = rdate;
		    }

		    if(P_EDATE==null){
		    	if(rdate!=null)	P_EDATE=rdate;
		    }

		    String sql = QueryXMLParser.getQuery(this.getClass(), "list.xml", "list_sql");

		    if(P_NAME.length()>1){
		    	sql = sql + " AND B.USER_NAME LIKE  '"+P_NAME+"'";
		    }


			EmsHashtable[] hash =
				dbm.selectMultipleRecord(sql + " ORDER BY  ( 0 + A.CD_ID ) asc , RESERVE_DATE asc  "
						,new String[] {  P_SDATE,P_EDATE,LOGINID, LOGINID});

			request.setAttribute("hash", hash);

		} catch (Exception e) {
			e.printStackTrace();
		}finally{

		}

	}


	/**
	 * 미입금처리된 대상만 조회된다.
	 */
	public void list2() {


		try {

			log.info("LOGINID  "+ LOGINID);

		    String sql = QueryXMLParser.getQuery(this.getClass(), "list.xml", "list_sql2");

			EmsHashtable[] hash =
				dbm.selectMultipleRecord(sql + " ORDER BY  ( 0 + A.CD_ID ) asc , RESERVE_DATE asc  "
						,new String[] {LOGINID, LOGINID});

			request.setAttribute("hash", hash);

		} catch (Exception e) {
			e.printStackTrace();
		}finally{

		}

	}


	/**
	 * 입금확인처리
	 * 입금처리된 고객에게 메일을 전송한다.
	 */
	public void modify() {

		String[] chk = request.getParameterValues("chk"); // 카드ID
		String[] PK_GROUP_KEY = request.getParameterValues("PK_GROUP_KEY"); // 카드ID
		String RESERVE_STATE ="2";	//예약확인


		 LOGINID = userinfo.getString("LOGINID");


		 log.info("LOGINID----------> "+LOGINID);

		 Connection con=null;

		 if(chk==null) return;

		try {

			 con  = dbm.getConnection();

			int idx=0;
			if(chk!=null)
			for (int i = 0; i < chk.length; i++) {

				idx = Integer.parseInt(chk[i]);

				log.info(idx);

				dbm.insert(con , QueryXMLParser.getQuery(this.getClass(), "list.xml", "update_sql")
						,new String[] { RESERVE_STATE, PK_GROUP_KEY[idx], LOGINID });

				msg="입금 확인 처리되었습니다.";



			}

			dbm.commitChange(con);

		} catch (Exception e) {
			e.printStackTrace();
			dbm.rollbackChange(con);

			msg="에러가 발생했습니다.관리자에게 문의";

		}finally{

			request.setAttribute("msg", msg);

		}

	}



	/**
	 * 얘약확인취소
	 */
	public void cancel() {

		String[] chk = request.getParameterValues("chk"); // 카드ID
		String[] PK_GROUP_KEY = request.getParameterValues("PK_GROUP_KEY"); // 카드ID
		String RESERVE_STATE ="1";	//예약상태


		 LOGINID = userinfo.getString("LOGINID");
		 Connection con  = null;

		 if(chk==null) return;

		try {

			 con  = dbm.getConnection();

			int idx=0;
			if(chk!=null)
			for (int i = 0; i < chk.length; i++) {

				idx = Integer.parseInt(chk[i]);

				log.info(idx);

				dbm.insert(con , QueryXMLParser.getQuery(this.getClass(), "list.xml", "update_sql")
						,new String[] { RESERVE_STATE, PK_GROUP_KEY[idx], LOGINID });

				msg="얘약확인 취소 처리되었습니다.";


			}


			dbm.commitChange(con);

		} catch (Exception e) {
			e.printStackTrace();
			dbm.rollbackChange(con);

			msg="에러가 발생했습니다.관리자에게 문의";

		}finally{

			request.setAttribute("msg", msg);

		}

	}






	public void deletePK(){
		String pk_key = request.getParameter("pk_key");
		String pk_pw = request.getParameter("pk_pw");

		Connection con=null;

		LOGINID = userinfo.getString("LOGINID");

		try {

			 con  = dbm.getConnection();


			int i = dbm.insert(con , QueryXMLParser.getQuery(this.getClass(), "list.xml", "delete_tel_sql")
					,new String[] {pk_key,pk_pw, LOGINID });

			if (i>0 )
				msg="삭제 되었습니다.";
			else
				msg="비밀 번호가 다릅니다.";

			request.setAttribute("msg", msg);

			dbm.commitChange(con);

		} catch (Exception e) {
			e.printStackTrace();
			dbm.rollbackChange(con);
			msg="에러가 발생했습니다.관리자에게 문의";
		}finally{

			request.setAttribute("msg", msg);

		}


	}

	public void delete() {

		String[] chk = request.getParameterValues("chk"); // 카드ID
		String[] PK_GROUP_KEY = request.getParameterValues("PK_GROUP_KEY"); // 카드ID

		 LOGINID = userinfo.getString("LOGINID");

		 Connection con=null;

		 if(chk==null) return;

		try {

			 con  = dbm.getConnection();

			int idx=0;


			for (int i = 0; i < chk.length; i++) {

				idx = Integer.parseInt(chk[i]);

				log.info(idx);

				dbm.insert(con , QueryXMLParser.getQuery(this.getClass(), "list.xml", "delete_sql")
						,new String[] {PK_GROUP_KEY[idx], LOGINID });

				msg="삭제 되었습니다.";

				request.setAttribute("msg", msg);

			}

			dbm.commitChange(con);

		} catch (Exception e) {
			e.printStackTrace();
			dbm.rollbackChange(con);
			msg="에러가 발생했습니다.관리자에게 문의";
		}finally{

			request.setAttribute("msg", msg);

		}

	}



}
