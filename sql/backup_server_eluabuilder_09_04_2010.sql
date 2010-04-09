-- phpMyAdmin SQL Dump
-- version 3.2.2.1deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: Abr 09, 2010 as 10:36 AM
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

--
-- Extraindo dados da tabela `builds`
--

INSERT INTO `builds` (`id`, `title`, `created_at`, `configs`, `user_id`) VALUES
(7, 'Teste 1', '2009-10-29 12:03:55', '{file_id="",build_shell="true",build_adc="true",toolchain="codesourcery",id="",build_uip="true",created_at="",build_xmodem="true",build_con_tcp="true",build_term="true",title="Teste 1",build_dhcpc="true",target="EK-LM3S8962",build_dns="true",build_romfs="true",build_con_generic="true",}', 5),
(8, 'teste', '2009-10-29 13:43:49', '{file_id=3,dns2="",ip0="",target="EK-LM3S6965",build_con_generic="false",created_at="2009-10-29 13:43:49",dns3="",build_con_tcp="false",title="teste",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="false",gateway0="",ip3="",scons="scons board=EK-LM3S6965   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway1="",gateway3="",toolchain="default",id=8,dns1="",build_romfs="true",ip2="",build_shell="false",build_dhcpc="true",romfsmode="verbatim",build_dns="false",ip1="",build_adc="false",build_term="false",mask0="",}', 2),
(9, 'test configuration', '2009-10-29 16:48:11', '{file_id="",build_shell="true",build_dns="false",toolchain="codesourcery",id="",build_uip="false",created_at="",build_xmodem="false",build_con_tcp="false",build_adc="true",title="test configuration",build_dhcpc="false",target="EK-LM3S6965",build_term="true",build_romfs="true",build_con_generic="true",}', 6),
(17, 'test', '2009-11-25 13:29:27', '{file_id="",build_shell="true",build_term="true",toolchain="default",id="",build_uip="true",created_at="",build_xmodem="true",build_con_tcp="true",build_adc="true",title="test",build_dhcpc="true",target="EK-LM3S8962",build_dns="true",build_romfs="true",build_con_generic="false",}', 9),
(41, 'Meu build', '2010-01-14 16:21:26', '{file_id=33,dns2="",ip0="",target="EK-LM3S8962",build_con_generic="false",created_at="2010-01-14 16:21:26",dns3="",build_con_tcp="true",title="Meu build",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",gateway0="",build_romfs="true",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway1="",build_shell="true",toolchain="default",id=41,gateway3="",build_term="true",ip2="",dns1="",build_dhcpc="true",ip3="",build_dns="true",ip1="",build_adc="true",romfsmode="verbatim",mask0="",}', 2),
(71, 'teste EK-LM3S9B692', '2010-02-02 11:49:38', '{file_id={1,23,},dns2=100,ip0=192,target="EK-LM3S9B92",build_con_generic="true",created_at="2010-02-02 11:49:38",dns3=20,build_con_tcp="false",title="teste EK-LM3S9B692",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip="false",build_xmodem="false",gateway0=192,ip3=5,scons="scons board=EK-LM3S9B92   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway1=168,dns1=168,toolchain="default",id=71,build_romfs="true",romfsmode="verbatim",ip2=100,gateway3=20,build_dhcpc="false",build_adc="false",build_dns="false",ip1=168,build_shell="false",build_term="false",mask0=255,}', 1),
(72, 'teste EK-LM3S6965', '2010-02-02 11:51:58', '{file_id={1,23,},dns2=100,ip0=192,build_mmcfs="",target="EK-LM3S6965",build_con_generic="",created_at="2010-02-02 11:51:58",dns3=20,build_con_tcp="//",title="teste EK-LM3S6965",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_rpc="",build_xmodem="",gateway0=192,ip3=5,scons="scons board=EK-LM3S6965   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway3=20,gateway1=168,build_shell="",toolchain="default",dns1=168,build_romfs="",romfsmode="verbatim",ip2=100,build_dhcpc="//",build_term="",build_adc="",build_dns="//",ip1=168,build_uip="//",mask0=255,id=72,}', 1),
(73, 'teste EAGLE-100', '2010-02-02 11:55:37', '{file_id={1,23,},dns2=100,ip0=192,build_mmcfs="",target="EAGLE-100",build_con_generic="",created_at="2010-02-02 11:55:37",dns3=20,build_con_tcp="//",title="teste EAGLE-100",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_rpc="",build_xmodem="",gateway0=192,ip3=5,scons="scons board=EAGLE-100   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway3=20,gateway1=168,build_shell="",toolchain="default",dns1=168,build_romfs="",romfsmode="verbatim",ip2=100,build_dhcpc="//",build_term="",build_adc="",build_dns="//",ip1=168,build_uip="//",mask0=255,id=73,}', 1),
(75, 'teste MOD711', '2010-02-02 13:07:42', '{file_id=23,dns2=100,ip0=192,target="MOD711",build_con_generic="",created_at="2010-02-02 13:07:42",dns3=20,build_con_tcp="//",title="teste MOD711",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip="//",build_xmodem="",gateway0=192,ip3=5,scons="scons board=MOD711   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="",gateway3=20,toolchain="default",id=75,build_romfs="",dns1=168,ip2=100,build_adc="//",build_dhcpc="//",romfsmode="verbatim",build_dns="//",ip1=168,gateway1=168,build_term="",mask0=255,}', 1),
(76, 'teste STR9-COMSTICK', '2010-02-02 13:09:02', '{file_id=23,dns2=100,ip0=192,target="STR9-COMSTICK",build_con_generic="",created_at="2010-02-02 13:09:02",dns3=20,build_con_tcp="//",title="teste STR9-COMSTICK",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip="//",build_xmodem="",gateway0=192,ip3=5,scons="scons board=STR9-COMSTICK   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="",gateway3=20,toolchain="default",id=76,build_romfs="",dns1=168,ip2=100,build_adc="//",build_dhcpc="//",romfsmode="verbatim",build_dns="//",ip1=168,gateway1=168,build_term="",mask0=255,}', 1),
(77, 'teste STR-E912', '2010-02-02 13:11:48', '{file_id=23,dns2=100,ip0=192,target="STR-E912",build_con_generic="",created_at="2010-02-02 13:11:48",dns3=20,build_con_tcp="//",title="teste STR-E912",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip="//",build_xmodem="",gateway0=192,ip3=5,scons="scons board=STR-E912   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="",gateway3=20,toolchain="default",id=77,build_romfs="",dns1=168,ip2=100,build_adc="//",build_dhcpc="//",romfsmode="verbatim",build_dns="//",ip1=168,gateway1=168,build_term="",mask0=255,}', 1),
(78, 'teste PC', '2010-02-02 13:12:15', '{file_id=23,dns2=100,ip0=192,target="PC",build_con_generic="",created_at="2010-02-02 13:12:15",dns3=20,build_con_tcp="//",title="teste PC",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip="//",build_xmodem="//",gateway0=192,ip3=5,scons="scons board=PC   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="",gateway3=20,toolchain="default",id=78,build_romfs="",dns1=168,ip2=100,build_adc="//",build_dhcpc="//",romfsmode="verbatim",build_dns="//",ip1=168,gateway1=168,build_term="",mask0=255,}', 1),
(82, 'teste ip net', '2010-02-03 16:10:07', '{file_id="",dns2="",ip0=192,target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="teste ip net",mask1=255,dns0="",mask3=0,gateway2=100,mask2=255,build_uip="true",build_xmodem="true",gateway0=192,build_romfs="true",gateway1=168,mask0=255,toolchain="default",id="",build_dns="false",build_term="true",ip2=100,build_adc="false",romfsmode="verbatim",dns1="",build_dhcpc="false",ip1=168,ip3=5,gateway3=20,build_shell="true",}', 7),
(83, 'net', '2010-02-03 16:12:24', '{file_id="",dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="net",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",gateway0="",build_romfs="true",build_dhcpc="false",gateway1="",mask0="",toolchain="default",id="",romfsmode="verbatim",build_rpc="true",ip2="",build_adc="true",dns1="",ip3="",build_dns="true",ip1="",build_term="true",gateway3="",build_shell="true",}', 7),
(85, 'teste 1', '2010-02-03 17:27:16', '{file_id=32,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S9B92",build_con_generic="true",created_at="2010-02-03 17:27:16",dns3="",build_con_tcp="false",title="teste 1",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",gateway0="",build_romfs="true",build_dns="false",gateway1="",build_term="true",toolchain="default",id=85,mask0="",romfsmode="verbatim",ip2="",build_rpc="true",build_adc="true",dns1="",build_dhcpc="false",ip1="",ip3="",gateway3="",build_shell="true",}', 2),
(89, 'teste SIM', '2010-02-10 13:34:46', '{file_id=23,dns2=100,ip0=192,target="SIM",build_con_generic="",created_at="2010-02-10 13:34:46",dns3=20,build_con_tcp="//",title="teste SIM",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip="//",build_xmodem="//",gateway0=192,ip3=5,scons="scons board=SIM   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="",gateway3=20,toolchain="default",id=89,build_romfs="",dns1=168,ip2=100,build_adc="//",build_dhcpc="//",romfsmode="verbatim",build_dns="//",ip1=168,gateway1=168,build_term="",mask0=255,}', 1),
(90, 'teste LPC-H2888', '2010-02-10 13:36:07', '{file_id=23,dns2=100,ip0=192,target="LPC-H2888",build_con_generic="",created_at="2010-02-10 13:36:07",dns3=20,build_con_tcp="//",title="teste LPC-H2888",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip="//",build_xmodem="",gateway0=192,ip3=5,scons="scons board=LPC-H2888   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="",gateway3=20,toolchain="default",id=90,build_romfs="",dns1=168,ip2=100,build_adc="//",build_dhcpc="//",romfsmode="verbatim",build_dns="//",ip1=168,gateway1=168,build_term="",mask0=255,}', 1),
(92, 'teste ET-STM32', '2010-02-10 13:39:30', '{file_id=23,dns2=100,ip0=192,build_mmcfs="",target="ET-STM32",build_con_generic="",created_at="2010-02-10 13:39:30",dns3=20,build_con_tcp="//",title="teste ET-STM32",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_rpc="",build_xmodem="",gateway0=192,ip3=5,scons="scons board=ET-STM32   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway3=20,gateway1=168,build_shell="",toolchain="default",dns1=168,build_romfs="",romfsmode="verbatim",ip2=100,build_dhcpc="//",build_term="",build_adc="",build_dns="//",ip1=168,build_uip="//",mask0=255,id=92,}', 1),
(93, 'teste ATEVK1100', '2010-02-10 13:43:19', '{file_id={23,24,},dns2=100,ip0=192,target="ATEVK1100",build_con_generic="",created_at="2010-02-10 13:43:19",dns3=20,build_con_tcp="//",title="teste ATEVK1100",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip="//",build_xmodem="",gateway0=192,ip3=5,scons="scons board=ATEVK1100   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="",gateway3=20,toolchain="default",id=93,build_romfs="",dns1=168,ip2=100,build_adc="//",build_dhcpc="//",romfsmode="verbatim",build_dns="//",ip1=168,gateway1=168,build_term="",mask0=255,}', 1),
(94, 'teste ELUA-PUC', '2010-02-10 13:44:40', '{file_id={23,35,},dns2=100,ip0=192,target="ELUA-PUC",build_con_generic="",created_at="2010-02-10 13:44:40",dns3=20,build_con_tcp="//",title="teste ELUA-PUC",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_rpc="",build_xmodem="",gateway0=192,ip3=5,scons="scons board=ELUA-PUC   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway3=20,build_shell="",build_romfs="",toolchain="default",id=94,dns1=168,build_uip="//",ip2=100,build_dhcpc="//",romfsmode="verbatim",build_adc="//",build_dns="//",ip1=168,gateway1=168,mask0=255,build_term="",}', 1),
(96, 'teste SAM7-EX256', '2010-02-10 14:31:22', '{file_id=36,dns2=100,ip0=192,target="SAM7-EX256",build_con_generic="",created_at="2010-02-10 14:31:22",dns3=20,build_con_tcp="//",title="teste SAM7-EX256",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip="//",build_xmodem="",gateway0=192,ip3=5,scons="scons board=SAM7-EX256   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="",gateway3=20,toolchain="default",id=96,build_romfs="",dns1=168,ip2=100,build_adc="//",build_dhcpc="//",romfsmode="verbatim",build_dns="//",ip1=168,gateway1=168,build_term="",mask0=255,}', 1),
(97, 'teste ip 192.168.100.5', '2010-02-12 16:44:13', '{file_id="",dns2="",ip0=192,build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="teste ip 192.168.100.5",mask1=255,dns0="",mask3=0,gateway2=100,mask2=255,build_uip="true",build_xmodem="true",gateway0=192,build_romfs="true",build_dhcpc="false",gateway1=168,mask0=255,toolchain="default",id="",romfsmode="verbatim",build_rpc="true",ip2=100,build_adc="true",dns1="",ip3=5,build_dns="true",ip1=168,build_term="true",gateway3=20,build_shell="true",}', 7),
(99, 'testeB STM3210E-EVAL', '2010-02-26 10:01:55', '{file_id=35,dns2=100,ip0=192,build_mmcfs="",target="STM3210E-EVAL",build_con_generic="",created_at="",dns3=20,build_con_tcp="//",title="testeB STM3210E-EVAL",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_rpc="",build_xmodem="",gateway0=192,ip3=5,scons="scons board=STM3210E-EVAL   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway3=20,gateway1=168,build_shell="",toolchain="default",dns1=168,build_romfs="",romfsmode="verbatim",ip2=100,build_dhcpc="//",build_term="",build_adc="",build_dns="//",ip1=168,build_uip="//",mask0=255,id="",}', 1),
(100, 'testeB ATEVK1100', '2010-02-26 10:02:56', '{file_id=0.3,dns2=100,ip0=192,target="ATEVK1100",build_con_generic="",created_at="",dns3=20,build_con_tcp="//",title="testeB ATEVK1100",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip="//",build_xmodem="",gateway0=192,ip3=5,scons="scons board=ATEVK1100   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="",gateway3=20,toolchain="default",id="",build_romfs="",dns1=168,ip2=100,build_adc="//",build_dhcpc="//",romfsmode="verbatim",build_dns="//",ip1=168,gateway1=168,build_term="",mask0=255,}', 1),
(101, 'testeB PC', '2010-02-26 10:03:30', '{file_id=36,dns2=100,ip0=192,target="PC",build_con_generic="",created_at="",dns3=20,build_con_tcp="//",title="testeB PC",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip="//",build_xmodem="//",gateway0=192,ip3=5,scons="scons board=PC   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="",gateway3=20,toolchain="default",id="",build_romfs="",dns1=168,ip2=100,build_adc="//",build_dhcpc="//",romfsmode="verbatim",build_dns="//",ip1=168,gateway1=168,build_term="",mask0=255,}', 1),
(102, 'testeB SIM', '2010-02-26 10:03:59', '{file_id=0.3,dns2=100,ip0=192,target="SIM",build_con_generic="",created_at="",dns3=20,build_con_tcp="//",title="testeB SIM",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_uip="//",build_xmodem="//",gateway0=192,ip3=5,scons="scons board=SIM   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="",gateway3=20,toolchain="default",id="",build_romfs="",dns1=168,ip2=100,build_adc="//",build_dhcpc="//",romfsmode="verbatim",build_dns="//",ip1=168,gateway1=168,build_term="",mask0=255,}', 1),
(103, 'LM_default', '2010-02-26 16:12:38', '{file_id={43,44,45,46,},dns2=100,ip0=192,target="EK-LM3S8962",build_con_generic="//",created_at="2010-02-26 16:12:38",dns3=20,build_con_tcp="//",title="LM_default",mask1=255,dns0=192,mask3=0,mask0=255,mask2=255,build_uip="//",build_xmodem="//",gateway0=192,ip3=5,scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway1=168,gateway3=20,toolchain="default",dns1=168,id=103,romfsmode="verbatim",ip2=100,build_shell="//",build_dhcpc="//",build_adc="//",build_dns="//",ip1=168,build_term="//",build_romfs="//",gateway2=100,}', 12),
(105, 'sAxdasd', '2010-03-04 16:00:34', '{file_id="",dns2=100,ip0=192,build_mmcfs="",target="PC",build_con_generic="//",created_at="",dns3=20,build_con_tcp="",title="sAxdasd",mask1=255,dns0=192,mask3=0,gateway2=100,mask2=255,build_rpc="",build_xmodem="",gateway0=192,ip3=5,scons="scons board=PC   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="",gateway1=168,gateway3=20,toolchain="default",id="",build_romfs="",romfsmode="verbatim",ip2=100,build_dhcpc="//",build_term="",build_adc="",build_dns="//",ip1=168,build_uip="//",dns1=168,mask0=255,}', 7),
(106, 'testando nova alteraÃ§Ã£o', '2010-03-05 11:42:14', '{file_id=24,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S9B92",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="testando nova alteraÃ§Ã£o",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",gateway0="",build_romfs="true",scons="scons board=EK-LM3S9B92   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="true",gateway1="",gateway3="",toolchain="default",id="",build_term="true",build_adc="true",ip2="",build_dns="true",ip3="",dns1="",build_dhcpc="false",ip1="",build_rpc="true",mask0="",romfsmode="verbatim",}', 1),
(107, 'net liquigas', '2010-03-08 18:14:50', '{file_id=53,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="net liquigas",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",only_user_files=1,gateway0="",build_romfs="true",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="true",gateway1="",gateway3="",toolchain="default",id="",build_term="true",build_adc="true",ip2="",build_dns="true",ip3="",dns1="",build_dhcpc="false",ip1="",build_rpc="true",mask0="",romfsmode="verbatim",}', 7),
(111, 'TesteLua', '2010-03-14 19:28:36', '{file_id=55,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="2010-03-14 19:28:36",dns3="",build_con_tcp="false",title="TesteLua",mask1="",dns0="",mask3="",gateway2="",mask2="",build_rpc="true",build_xmodem="false",gateway0="",ip3="",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt",dns1="",gateway1="",build_romfs="true",toolchain="default",id=111,build_adc="true",gateway3="",ip2="",build_dhcpc="false",build_shell="false",build_uip="false",build_dns="false",ip1="",mask0="",romfsmode="verbatim",build_term="false",}', 13),
(112, 'teste02', '2010-03-14 19:40:28', '{file_id=55,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="2010-03-14 19:40:28",dns3="",build_con_tcp="false",title="teste02",mask1="",dns0="",mask3="",gateway2="",mask2="",build_rpc="true",build_xmodem="false",gateway0="",ip3="",scons="scons board=EK-LM3S8962  toolchain=codesourcery  romfs=verbatim prog > log.txt 2> log_errors.txt",dns1="",gateway1="",build_romfs="true",toolchain="codesourcery",id=112,build_adc="true",gateway3="",ip2="",build_dhcpc="false",build_shell="false",build_uip="false",build_dns="false",ip1="",mask0="",romfsmode="verbatim",build_term="false",}', 13),
(113, 'teste03', '2010-03-14 20:11:16', '{file_id={54,55,},dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="teste03",mask1="",dns0="",mask3="",gateway2="",mask2="",build_rpc="true",build_xmodem="true",only_user_files=1,gateway0="",ip3="",scons="scons board=EK-LM3S8962  toolchain=codesourcery  romfs=verbatim prog > log.txt 2> log_errors.txt",gateway3="",gateway1="",dns1="",toolchain="codesourcery",id="",build_romfs="true",build_uip="false",ip2="",build_dhcpc="false",romfsmode="verbatim",build_shell="false",build_dns="false",ip1="",mask0="",build_adc="true",build_term="false",}', 13),
(114, 'teste04', '2010-03-14 20:13:03', '{file_id=56,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="teste04",mask1="",dns0="",mask3="",gateway2="",mask2="",build_rpc="true",build_xmodem="true",only_user_files=1,gateway0="",ip3="",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway3="",gateway1="",dns1="",toolchain="default",id="",build_romfs="true",build_uip="false",ip2="",build_dhcpc="false",romfsmode="verbatim",build_shell="false",build_dns="false",ip1="",mask0="",build_adc="true",build_term="false",}', 13),
(115, 'teste05', '2010-03-14 21:18:23', '{file_id="",dns2="",ip0="",build_mmcfs="true",target="EK-LM3S6965",build_con_generic="false",created_at="2010-03-14 21:18:23",dns3="",build_con_tcp="true",title="teste05",mask1="",dns0="",mask3="",gateway2="",mask2="",build_rpc="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S6965   romfs=compile prog > log.txt 2> log_errors.txt",build_shell="true",gateway1="",gateway3="",toolchain="default",id=115,build_romfs="true",romfsmode="compile",ip2="",build_dhcpc="false",build_term="true",build_adc="true",build_dns="false",ip1="",build_uip="false",dns1="",mask0="",}', 13),
(116, 'teste06', '2010-03-14 22:26:51', '{file_id="",dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="teste06",mask1="",dns0="",mask3="",gateway2="",mask2="",build_rpc="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway3="",build_shell="true",build_romfs="true",toolchain="default",id="",dns1="",build_uip="false",ip2="",build_dhcpc="false",build_adc="true",romfsmode="verbatim",build_dns="false",ip1="",gateway1="",mask0="",build_term="true",}', 13),
(117, 'teste06', '2010-03-14 23:34:02', '{file_id=55,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="teste06",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",only_user_files=1,gateway0="",build_romfs="true",scons="scons board=EK-LM3S8962  toolchain=codesourcery  romfs=compile prog > log.txt 2> log_errors.txt",build_shell="true",gateway1="",gateway3="",toolchain="codesourcery",id="",build_term="true",build_adc="true",ip2="",build_dns="true",ip3="",dns1="",build_dhcpc="false",ip1="",build_rpc="true",mask0="",romfsmode="compile",}', 13),
(118, 'teste07', '2010-03-15 10:15:20', '{file_id=55,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="teste07",mask1="",dns0="",mask3="",gateway2="",mask2="",build_rpc="true",build_xmodem="true",only_user_files=1,gateway0="",ip3="",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway3="",gateway1="",build_shell="true",toolchain="default",dns1="",build_romfs="true",romfsmode="verbatim",ip2="",build_dhcpc="false",build_term="true",build_adc="true",build_dns="false",ip1="",mask0="",build_uip="false",id="",}', 13),
(119, 'Anubis', '2010-03-15 12:12:54', '{file_id=57,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="2010-03-15 12:12:54",dns3="",build_con_tcp="false",title="Anubis",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",gateway0="",build_romfs="true",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="true",gateway1="",gateway3="",toolchain="default",id=119,ip3="",build_rpc="true",ip2="",build_dhcpc="false",dns1="",build_adc="true",build_dns="false",ip1="",romfsmode="verbatim",mask0="",build_term="true",}', 2),
(120, 'teste07', '2010-03-17 11:41:33', '{file_id=55,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="teste07",mask1="",dns0="",mask3="",gateway2="",mask2="",build_rpc="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway3="",gateway1="",build_shell="true",toolchain="default",dns1="",build_romfs="true",romfsmode="verbatim",ip2="",build_dhcpc="false",build_term="true",build_adc="true",build_dns="false",ip1="",build_uip="false",mask0="",id="",}', 13),
(121, 'teste08', '2010-03-19 19:31:07', '{file_id={55,0.4,0.6,0.7,},dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="teste08",mask1="",dns0="",mask3="",gateway2="",mask2="",build_rpc="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt",gateway3="",gateway1="",build_shell="true",toolchain="default",dns1="",build_romfs="true",romfsmode="verbatim",ip2="",build_dhcpc="false",build_term="true",build_adc="true",build_dns="false",ip1="",build_uip="false",mask0="",id="",}', 13),
(122, 'teste09', '2010-03-21 22:18:27', '{file_id=55,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="teste09",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",gateway0="",build_romfs="true",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt",build_shell="true",gateway1="",gateway3="",toolchain="default",id="",build_term="true",build_adc="true",ip2="",build_dns="true",ip3="",dns1="",build_dhcpc="false",ip1="",build_rpc="true",mask0="",romfsmode="verbatim",}', 13),
(125, 'New Build Fri Mar 26 13:55:54 2010', '2010-03-26 13:56:37', '{file_id={1,23,},dns2="",ip0="",build_mmcfs="true",build_term="true",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",romfsmode="verbatim",mask1="",dns0="",mask3="",gateway2="",mask2="",autorun_file_id=1,build_uip="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S9B92   romfs=verbatim prog > log.txt 2> log_errors.txt",build_romfs="true",build_shell="true",title="New Build Fri Mar 26 13:55:54 2010",toolchain="default",build_adc="true",target="EK-LM3S9B92",build_rpc="true",ip2="",build_dns="true",gateway3="",gateway1="",build_dhcpc="false",ip1="",id="",dns1="",mask0="",}', 1),
(127, 'New Build Fri Mar 26 14:06:04 2010', '2010-03-26 14:06:14', '{file_id=23,dns2="",ip0="",build_mmcfs="true",build_term="true",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",romfsmode="verbatim",mask1="",dns0="",mask3="",gateway2="",mask2="",autorun_file_id=23,build_uip="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt",build_romfs="true",build_shell="true",title="New Build Fri Mar 26 14:06:04 2010",toolchain="default",build_adc="true",target="EK-LM3S8962",build_rpc="true",ip2="",build_dns="true",gateway3="",gateway1="",build_dhcpc="false",ip1="",id="",dns1="",mask0="",}', 1),
(128, 'New Build Fri Mar 26 14:12:40 2010', '2010-03-26 14:12:51', '{file_id=24,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S9B92",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",romfsmode="verbatim",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S9B92   romfs=verbatim prog > log.txt 2> log_errors.txt",title="New Build Fri Mar 26 14:12:40 2010",build_shell="true",build_romfs="true",toolchain="default",build_adc="true",build_term="true",build_rpc="true",ip2="",build_dns="true",gateway3="",gateway1="",build_dhcpc="false",ip1="",id="",dns1="",mask0="",}', 1),
(138, 'New Build Fri Mar 26 15:34:34 2010', '2010-03-26 15:34:37', '{file_id=33,dns2="",ip0="",build_mmcfs="true",build_term="true",build_con_generic="true",created_at="2010-03-26 15:34:37",dns3="",build_con_tcp="false",romfsmode="verbatim",mask1="",dns0="",mask3="",gateway2="",mask2="",autorun_file_id=33,build_uip="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=STR-E912   romfs=verbatim prog > log.txt 2> log_errors.txt;",build_romfs="true",build_shell="true",title="New Build Fri Mar 26 15:34:34 2010",toolchain="default",build_adc="true",target="STR-E912",build_rpc="true",ip2="",build_dns="true",gateway3="",gateway1="",build_dhcpc="false",ip1="",id=138,dns1="",mask0="",}', 2),
(139, 'lm3scru', '2010-03-26 16:13:40', '{file_id="",dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",romfsmode="verbatim",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt;",build_adc="true",build_shell="true",title="lm3scru",toolchain="default",id="",build_romfs="true",build_term="true",ip2="",build_dns="true",gateway1="",gateway3="",build_dhcpc="false",ip1="",build_rpc="true",dns1="",mask0="",}', 8),
(144, 'New Build Mon Mar 29 13:49:04 2010', '2010-03-29 13:49:20', '{file_id=16,dns2="",ip0="",build_mmcfs="true",build_term="true",build_con_generic="true",created_at="2010-03-29 13:49:20",dns3="",build_con_tcp="false",romfsmode="verbatim",mask1="",dns0="",mask3="",gateway2="",mask2="",autorun_file_id=16,build_uip="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=//  toolchain=//  romfs=// prog > log.txt 2> log_errors.txt;",build_shell="true",title="New Build Mon Mar 29 13:49:04 2010",toolchain="default",build_adc="true",build_romfs="true",target="EK-LM3S8962",ip2="",gateway1="",build_dns="true",gateway3="",build_dhcpc="false",ip1="",id=144,dns1="",mask0="",}', 8),
(148, 'build do ricardinho', '2010-03-31 11:50:24', '{file_id="",dns2="",ip0="",target="STR-E912",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",title="build do ricardinho",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="false",build_xmodem="true",gateway0="",build_romfs="true",scons="scons board=STR-E912   romfs=verbatim prog > log.txt 2> log_errors.txt;",gateway1="",romfsmode="verbatim",toolchain="default",id="",build_shell="true",gateway3="",ip2="",dns1="",build_dhcpc="false",build_term="true",build_dns="false",ip1="",build_adc="false",ip3="",mask0="",}', 8),
(149, 'My First Build', '2010-03-31 20:43:00', '{file_id={61,62,63,64,65,66,67,},dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="2010-03-31 20:43:00",dns3="",build_con_tcp="false",romfsmode="verbatim",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt;",title="My First Build",build_shell="true",build_romfs="true",toolchain="default",build_adc="true",build_term="true",build_rpc="true",ip2="",build_dns="true",gateway3="",gateway1="",build_dhcpc="false",ip1="",id=149,dns1="",mask0="",}', 14),
(150, 'New Build Fri Mar 26 15:34:34 2010', '2010-04-01 14:07:17', '{file_id="",dns2="",ip0="",build_mmcfs="true",target="MOD711",build_con_generic="true",created_at="2010-04-01 14:07:17",dns3="",build_con_tcp="false",romfsmode="verbatim",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=MOD711   romfs=verbatim prog > log.txt 2> log_errors.txt;",build_adc="true",build_shell="true",title="New Build Fri Mar 26 15:34:34 2010",toolchain="default",id=150,build_romfs="true",build_term="true",ip2="",build_dns="true",gateway1="",gateway3="",build_dhcpc="false",ip1="",build_rpc="true",dns1="",mask0="",}', 2),
(151, '1test', '2010-04-02 22:44:45', '{file_id=0.19,dns2="",ip0="",build_mmcfs="true",build_term="true",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",romfsmode="verbatim",mask1="",dns0="",mask3="",gateway2="",mask2="",autorun_file_id=0.19,build_uip="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt;",build_romfs="true",build_shell="true",title="1test",toolchain="default",build_adc="true",target="EK-LM3S8962",build_rpc="true",ip2="",build_dns="true",gateway3="",gateway1="",build_dhcpc="false",ip1="",id="",dns1="",mask0="",}', 15),
(152, '2test', '2010-04-02 22:48:55', '{file_id=0.2,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="2010-04-02 22:44:45",dns3="",build_con_tcp="false",romfsmode="verbatim",mask1="",dns0="",mask3="",gateway2="",mask2="",autorun_file_id=0.2,build_uip="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt;",build_shell="true",build_romfs="true",toolchain="default",build_adc="true",build_term="true",gateway1="",ip2="",title="2test",build_dns="true",gateway3="",build_dhcpc="false",ip1="",build_rpc="true",dns1="",mask0="",}', 15),
(153, '3test', '2010-04-02 22:51:16', '{file_id=68,dns2="",ip0="",build_mmcfs="true",target="EK-LM3S8962",build_con_generic="true",created_at="",dns3="",build_con_tcp="false",romfsmode="verbatim",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt;",title="3test",build_shell="true",build_romfs="true",toolchain="default",build_adc="true",build_term="true",build_rpc="true",ip2="",build_dns="true",gateway3="",gateway1="",build_dhcpc="false",ip1="",id="",dns1="",mask0="",}', 15),
(154, 'New Build Sat Apr  3 00:58:16 2010', '2010-04-03 01:04:29', '{file_id={29,5,},dns2="",ip0="",build_mmcfs="true",build_term="true",build_con_generic="true",created_at="2010-04-03 01:04:29",dns3="",build_con_tcp="false",romfsmode="verbatim",mask1="",dns0="",mask3="",gateway2="",mask2="",autorun_file_id=29,build_uip="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S8962   romfs=verbatim prog > log.txt 2> log_errors.txt;",build_romfs="true",build_shell="true",title="New Build Sat Apr  3 00:58:16 2010",toolchain="default",build_adc="true",target="EK-LM3S8962",build_rpc="true",ip2="",build_dns="true",gateway3="",gateway1="",build_dhcpc="false",ip1="",id=154,dns1="",mask0="",}', 3),
(155, '9B92-pro-Fernando', '2010-04-06 22:09:35', '{file_id={29,49,51,47,48,70,71,5,72,73,74,75,76,},dns2="",ip0="",build_mmcfs="true",target="EK-LM3S9B92",build_con_generic="true",created_at="2010-04-06 22:09:35",dns3="",build_con_tcp="false",romfsmode="verbatim",mask1="",dns0="",mask3="",gateway2="",mask2="",build_uip="true",build_xmodem="true",gateway0="",ip3="",scons="scons board=EK-LM3S9B92   romfs=verbatim prog > log.txt 2> log_errors.txt;",title="9B92-pro-Fernando",build_shell="true",build_romfs="true",toolchain="default",build_adc="true",build_term="true",build_rpc="true",ip2="",build_dns="true",gateway3="",gateway1="",build_dhcpc="false",ip1="",id=155,dns1="",mask0="",}', 3);

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

