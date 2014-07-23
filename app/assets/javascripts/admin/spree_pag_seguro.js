//= require meiomask
//= require meiomask.mod

(function($){
	$(function(){
		$("input[id$='cpf']").attr("alt", "cpf");
		$('input:text').setMask();
	});
})(jQuery);