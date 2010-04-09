-- phpMyAdmin SQL Dump
-- version 3.2.2.1deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: Abr 09, 2010 as 10:38 AM
-- Versão do Servidor: 5.1.37
-- Versão do PHP: 5.2.10-2ubuntu6.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Banco de Dados: `c6eluabuilder`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `builds`
--

CREATE TABLE IF NOT EXISTS `builds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `configs` text,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=156 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `builds_files`
--

CREATE TABLE IF NOT EXISTS `builds_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `build_id` int(10) unsigned NOT NULL,
  `file_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=430 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `category` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=77 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `actived` tinyint(1) unsigned zerofill NOT NULL DEFAULT '1',
  `login` varchar(30) NOT NULL,
  `passwd` varchar(32) NOT NULL,
  `email` varchar(80) NOT NULL,
  `name` varchar(80) NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `organization` varchar(80) DEFAULT NULL,
  `elua_list` tinyint(1) DEFAULT NULL,
  `remarks` text,
  `resume` text,
  `user_hash` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;
