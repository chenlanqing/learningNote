-- 索引优化
create table if not exists `article`(
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `author_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `views` int(10) unsigned NOT NULL,
  `comments` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `contents` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `article` (`author_id`, `category_id`, `views`, `comments`, `title`, `contents`) VALUES ('1', '1', '1', '1', '1', '1');
INSERT INTO `article` (`author_id`, `category_id`, `views`, `comments`, `title`, `contents`) VALUES ('2', '2', '2', '2', '2', '2');
INSERT INTO `article` (`author_id`, `category_id`, `views`, `comments`, `title`, `contents`) VALUES ('1', '1', '3', '3', '3', '3');

CREATE TABLE `book` (
  `bookid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `card` int(10) unsigned NOT NULL,
  PRIMARY KEY (`bookid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `card` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO category(card) VALUES(FLOOR(1+ (RAND()*20)));

INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));
INSERT INTO book(card) VALUES(FLOOR(1+ (RAND()*20)));

CREATE TABLE `staffs` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '姓名',
  `age` int(11) NOT NULL DEFAULT '0' COMMENT '年龄',
  `pos` varchar(255) NOT NULL COMMENT '职位',
  `add_time` timestamp NULL DEFAULT NULL COMMENT '入职时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
