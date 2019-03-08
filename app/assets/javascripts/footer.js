$(document).on('turbolinks:load', function () {

	function siteFooter() {
		
		var siteContent = $('#bodyOfBody');
		var siteContentHeight = siteContent.height();
		var siteContentWidth = siteContent.width();

		var siteContent2 = $('#alternateBody');

		var siteFooter = $('#footer');
		var siteFooterHeight = siteFooter.height();
		var siteFooterWidth = siteFooter.width();
	
		console.log('Content Height = ' + siteContentHeight + 'px');
		console.log('Content Width = ' + siteContentWidth + 'px');
		console.log('Footer Height = ' + siteFooterHeight + 'px');
		console.log('Footer Width = ' + siteFooterWidth + 'px');
		siteContent.css({"margin-bottom" : siteFooterHeight + 50});
		siteContent2.css({"margin-bottom" : siteFooterHeight + 50});
		
	};

	// INITIATE THE FOOTER
	siteFooter();

	// COULD BE SIMPLIFIED FOR THIS PEN BUT I WANT TO MAKE IT AS EASY TO PUT INTO YOUR SITE AS POSSIBLE
	$(window).resize(siteFooter);
});