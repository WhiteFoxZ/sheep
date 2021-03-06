set sql_safe_updates=0;

delete from comm_info where LOGIN_ID='BGHJ01';
delete from comm_info where LOGIN_ID like 'TEST%';


INSERT INTO `comm_info` (`CD_GROUP_ID`, `CD_GROUP_NM`, `CD_ID`, `CD_MEANING`, `LOGIN_ID`, `PRICE`, `EXT1`, `EXT2`, `EXT3`, `SORT_SEQ`, `CREATED_OBJECT_TYPE`, `CREATED_OBJECT_ID`, `CREATED_PROGRAM_ID`, `CREATION_TIMESTAMP`, `LAST_UPDATED_OBJECT_TYPE`, `LAST_UPDATED_OBJECT_ID`, `LAST_UPDATE_PROGRAM_ID`, `LAST_UPDATE_TIMESTAMP`) VALUES
('CALENDAR_CNT', '달력조회기간', 'CALENDAR_CNT', '3', 'BGHJ01', 0, NULL, NULL, NULL, NULL, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2016-05-27 20:40:49'),
('DAY_MONEY', '기본금액', '999', '성수기금액', 'BGHJ01', 40000, '', '', NULL, 5, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2016-05-18 21:04:20'),
('ACCUNT_NO', '계좌번호', '1', '농협 351-0656-4532-33(김향진)', 'BGHJ01', 0, NULL, NULL, NULL, 1, 'C', 'MES', 'C', '2015-05-29 14:29:48', 'U', 'MES', 'MES', '2015-05-29 14:29:48'),
('ACCUNT_NO', '계좌번호', '2', '농협 351-0656-4532-33(김향진)', 'BGHJ01', 0, NULL, NULL, NULL, 2, 'C', 'MES', 'C', '2015-05-29 14:29:48', 'U', 'MES', 'MES', '2015-05-29 14:29:48'),
('ROOM_NUM', '데크NO', '10', '[데크]3*5이며 앞공간 여유많음 화장실 개수대가까움', 'BGHJ01', 0, '[데크]', '', NULL, 10, 'C', 'MES', 'C', '2015-06-01 20:08:25', 'U', 'MES', 'MES', '2015-06-18 20:08:40'),
('ROOM_NUM', '데크NO', '1', '[데크]데크사이즈3*4이며 타프공간있으며 계곡내려가는입구 단독사이트', 'BGHJ01', 0, '[데크]', '', NULL, 1, 'C', 'MES', 'C', '2015-06-03 15:07:52', 'U', 'MES', 'MES', '2015-06-03 15:07:52'),
('ROOM_NUM', '데크NO', '2', '[데크]3*4이며 계곡시작첫번째 사이트 앞쪽 여유공간 많아 텐트가 크시면 바닥에 치시고 거실을 데크로 사용하셔도 됩니다', 'BGHJ01', 0, '[데크]', '', NULL, 2, 'C', 'MES', 'C', '2015-06-03 15:08:39', 'U', 'MES', 'MES', '2015-06-03 15:08:39'),
('ROOM_NUM', '데크NO', '3', '[데크]3*5이며 계곡끝쪽에 위치하며 그늘이 시간에 따라 가능합니다', 'BGHJ01', 0, '[데크]', '', NULL, 3, 'C', 'MES', 'C', '2015-06-03 15:08:39', 'U', 'MES', 'MES', '2015-06-03 15:08:39'),
('ROOM_NUM', '데크NO', '4', '[데크]3*5이며 그늘은 없습니다 조용한곳입니다화장실개수대거리 100미터정도 됩니다', 'BGHJ01', 0, '[데크]', '', NULL, 4, 'C', 'MES', 'C', '2015-06-03 15:08:39', 'U', 'MES', 'MES', '2015-06-03 15:08:39'),
('ROOM_NUM', '데크NO', '5', '[데크]3*5이며 그늘은 없습니다 조용한곳입니다 4번과 동행일시 추천드립니다화장실 개수대거리 100미터정도 됩니다', 'BGHJ01', 0, '[데크]', '', NULL, 5, 'C', 'MES', 'C', '2015-06-03 15:08:39', 'U', 'MES', 'MES', '2015-06-03 15:08:39'),
('ROOM_NUM', '데크NO', '6', '[데크]3*5이며 캠장들어오는초입,소음없음,앞공간여유많음', 'BGHJ01', 0, '[데크]', '', NULL, 6, 'C', 'MES', 'C', '2015-06-03 15:08:40', 'U', 'MES', 'MES', '2015-06-03 15:08:40'),
('ROOM_NUM', '데크NO', '7', '[데크]3*5이며 앞공간 여유많음 화장실 개수대가까움', 'BGHJ01', 0, '[데크]', '', NULL, 7, 'C', 'MES', 'C', '2015-06-03 15:08:40', 'U', 'MES', 'MES', '2015-06-03 15:08:40'),
('ROOM_NUM', '데크NO', '8', '[데크]3*5이며 앞공간 여유많음 화장실 개수대가까움', 'BGHJ01', 0, '[데크]', '', NULL, 8, 'C', 'MES', 'C', '2015-06-03 15:08:40', 'U', 'MES', 'MES', '2015-06-03 15:08:40'),
('ROOM_NUM', '데크NO', '9', '[데크]3*5이며 앞공간 여유많음 화장실 개수대가까움', 'BGHJ01', 0, '[데크]', '', NULL, 9, 'C', 'MES', 'C', '2015-06-03 15:08:40', 'U', 'MES', 'MES', '2015-06-03 15:08:40'),
('TIME_LIMIT', '입금만료시간', '24', '시간', 'BGHJ01', 0, NULL, NULL, NULL, NULL, 'C', 'MES', 'C', '2015-05-28 17:47:31', 'U', 'MES', 'MES', '2015-05-28 17:47:31'),
('ROOM_NUM', '데크NO', '11', '[데크]3*5이며 앞공간 여유많음 화장실 개수대가까움', 'BGHJ01', 0, '[데크]', '', NULL, 11, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '12', '[데크]3*4이며 개수대앞큰나무아래,화장실 개수대가까움.해먹가능', 'BGHJ01', 0, '[데크]', '', NULL, 12, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '13', '[데크]3*4이며 개수대앞큰나무아래,화장실 개수대가까움/해먹가능', 'BGHJ01', 0, '[데크]', '', NULL, 13, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '14', '[데크]3*4이며 나무 자라고 있는곳임.', 'BGHJ01', 0, '[데크]', '', NULL, 14, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '15', '[데크]3*4이며 나무 자라고 있는곳임.개수대가까움', 'BGHJ01', 0, '[데크]', '', NULL, 15, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '16', '[데크]3*4이며 나무 자라고 있는곳임.개수대가까움', 'BGHJ01', 0, '[데크]', '', NULL, 16, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '17', '[데크]3*4이며 나무 자라고 있는곳임.개수대가까움.', 'BGHJ01', 0, '[데크]', '', NULL, 17, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '18', '[데크]3*4이며 나무 자라고 있는곳임.개수대 가까움', 'BGHJ01', 0, '[데크]', '', NULL, 18, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '19', '[데크]3*4이며 나무 자라고 있는곳임.개수대 가까움', 'BGHJ01', 0, '[데크]', '', NULL, 19, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '20', '[데크]3*5이며 계곡가까움,화장실거리40m', 'BGHJ01', 0, '[데크]', '', NULL, 20, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '21', '[데크]3*5이며 계곡가까움,화장실거리40m,앞공간여유많음', 'BGHJ01', 0, '[데크]', '', NULL, 21, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '22', '[데크]3*4이며 계곡가까움 옆공간 여유많음', 'BGHJ01', 0, '[데크]', '', NULL, 22, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '23', '[데크]3*4이며 그늘없음 화장실거리40m', 'BGHJ01', 0, '[데크]', '', NULL, 23, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '24', '[데크3*4이며 계곡가까움.그늘없음', 'BGHJ01', 0, '[데크]', '', NULL, 24, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '25', '[데크]3*4이며 계곡가까움.그늘없음', 'BGHJ01', 0, '[데크]', '', NULL, 25, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '26', '[데크]3*4이며 그늘없음', 'BGHJ01', 0, '[데크]', '', NULL, 26, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '27', '[데크]3*4이며 계곡가까움.그늘없음', 'BGHJ01', 0, '[데크]', '', NULL, 27, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '28', '[데크]3*4이며 계곡가까움.그늘시간대에따라나옴,옆공간많음', 'BGHJ01', 0, '[데크]', '', NULL, 28, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '29', '[데크][데크]3*4이며 개수대앞큰나무아래,화장실 개수대가까움', 'BGHJ01', 0, '[데크]', '', NULL, 29, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '30', '[데크]3*5이며 계곡으로 앞공간 여유많음 화장실거리60m,단체석으로 추천', 'BGHJ01', 0, '[데크]', '', NULL, 30, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '31', '[데크]3*5이며 계곡으로 앞공간 여유많음 화장실거리60m,단체석으로 추천', 'BGHJ01', 0, '[데크]', '', NULL, 31, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '32', '[데크]3*5이며 계곡으로 앞공간 여유많음 화장실거리70m,단체석으로 추천', 'BGHJ01', 0, '[데크]', '', NULL, 32, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '33', '[데크]3*5이며 계곡으로 앞공간 여유많음 화장실거리70m,단체석으로 추천', 'BGHJ01', 0, '[데크]', '', NULL, 33, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '34', '[데크]3*5이며 계곡으로 앞공간 여유많음 화장실거리80m,단체석으로 추천', 'BGHJ01', 0, '[데크]', '', NULL, 34, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '35', '[데크]3*5이며 계곡으로 앞공간 여유많음 화장실거리80m,단체석으로 추천', 'BGHJ01', 0, '[데크]', '', NULL, 35, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '36', '[잔디]5*8정도이며,큰텐트추천 개수대 화장실 가까움', 'BGHJ01', 0, '[잔디]', '', NULL, 36, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '37', '[잔디]5*8정도이며,큰텐트추천 개수대 화장실 가까움.해먹가능', 'BGHJ01', 0, '[잔디]', '', NULL, 37, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '38', '[잔디]5*8정도이며,큰텐트추천 개수대 화장실 가까움', 'BGHJ01', 0, '[잔디]', '', NULL, 38, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '39', '[파쇄석]5*8정도이며,큰텐트추천 개수대 화장실 가까움 그늘자리.', 'BGHJ01', 0, '[파쇄석]', '', NULL, 39, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '40', '[파쇄석]5*8정도이며,큰텐트추천 개수대 화장실 가까움.그늘자리.큰텐트자리 파쇄석', 'BGHJ01', 0, '[파쇄석]', '', NULL, 40, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('ROOM_NUM', '데크NO', '41', '[잔디]캠장들어오는 초입,그늘 시간대에따라 나옴 해먹가능.큰텐트자리', 'BGHJ01', 0, '[잔디]', '', NULL, 41, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2015-06-18 20:12:31'),
('DAY_MONEY', '기본금액', '4', '4박', 'BGHJ01', 95000, NULL, NULL, NULL, NULL, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2016-05-16 15:32:43'),
('DAY_MONEY', '기본금액', '1', '1박', 'BGHJ01', 30000, NULL, NULL, NULL, NULL, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2016-05-13 20:03:58'),
('DAY_MONEY', '기본금액', '3', '3박', 'BGHJ01', 75000, NULL, NULL, NULL, NULL, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2016-05-16 15:32:43'),
('DAY_MONEY', '기본금액', '2', '2박', 'BGHJ01', 55000, NULL, NULL, NULL, NULL, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2016-05-16 15:32:43'),
('HOT_DAY', '성수기기간', 'FROM_DAY', '2016-07-22', 'BGHJ01', 0, NULL, NULL, NULL, NULL, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2016-05-18 21:00:48'),
('HOT_DAY', '성수기기간', 'TO_DAY', '2016-08-21', 'BGHJ01', 0, '', '', NULL, NULL, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2016-05-18 21:00:48'),
('MESSAGE', 'MESSAGE', 'MESSAGE', '기준 인원은 5인,인원추가 3천원, 예약후 24시간 이내 미입금시 취소 될 수 있습니다.(성수기:4만원) 당일 입금 부탁드립니다. ', 'BGHJ01', 0, '', '', NULL, NULL, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2016-05-18 21:53:05'),
('ADD_OPTION', '금액옵션', 'CAR_ADD_CNT', '추가차량', 'BGHJ01', 0, '0', NULL, NULL, NULL, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2016-05-13 17:49:55'),
('ADD_OPTION', '금액옵션', 'PEOPLE_ADD_CNT', '추가인원', 'BGHJ01', 3000, '4', NULL, NULL, NULL, 'C', 'MES', 'C', NULL, 'U', 'MES', 'MES', '2016-05-13 17:49:55');
