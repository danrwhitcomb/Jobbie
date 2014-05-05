function setWaypoints(){
	$('.about_content')
}

(function($) {
    $(function() {
        /*
        Carousel initialization
        */
        $('.jcarousel')
            .jcarousel({
                // Options go here
            });

        /*
         Prev control initialization
         */
        $('.jcarousel-control-prev')
            .on('jcarouselcontrol:active', function() {
                $(this).removeClass('inactive');
            })
            .on('jcarouselcontrol:inactive', function() {
                $(this).addClass('inactive');
            })
            .jcarouselControl({
                // Options go here
                target: '-=1'
            });

        /*
         Next control initialization
         */
        $('.jcarousel-control-next')
            .on('jcarouselcontrol:active', function() {
                $(this).removeClass('inactive');
            })
            .on('jcarouselcontrol:inactive', function() {
                $(this).addClass('inactive');
            })
            .jcarouselControl({
                // Options go here
                target: '+=1'
            });

        /*
         Pagination initialization
         */
        $('.jcarousel-pagination')
            .on('jcarouselpagination:active', 'a', function() {
                $(this).addClass('active');
            })
            .on('jcarouselpagination:inactive', 'a', function() {
                $(this).removeClass('active');
            })
            .jcarouselPagination({
                // Options go here
            });
    });
})(jQuery);

var prev_offset = 0;

$(document).ready(function(){
	$html = $('html, body');
	prev_offset = $html.offset().top

	$('nav_bar').scroll(prev_offset, function(){
		if($('html, body').offset().top > (-1 *$('nav_bar').height - 20)){
			var $nav_bar = $('nav_bar');
			var new_height = 0;
			if(prev_offset > $html.offset().top){
				new_height = $nav_bar.height() - 1;
			} else {
				new_height = $nav_bar.height() + 1;
			}

			$nav_bar.height(new_height);

		}
	});
});


