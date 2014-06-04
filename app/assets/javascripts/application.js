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
//= require bootstrap.min
//= require jquery.tablesorter.min
//= require jquery.nicescroll
//= require jquery.dcjqaccordion.2.7
//= require_tree .
//= require DT_bootstrap
//= require jquery.dataTables

var minicolor;
minicolor = function () {

    $('#minicolor').each(function () {
        $(this).minicolors({
            defaultValue: $(this).attr('data_defaultValue')
        });
    });
};

$(document).ready(minicolor);
$(document).on('page:load', minicolor);

var tablesort;
tablesort = function () {
    $("#myTable").tablesorter();
};

$(document).ready(tablesort);
$(document).on('page:load', tablesort);

$(document).ready(function () {
    $('#example').dataTable();
});
