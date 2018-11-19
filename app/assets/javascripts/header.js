$(function() {
    $(window).on("scroll", function() {
        if($(window).scrollTop() > 50) {
            $(".link2").addClass("scrl");
        } else {
            //remove the background property so it comes transparent again (defined in your css)
           $(".link2").removeClass("scrl");
        }
    });
});