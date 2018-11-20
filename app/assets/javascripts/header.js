$(function() {
    $(window).on("scroll", function() {
        if($(window).scrollTop() > 50) {
            $(".link2").addClass("scrl");
            $(".logo_image").addClass("scrl_logo");
        } else {
            //remove the background property so it comes transparent again (defined in your css)
           $(".link2").removeClass("scrl");
           $(".logo_image").removeClass("scrl_logo");
        }
    });
});