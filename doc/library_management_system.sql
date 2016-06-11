create database library;

create table book(
    bno     char(7) primary key,
    bname   varchar(50),
    btno    char(3),
    bprint  varchar(50),
    bauthor varchar(20) default '佚名',
    bnum    int,
    ano     varchar(50), 
    constraint bano foreign key(ano)
    references admin(ano)
)
engine = InnoDB
character set gb2312 collate gb2312_chinese_ci;

create table reader(
    rno   varchar(20) primary key,
    rname varchar(20),
    rkey  varchar(20),
    rtel  varchar(15),
    rage  char(3),
    rsex  char(3) default '密'
    ano   varchar(50), 
    constraint rano foreign key(ano)
    references admin(ano)
)
engine = InnoDB
character set gb2312 collate gb2312_chinese_ci;

create table admin(
    ano     varchar(50),
    aname   varchar(20),
    asex    char(3) '密',
    akey    varchar(20),
    atel    varchar(15),
    acareer varchar(20)
)
engine = InnoDB
character set gb2312 collate gb2312_chinese_ci;

create table type(
    tno   char(3),
    tname varchar(20),
    tloc  varchar(50)
)
engine = InnoDB
character set gb2312 collate gb2312_chinese_ci;

create table borrow(
    rno   varchar(20),
    bno   char(7),
    edate date,
    sdate date,
    rdate date,
    constraint rno foreign key (rno)
    references reader(rno),
    constraint bno foreign key (bno)
    references book(bno)
)
engine = InnoDB
character set gb2312 collate gb2312_chinese_ci;

alter table reader add constraint uk_rno unique(rno);
alter table book add constraint uk_bno unique(bno);
alter table admin add constraint uk_ano unique(ano);

create view borrow_view(rno, bno, bname, bprint, bauthor, sdate, rdate)
as select
    rno, book.bno, bname, bprint, bauthor, sdate, rdate
from book, borrow
where book.bno = borrow.bno;
	
-- delimiter *
-- create trigger rsex_rule after insert 
-- on reader for each row
-- begin
--     if (new.rsex not in('男', '女', '密')) then
--         delete from reader where rsex = new.rsex;
--     end if;
-- end *
-- delimiter ;

-- delimiter *
-- create trigger asex_rule after insert 
-- on admin for each row
-- begin
--     if (new.asex not in('男', '女', '密')) then
--         delete from admin where asex = new.asex;
--    end if;
-- end *
-- delimiter ;

drop trigger if exists rsex_rule;
delimiter *
create trigger rsex_rule after insert 
on reader for each row
begin
    if ((select reader.rsex from reader
    where reader.rno = new.rno) not in ('男', '女', '密')) then
        delete from reader where rsex = new.rsex;
    end if;
end *

delimiter ;
drop trigger if exists asex_rule;
delimiter *
create trigger asex_rule after insert 
on admin for each row
begin
    if ((select admin.asex from admin, new 
    where admin.ano = new.ano) not in ('男', '女', '密')) then
        delete from admin where asex = new.asex;
    end if;
end *
delimiter ;

drop trigger if exists borrow_return;
delimiter *
create trigger borrow_return after insert
on borrow for each row
begin
    if ((select min(borrow.edate) from borrow
    where borrow.rno = new.rno) < current_date()) then
        delete from borrow where edate = new.edate;
    end if;
end *
delimiter ;

create index reader_index on reader(rno asc);
create index book_index on book(bno asc);
create index borrow_index on borrow(rno asc);


insert into admin(ano, aname, asex, akey, atel, acareer) values
('0000', 'root', '', '0000', '0000', 'root');

