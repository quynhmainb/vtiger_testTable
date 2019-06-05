<?php
$Vtiger_Utils_Log = true;
require_once 'include/utils/utils.php';
require_once 'include/utils/CommonUtils.php';

require_once 'includes/Loader.php';
vimport('includes.runtime.EntryPoint');

global $adb;

$adb->pquery('CREATE TABLE `table_block` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `contactid` int(19) NOT NULL,
                `hoten` VARCHAR(50) NULL,
                `ngaysinh` DATE NULL,
                `gioitinh` VARCHAR(3) NULL,
                `quanhe` VARCHAR(50) NULL,
                `nghenghiep` VARCHAR(50) NULL,
                PRIMARY KEY (`id`))',array());
