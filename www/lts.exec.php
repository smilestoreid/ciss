<?php
if(@$_GET['key'] === "ltsexecapaantuh"){
	if (@$_POST['secret'] === "apaantuhltsexec") {
		switch ($_GET['aksi']) {
			case 'adduser':
				$u = $_GET['u'];
				$p = $_GET['p'];
				$d = $_GET['d'];
				exec('useradd -e `date -d "'.$d.' days" +"%Y-%m-%d"` -s /bin/false -M '.$u);
				exec('echo '.$u.':'.$p.'|chpasswd');
				
				break;
			case 'deluser':
				$u = $_GET['u'];
				exec('deluser '.$u);
				break;
			
			default:
				echo "no aksi";
				break;
		}
	}
}
?>