insert into reader(rno, rname, rkey, rtel, rsex, ano) values
('0000', '李刚', '1000', '17392817495', '男', '0000'),
('0001', '张伟', '1001', '13528576392', '男', '0000'),
('0002', '王芳', '1002', '13223050038', '女', '0000'),
('0003', '李伟', '1003', '18946937338', '男', '0000'),
('0004', '张丽', '1004', '18893392735', '女', '0000'),
('0005', '李强', '1005', '19387492324', '男', '0000'),
('0006', '王磊', '1006', '18392893823', '男', '0000'),
('0007', '刘洋', '1007', '12338978937', '男', '0000'),
('0008', '王军', '1008', '18383268423', '男', '0000'),
('0009', '张杰', '1009', '19171717163', '男', '0000'),
('0010', '黄博', '1010', '18726251534', '男', '0000'),
('0011', '赵婷', '1011', '16348792981', '女', '0000'),
('0012', '杨广', '1012', '13627181782', '男', '0000'),
('0013', '梦嫣', '1013', '18763831834', '女', '0000'),
('0014', '孙悦', '1014', '18733616370', '男', '0000');

insert into book(bno, bname, btno, bprint, bauthor, bnum, ano) values
('0000', 'ROS机器人程序设计', 'TP', '机械工业出版社', 'Aaron Martinez', 5, '0000'),
('0001', '开源机器人操作系统ROS', 'TP', '科学出版社', '张建伟', 3, '0000'),
('0002', 'CPU自制入门', 'TP', '人民邮电出版社', '水头一寿', 3, '0000'),
('0003', '自己动手写CPU', 'TP', '电子工业出版社', '雷思磊', 4, '0000'),
('0004', '自己设计制作CPU与单片机', 'TP', '人民邮电出版社', '姜咏江', 4, '0000'),
('0005', 'Linux高级程序设计', 'TP', '高等教育出版社', '罗怡桂', 4, '0000'),
('0006', 'Linux就是这个范儿', 'TP', '人民邮电出版社', '赵鑫磊', 4, '0000'),
('0007', 'Linux C编程从入门到精通', 'TP', '人民邮电出版社', '宋磊', 4, '0000'),
('0008', 'Linux内核设计与实现', 'TP', '机械工业出版社', 'Robert Love', 5, '0000'),
('0009', 'Linux环境下Qt4图形界面与MySQL编程', 'TP', '机械工业出版社', '邱铁', 5, '0000'),
('0010', 'UNIX环境高级编程', 'TP', '人民邮电出版社', 'W.Richard Stevens', 3, '0000'),
('0011', 'UNIX网络程序设计', 'TP', '科学出版社', '吴念', 4, '0000'),
('0012', 'C++ Primer中文版', 'TP', '电子工业出版社', 'Lippman, Stanley B', 5, '0000'),
('0013', 'C专家编程', 'TP', '人民邮电出版社', 'Peter Van der Linden', 2, '0000'),
('0014', 'Verilog数字系统设计教程', 'TP', '北京航空航天大学出版社', '夏宇闻', 4, '0000');

insert into type(tno, tname, tloc) values
('T', '工业技术', '图书馆四层'),
('TP', '计算机技术', '图书馆四层'),
('TN', '电子技术', '图书馆四层'),
('TM', '电工技术', '图书馆四层'),
('TK', '能源与动力工程', '图书馆四层'),
('TH', '机械仪表工业', '图书馆四层'),
('TG', '金属工艺', '图书馆四层'),
('TB', '一般工业技术', '图书馆四层'),
('TQ', '化学工业', '图书馆四层'),
('TU', '建筑科学', '图书馆四层'),
('TV', '水利工程', '图书馆四层'),
('U', '交通运输', '图书馆四层'),
('V', '航空航天', '图书馆四层'),
('X', '环境科学', '图书馆四层'),
('M', '科技工具书', '图书馆四层'),
('H', '语言文字', '图书馆三层'),
('N', '自然科学总论', '图书馆三层'),
('O', '数理科学', '图书馆三层'),
('P', '天文学', '图书馆三层'),
('Q', '生理科学', '图书馆三层'),
('R', '医药卫生', '图书馆三层'),
('S', '农业科学', '图书馆三层');