--
-- Extraindo dados da tabela `builds_files`
--

INSERT INTO `builds_files` (`id`, `build_id`, `file_id`) VALUES
(16, 7, 0),
(17, 8, 3),
(18, 9, 0),
(28, 17, 0),
(105, 41, 33),
(149, 75, 0),
(150, 76, 23),
(151, 77, 23),
(152, 78, 23),
(153, 78, 0),
(161, 82, 0),
(162, 83, 0),
(164, 85, 32),
(165, 85, 32),
(166, 85, 32),
(193, 75, 23),
(194, 76, 23),
(195, 77, 23),
(204, 75, 23),
(205, 75, 23),
(208, 76, 23),
(209, 76, 23),
(210, 77, 23),
(211, 78, 23),
(212, 89, 23),
(213, 90, 23),
(214, 90, 23),
(216, 92, 23),
(231, 96, 36),
(232, 97, 0),
(252, 72, 1),
(253, 72, 23),
(254, 73, 1),
(255, 73, 23),
(256, 75, 23),
(257, 76, 23),
(258, 77, 23),
(259, 78, 23),
(260, 89, 23),
(261, 90, 23),
(265, 92, 23),
(266, 93, 23),
(267, 93, 24),
(268, 94, 23),
(269, 94, 35),
(270, 96, 36),
(272, 99, 35),
(273, 100, 23),
(274, 101, 36),
(275, 102, 23),
(284, 103, 43),
(285, 103, 44),
(286, 103, 45),
(287, 103, 46),
(300, 105, 0),
(303, 106, 24),
(304, 107, 53),
(315, 8, 3),
(316, 8, 3),
(318, 111, 55),
(319, 111, 55),
(320, 111, 55),
(321, 111, 55),
(322, 111, 55),
(323, 111, 55),
(324, 112, 55),
(325, 112, 55),
(326, 111, 55),
(327, 113, 54),
(328, 113, 55),
(329, 114, 56),
(330, 115, 0),
(331, 115, 0),
(332, 115, 0),
(333, 116, 0),
(334, 117, 55),
(335, 118, 55),
(336, 119, 57),
(337, 119, 57),
(338, 119, 57),
(339, 119, 57),
(340, 119, 57),
(341, 119, 57),
(342, 119, 57),
(343, 119, 57),
(344, 119, 57),
(345, 119, 57),
(346, 119, 57),
(347, 119, 57),
(348, 120, 55),
(349, 71, 1),
(350, 71, 23),
(351, 41, 33),
(352, 119, 57),
(353, 121, 55),
(354, 121, 0),
(355, 121, 1),
(356, 121, 58),
(357, 121, 59),
(358, 122, 55),
(360, 125, 1),
(361, 125, 23),
(362, 127, 23),
(363, 128, 24),
(378, 144, 16),
(388, 149, 61),
(389, 149, 62),
(390, 149, 63),
(391, 149, 64),
(392, 149, 65),
(393, 149, 66),
(394, 149, 67),
(396, 138, 33),
(397, 151, 68),
(398, 152, 69),
(399, 153, 68),
(402, 154, 29),
(403, 154, 5),
(417, 155, 29),
(418, 155, 49),
(419, 155, 51),
(420, 155, 47),
(421, 155, 48),
(422, 155, 70),
(423, 155, 71),
(424, 155, 5),
(425, 155, 72),
(426, 155, 73),
(427, 155, 74),
(428, 155, 75),
(429, 155, 76);

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

