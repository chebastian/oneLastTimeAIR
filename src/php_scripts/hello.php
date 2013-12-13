<?php
	$dom = new DOMDocument();
	$dom->load("../src/php_scripts/write.xml");
	
	$root = $root->documentElement();
	$elem = $dom->createElement("Created");
	$root->appendChlid($elem);
	$root->add;
	
	$dom->saveXML();
  ?>