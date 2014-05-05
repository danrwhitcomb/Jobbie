
function scrollToTop(){
	$('html, body').animate({
    	scrollTop: $(".content").offset().top - $('nav').outerHeight()
 	}, 200);
}

function scrollToAbout(){
	$('html, body').animate({
    	scrollTop: $(".about_content").offset().top - $('nav').outerHeight()
 	}, 200);
}

function scrollToTeam(){
	$('html, body').animate({
    	scrollTop: $(".team_content").offset().top - $('nav').outerHeight()
 	}, 200);
}

function scrollToDownload(){
	$('html, body').animate({
    	scrollTop: $(".download_content").offset().top - $('nav').outerHeight()
 	}, 200);
}