--
-- Extraindo dados da tabela `files`
--

INSERT INTO `files` (`id`, `filename`, `user_id`, `created_at`, `category`) VALUES
(1, 'eluabuilder.txt', 1, '2009-10-21 14:55:28', 'User File'),
(3, 'mysql.so', 2, '2009-10-28 18:00:47', 'User File'),
(4, 'help.png', 2, '2009-10-29 13:42:12', 'User File'),
(5, 'hello.lua', 3, '2010-04-06 22:09:36', 'User File'),
(6, 'uart.lua', 8, '2009-11-17 11:27:03', 'User File'),
(14, 'led.lua', 8, '2009-11-25 14:58:36', 'User File'),
(15, 'hello.lua', 8, '2009-11-25 14:58:36', 'User File'),
(16, 'piano.lua', 8, '2009-11-25 15:01:36', 'User File'),
(17, 'pwmled.lua', 8, '2009-11-25 15:01:36', 'User File'),
(18, 'tvbgone.lua', 8, '2009-11-25 15:01:36', 'User File'),
(21, 'bisect.lua', 8, '2009-11-25 15:27:31', 'User File'),
(22, 'index.pht', 8, '2009-11-25 15:32:05', 'User File'),
(23, 'bisect.lua', 1, '2010-02-26 10:03:59', 'User File'),
(24, 'index.pht', 1, '2009-11-26 08:57:55', 'User File'),
(25, 'hangman.lua', 1, '2009-12-16 14:46:47', 'User File'),
(27, 'elua 20090902 1312.sql', 1, '2009-12-16 14:52:04', 'User File'),
(28, 'test.lua', 3, '2009-12-16 16:09:31', 'User File'),
(29, 'pong.lua', 3, '2009-12-16 16:09:31', 'User File'),
(32, 'bisect.lua', 2, '2010-01-14 16:20:54', 'User File'),
(33, 'hangman.lua', 2, '2010-01-14 16:21:26', 'User File'),
(34, 'hangman.lua', 8, '2010-01-28 13:20:13', 'User File'),
(35, 'codes.bin', 1, '2010-02-10 13:44:40', 'User File'),
(36, 'adcpoll.lua', 1, '2010-02-10 14:31:22', 'User File'),
(40, 'snake.lua', 11, '2010-02-13 12:13:12', 'User File'),
(41, 'spaceship.lua', 11, '2010-02-13 12:13:12', 'User File'),
(42, 'tetrives.lua', 11, '2010-02-13 12:13:12', 'User File'),
(43, 'hello.lua', 12, '2010-02-26 16:12:38', 'User File'),
(44, 'lhttpd.lua', 12, '2010-02-26 16:12:38', 'User File'),
(45, 'life.lua', 12, '2010-02-26 16:12:38', 'User File'),
(46, 'tetrives.lua', 12, '2010-02-26 16:12:38', 'User File'),
(47, 'adcpoll.lua', 3, '2010-04-06 22:09:36', 'User File'),
(48, 'adcscope.lua', 3, '2010-04-06 22:09:36', 'User File'),
(49, 'bisect.lua', 3, '2010-02-28 12:11:34', 'User File'),
(50, 'codes.bin', 3, '2010-02-28 12:11:34', 'User File'),
(51, 'dualpwm.lua', 3, '2010-02-28 12:11:34', 'User File'),
(53, 'autorun.lua', 7, '2010-03-08 18:12:26', 'User File'),
(54, 'controleFUZ_03_11r.lua', 13, '2010-03-14 19:14:56', 'User File'),
(55, 'autorun.lua', 13, '2010-03-14 19:24:16', 'User File'),
(56, 'start.lua', 13, '2010-03-14 20:12:41', 'User File'),
(57, 'autorun.lua', 2, '2010-03-15 12:12:24', 'User File'),
(58, 'codes.bin', 13, '2010-03-19 19:31:07', 'User File'),
(59, 'EK-LM3S6965.lua', 13, '2010-03-19 19:31:07', 'User File'),
(60, 'snake.lua', 8, '2010-03-26 16:16:56', 'User File'),
(61, 'mauricio.lua', 14, '2010-03-31 20:37:26', 'User File'),
(62, 'bisect.lua', 14, '2010-03-31 20:43:00', 'User File'),
(63, 'hangman.lua', 14, '2010-03-31 20:43:00', 'User File'),
(64, 'info.lua', 14, '2010-03-31 20:43:00', 'User File'),
(65, 'led.lua', 14, '2010-03-31 20:43:00', 'User File'),
(66, 'tetrives.lua', 14, '2010-03-31 20:43:00', 'User File'),
(67, 'pong.lua', 14, '2010-03-31 20:43:00', 'User File'),
(68, 'pong.lua', 15, '2010-04-02 22:44:45', 'User File'),
(69, 'adcscope.lua', 15, '2010-04-02 22:48:55', 'User File'),
(70, 'EK-LM3S8962.lua', 3, '2010-04-06 22:09:36', 'User File'),
(71, 'hangman.lua', 3, '2010-04-06 22:09:36', 'User File'),
(72, 'info.lua', 3, '2010-04-06 22:09:36', 'User File'),
(73, 'led.lua', 3, '2010-04-06 22:09:36', 'User File'),
(74, 'life.lua', 3, '2010-04-06 22:09:36', 'User File'),
(75, 'morse.lua', 3, '2010-04-06 22:09:36', 'User File'),
(76, 'piano.lua', 3, '2010-04-06 22:09:36', 'User File');

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

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `actived`, `login`, `passwd`, `email`, `name`, `country`, `organization`, `elua_list`, `remarks`, `resume`, `user_hash`) VALUES
(1, 1, 'carlos', '987197373a91dd51d8b7cac435b7921f', 'carlos.deodoro@gmail.com', 'Carlos', 'BR', 'Academic', NULL, 'dfgdfgsd', NULL, ''),
(2, 1, 'vagner', '50f97c79dce57971b2cb3dd00a410ce6', 'vagnernascimento@gmail.com', 'Vagner Nascimento', '', '', NULL, '', NULL, ''),
(3, 1, 'dado', '6dd4070488a411cbbe7f8832af42104a', 'dadosutter@gmail.com', 'Dado Sutter', 'BR', 'Academic', NULL, 'TÃ¡ ficando maneiro !! :)', NULL, NULL),
(4, 1, 'bogdanm', '9f10d3de456af30a3ea79a7d258511e6', 'darkore@gmail.com', 'Bogdan Marinescu', 'RO', 'RAD e Prototyping', NULL, 'Hi there! :)', NULL, NULL),
(5, 1, 'Pedro', 'cc105928c5fc85c25caa937a5b39955d', 'pedrobittencourt87@gmail.com', 'Pedro Bittencourt', 'BR', 'Robotics', NULL, '', NULL, NULL),
(6, 1, 'jsnyder', '3a8ee65cc3a1b3b2eb1751c2f9ae927f', 'jbsnyder@fanplastic.org', 'James Snyder', 'US', 'Academic', NULL, '', NULL, NULL),
(7, 1, 'teofb', '743567feb05dfa00db7d92dd0d6a21a2', 'teo.benjamin@gmail.com', 'Teo', 'BR', 'Military', NULL, '', NULL, NULL),
(8, 1, 'ricardo', '1833675f84a8408515d2d07445aaaec9', 'ricardo.lourival@gmail.com', 'Ricardo Lourival da Rosa', 'BR', 'Military', NULL, '', NULL, NULL),
(9, 1, 'fab13n', 'bc752791602b66fde73d27c8b9a6137c', 'fleutot@gmail.com', 'Fabien Fleutot', 'FR', 'Automotive', NULL, '', NULL, NULL),
(10, 1, 'jbsnyder', '3a8ee65cc3a1b3b2eb1751c2f9ae927f', 'jbsnyder@fanplastic.org', 'James Snyder', 'US', 'Academic', NULL, '', NULL, NULL),
(11, 1, 'ivesnc', '73fd004ad7ac7f9e352e1f42cdef5759', 'ivesncc@gmail.com', 'Ives Negreiros', 'BR', 'Space Exploration', NULL, '', NULL, NULL),
(12, 1, 'fernando', '1383b74663f9403885206260e4c8626f', 'freecky@gmail.com', 'FernandoAraujo', 'BR', 'Academic', NULL, '', NULL, NULL),
(13, 1, 'cemach', '610589e00b8c7324ca3866e878e45d72', 'cesarmamani82@gmail.com', 'Cesar Mamani', 'PE', 'Academic', NULL, '', NULL, NULL),
(14, 1, 'mauricio', '8ee04deaf62f54884dd3af0fd31caf37', 'mauriciobomfim@gmail.com', 'Mauricio Bomfim', 'BR', 'Academic', NULL, '', NULL, NULL),
(15, 1, 'Patrick', 'd8eb125fb23e7da869881fa6aa990280', 'patrick@2h2inc.com', 'Patrick McCavery', 'CA', 'Other', NULL, 'Thanks so much guys!', NULL, NULL);
