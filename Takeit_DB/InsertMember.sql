-- 建立會員資料
insert into Member(Account, Password, Nickname) values('Admin', '000', '管理員');
insert into Member(Account, Password, Nickname) values('0911111111', '000', '張三');
insert into Member(Account, Password, Nickname, Black_Mark) values('0911111112', '000', '李四(黑名單測試)', 1);
