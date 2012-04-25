$(function(){
    //$('#topbar').dropdown();
    var _url = window.location.href;
    if (_url.match(/user/)) {
        $('.nav li:eq(1)').addClass('active');
    } else if (_url.match(/map/)) {
        $('.nav li:eq(2)').addClass('active');
    } else {
        $('.nav li:eq(0)').addClass('active');
    }
});
