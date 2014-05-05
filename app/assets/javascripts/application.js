// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .



var display = false;

var minicolor;
minicolor = function () {

    $('#minicolor').each(function () {
        $(this).minicolors({defaultValue: $(this).attr('data_defaultValue')});
    });
};

$(document).ready(minicolor);
$(document).on('page:load', minicolor);

/*
function show_sign_form() {
    if (display == false) {
        document.getelementbyid("sign_in_form").display='block';
        display == true;
    } else if (display == true) {
        document.getelementbyid("sign_in_form").display='none';
        display == false;
    }
}*/
