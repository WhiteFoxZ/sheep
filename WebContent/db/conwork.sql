
--
-- 테이블 구조 `conwork_comm_info`
--

CREATE TABLE IF NOT EXISTS `conwork_comm_info` (
  `AUTO_KEY` double NOT NULL AUTO_INCREMENT,
  `CD_GROUP_ID` varchar(150) NOT NULL,
  `CD_GROUP_NM` varchar(45) NOT NULL,
  `CD_ID` varchar(45) NOT NULL,
  `CD_MEANING` varchar(150) NOT NULL,
  `LOGINID` varchar(20) NOT NULL,
  `EXT1` varchar(200) DEFAULT NULL COMMENT '사진1',
  `EXT2` varchar(200) DEFAULT NULL COMMENT '사진2',
  `EXT3` varchar(200) DEFAULT NULL COMMENT '사진3',
  `SORT_SEQ` int(11) DEFAULT NULL,
  `CREATED_OBJECT_TYPE` varchar(1) NOT NULL DEFAULT 'C',
  `CREATED_OBJECT_ID` varchar(22) NOT NULL DEFAULT 'MES',
  `CREATED_PROGRAM_ID` varchar(22) NOT NULL DEFAULT 'C',
  `CREATION_TIMESTAMP` datetime DEFAULT NULL,
  `LAST_UPDATED_OBJECT_TYPE` varchar(1) NOT NULL DEFAULT 'U',
  `LAST_UPDATED_OBJECT_ID` varchar(22) NOT NULL DEFAULT 'MES',
  `LAST_UPDATE_PROGRAM_ID` varchar(22) NOT NULL DEFAULT 'MES',
  `LAST_UPDATE_TIMESTAMP` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`AUTO_KEY`),
  UNIQUE KEY `idx_conwork_comm_info_CD_GROUP_ID_LOGIN_ID_CD_ID` (`CD_GROUP_ID`,`LOGINID`,`CD_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='COMMON' AUTO_INCREMENT=12 ;

--
-- 테이블의 덤프 데이터 `conwork_comm_info`
--

INSERT INTO `conwork_comm_info` (`AUTO_KEY`, `CD_GROUP_ID`, `CD_GROUP_NM`, `CD_ID`, `CD_MEANING`, `LOGINID`, `EXT1`, `EXT2`, `EXT3`, `SORT_SEQ`, `CREATED_OBJECT_TYPE`, `CREATED_OBJECT_ID`, `CREATED_PROGRAM_ID`, `CREATION_TIMESTAMP`, `LAST_UPDATED_OBJECT_TYPE`, `LAST_UPDATED_OBJECT_ID`, `LAST_UPDATE_PROGRAM_ID`, `LAST_UPDATE_TIMESTAMP`) VALUES
(9, 'WORK_TYPE', '직종', '목수', '목수', 'test', '', '', '', 1, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-13 20:35:35'),
(10, 'WORK_TYPE', '직종', '미장', '미장', 'test', '', '', '', 2, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-13 20:35:54'),
(11, 'WORK_TYPE', '직종', '잡부', '잡부', 'test', '', '', '', 3, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-14 11:44:50');

-- --------------------------------------------------------

--
-- 테이블 구조 `conwork_user_info`
--

CREATE TABLE IF NOT EXISTS `conwork_user_info` (
  `USERID` double NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(32) NOT NULL,
  `TEL1` varchar(64) DEFAULT NULL,
  `TEL2` varchar(64) DEFAULT NULL,
  `COMPANY_NAME` varchar(45) NOT NULL,
  `LOGINID` varchar(10) NOT NULL DEFAULT '',
  `LOGINPW` varchar(10) NOT NULL,
  `ACCESSPW` varchar(10) NOT NULL,
  `EMAIL` varchar(128) DEFAULT NULL,
  `STATUS` int(11) NOT NULL,
  `FROM_DT` datetime DEFAULT NULL,
  `TO_DT` datetime DEFAULT NULL,
  `CREATED_OBJECT_TYPE` varchar(1) NOT NULL DEFAULT 'C',
  `CREATED_OBJECT_ID` varchar(22) NOT NULL DEFAULT 'MES',
  `CREATED_PROGRAM_ID` varchar(22) NOT NULL DEFAULT 'C',
  `CREATION_TIMESTAMP` datetime DEFAULT NULL,
  `LAST_UPDATED_OBJECT_TYPE` varchar(1) NOT NULL DEFAULT 'U',
  `LAST_UPDATED_OBJECT_ID` varchar(22) NOT NULL DEFAULT 'MES',
  `LAST_UPDATE_PROGRAM_ID` varchar(22) NOT NULL DEFAULT 'MES',
  `LAST_UPDATE_TIMESTAMP` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`USERID`),
  UNIQUE KEY `IDX_LOGINID` (`LOGINID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='고객정보' AUTO_INCREMENT=4 ;

--
-- 테이블의 덤프 데이터 `conwork_user_info`
--

INSERT INTO `conwork_user_info` (`USERID`, `USERNAME`, `TEL1`, `TEL2`, `COMPANY_NAME`, `LOGINID`, `LOGINPW`, `ACCESSPW`, `EMAIL`, `STATUS`, `FROM_DT`, `TO_DT`, `CREATED_OBJECT_TYPE`, `CREATED_OBJECT_ID`, `CREATED_PROGRAM_ID`, `CREATION_TIMESTAMP`, `LAST_UPDATED_OBJECT_TYPE`, `LAST_UPDATED_OBJECT_ID`, `LAST_UPDATE_PROGRAM_ID`, `LAST_UPDATE_TIMESTAMP`) VALUES
(3, '이승용', '010', NULL, '신대인력', 'test', 'test', 'test', 'fmjj007@naver.com', 1, NULL, NULL, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-13 19:06:45');

-- --------------------------------------------------------

--
-- 테이블 구조 `conwork_working_info`
--

CREATE TABLE IF NOT EXISTS `conwork_working_info` (
  `AUTO_KEY` double NOT NULL AUTO_INCREMENT,
  `WORK_DT` date NOT NULL COMMENT '작업일자',
  `WEATHER` varchar(6) NOT NULL COMMENT '날씨',
  `WORK_PLACE` varchar(45) NOT NULL COMMENT '작업현장',
  `WORK_TYPE` varchar(20) DEFAULT NULL COMMENT '직종',
  `WORK_MANAGER` varchar(45) NOT NULL COMMENT '담당자',
  `WORK_TEL1` varchar(45) NOT NULL,
  `WORK_TEL2` varchar(45) DEFAULT NULL,
  `LABOR_NAME` varchar(45) NOT NULL COMMENT '작업자',
  `LABOR_TEL1` varchar(45) NOT NULL,
  `LABOR_TEL2` varchar(45) DEFAULT NULL,
  `LABOR_PAY1` double NOT NULL DEFAULT '0' COMMENT '입금1',
  `LABOR_PAY2` double NOT NULL DEFAULT '0' COMMENT '입금2',
  `LABOR_PAY3` double NOT NULL DEFAULT '0' COMMENT '선입금',
  `SIGNIN` varchar(45) DEFAULT NULL,
  `CONTENTS` varchar(4000) DEFAULT NULL COMMENT '기타내용',
  `LOGINID` varchar(45) NOT NULL,
  `CREATED_OBJECT_TYPE` varchar(1) NOT NULL DEFAULT 'C',
  `CREATED_OBJECT_ID` varchar(22) NOT NULL DEFAULT 'MES',
  `CREATED_PROGRAM_ID` varchar(22) NOT NULL DEFAULT 'C',
  `CREATION_TIMESTAMP` datetime DEFAULT NULL,
  `LAST_UPDATED_OBJECT_TYPE` varchar(1) NOT NULL DEFAULT 'U',
  `LAST_UPDATED_OBJECT_ID` varchar(22) NOT NULL DEFAULT 'MES',
  `LAST_UPDATE_PROGRAM_ID` varchar(22) NOT NULL DEFAULT 'MES',
  `LAST_UPDATE_TIMESTAMP` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`AUTO_KEY`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='일일작업현황' AUTO_INCREMENT=72 ;

--
-- 테이블의 덤프 데이터 `conwork_working_info`
--

INSERT INTO `conwork_working_info` (`AUTO_KEY`, `WORK_DT`, `WEATHER`, `WORK_PLACE`, `WORK_TYPE`, `WORK_MANAGER`, `WORK_TEL1`, `WORK_TEL2`, `LABOR_NAME`, `LABOR_TEL1`, `LABOR_TEL2`, `LABOR_PAY1`, `LABOR_PAY2`, `LABOR_PAY3`, `SIGNIN`, `CONTENTS`, `LOGINID`, `CREATED_OBJECT_TYPE`, `CREATED_OBJECT_ID`, `CREATED_PROGRAM_ID`, `CREATION_TIMESTAMP`, `LAST_UPDATED_OBJECT_TYPE`, `LAST_UPDATED_OBJECT_ID`, `LAST_UPDATE_PROGRAM_ID`, `LAST_UPDATE_TIMESTAMP`) VALUES
(59, '2015-11-13', '맑음', '신대중흥', '목수', '이승용', '010-3190-2461', '', '홍길동', '010-1234-2354', '', 1000000, 0, 0, NULL, '아침6시출발', 'test', 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-13 20:36:41'),
(60, '2015-11-13', '맑음', '신대중흥', '미장', '이승용', '010-3190-2461', '', '홍길자', '010-1234-2354', '', 2000000, 0, 0, NULL, '아침6시출발', 'test', 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-13 20:36:56'),
(64, '2015-11-14', '흐림', '현대무늬목', '잡부', '민승희', '01036287743', '', '이성수', '01065235757', '', 0, 0, 0, NULL, '', 'test', 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-14 12:23:28'),
(63, '2015-11-14', '흐림', '정선희', '잡부', '태광기업', '01046412100', '', '정선희', '01064687898', '', 0, 0, 0, NULL, '', 'test', 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-14 12:19:38'),
(65, '2015-11-14', '흐림', '한일기업', '잡부', '한일기업', '0116223988', '', '이성재', '01085797941', '', 0, 0, 0, NULL, '', 'test', 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-14 12:25:20'),
(66, '2015-11-16', '흐림', '이칠선', '잡부', '이칠선', '01026508800', '', '박기영이성재강형태', '01056223344', '', 0, 0, 0, NULL, '', 'test', 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-16 09:49:14'),
(67, '2015-11-16', '흐림', '성광건설', '잡부', '성광건설', '01036227782', '', '구일공사', '01086049104', '', 0, 0, 0, NULL, '', 'test', 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-16 09:51:45'),
(68, '2015-11-16', '흐림', '현대무늬목', '잡부', '민승희', '01036287743', '', '이성수', '01065235757', '', 0, 0, 0, NULL, '', 'test', 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-16 09:54:27'),
(69, '2015-11-17', '흐림', '한일기업', '잡부', '한일기업', '0116223988', '', '이성수', '01065235757', '', 0, 0, 0, NULL, '', 'test', 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-17 14:01:59'),
(70, '2015-11-17', '흐림', '현대무늬목', '잡부', '현대무늬목', '01036287743', '', '이성재', '01085797941', '', 0, 0, 0, NULL, '', 'test', 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-17 14:04:00'),
(71, '2015-11-17', '흐림', '예성전기', '잡부', '예성전기', '01036040411', '', '정선희', '01064887898', '', 0, 0, 0, NULL, '', 'test', 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-11-17 14:07:35');

-- --------------------------------------------------------
