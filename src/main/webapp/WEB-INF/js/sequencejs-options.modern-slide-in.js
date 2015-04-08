$(document).ready(function(){
    var options = {
        nextButton: true,
        prevButton: true,
        pagination: true,
        animateStartingFrameIn: true,
        autoPlay: true,
        autoPlayDelay: 3000,
        preloader: true,
        preloadTheseFrames: [1],
        preloadTheseImages: [
            "images/model6.jpg",
            "images/model10.jpg",
            "images/model4.jpg"
        ]
    };
    
    var mySequence = $("#sequence").sequence(options).data("sequence");
});