DROP TABLE IF EXISTS `elua`.`builds`;
CREATE TABLE  `elua`.`builds` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `configs` text,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `elua`.`builds_files`;
CREATE TABLE  `elua`.`builds_files` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `build_id` int(10) unsigned NOT NULL,
  `file_id` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `elua`.`files`;
CREATE TABLE  `elua`.`files` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `filename` varchar(255) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `elua`.`users`;
CREATE TABLE  `elua`.`users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `actived` tinyint(1) unsigned zerofill NOT NULL default '1',
  `login` varchar(10) NOT NULL,
  `passwd` varchar(32) NOT NULL,
  `email` varchar(80) NOT NULL,
  `name` varchar(80) NOT NULL,
  `country` varchar(50) default NULL,
  `organization` varchar(80) default NULL,
  `elua_list` tinyint(1) default NULL,
  `remarks` text,
  `resume` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;