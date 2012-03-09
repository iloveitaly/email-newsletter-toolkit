<?php
function generateEmbeddedEmail($rawNewsletterContents) {
	$rawNewsletterContents = mb_convert_encoding($rawNewsletterContents, 'HTML-ENTITIES', 'UTF-8');
		
	$documentDOM = new DOMDocument();
	$documentDOM->strictErrorChecking = false;
	$documentDOM->substituteEntities = true;
	$documentDOM->loadHTML($rawNewsletterContents);
	$mainContent = DOMinnerHTML($documentDOM->getElementsByTagName('body')->item(0));
	$mainContent = str_replace("images/", "/email-assets/images/", $mainContent);
	$title = $documentDOM->getElementsByTagName('title')->item(0)->textContent;
		
	// TODO: pull CSS <links/> from the HTML
	$linkList = $documentDOM->getElementsByTagName('link');
	$cssList = array();
		
	for($a = 0; $a < $linkList->length; $a++) {
		$currentItem = $linkList->item($a);
		$linkType = $currentItem->attributes->getNamedItem("type")->value;
			
		if(strstr($linkType, "css") !== FALSE) {
			$cssList[] = $currentItem->attributes->getNamedItem("href")->value;
		}
	}
		
	$template = new View('email/embedded', array(
		'title' => $title,
		'body' => $mainContent,
		'css' => $cssList
	));
		
	echo $template->render();
}
?>