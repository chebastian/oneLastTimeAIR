<?php
	$fileName = $_POST["filename"];
	$xmlContent = $_POST["xmlcontent"];
	$folderName = $_POST["foldername"];
	
	if (!is_dir($folderName . "/"))
	{
		mkdir($folderName . "/", 0755);
	}
	
	$fileHandle = fopen($folderName . $fileName, "w") or die("cant create of open file");
	fwrite($fileHandle, $xmlContent);
	fclose($fileHandle);
	
	$st = "STR"
	echo($st);
?>