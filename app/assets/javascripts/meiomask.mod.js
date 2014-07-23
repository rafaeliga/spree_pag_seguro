//
// https://github.com/zejuniortdr/jquery.meiomask.9digito
//
// Mod Leo

$.mask.masks = $.extend($.mask.masks,{
	phone_9digito:{ mask: '(99) 99999-9999'}
});


function procura_no_array(needle, haystack){
	for(var i=0;i<haystack.length;i++){
		if(haystack[i] == needle){
			return i;
		}
	}
	return -1;
}


(function($){
	$(function(){

		var ddds = ['11) 9','12) 9','13) 9','14) 9','15) 9','16) 9','17) 9','18) 9','19) 9','21) 9','22) 9','24) 9','27) 9','28) 9'];

		// SP 11 - 19
		// RJ 21,22,24
		// ES 27,28

		$('input[type=tel]').keydown(function(event) {
			
			if (event.which != 8 && event.which != 46){ //Exclui as teclas de delete
				if( procura_no_array($(this).val().substring(1,6), ddds) >= 0){
					$(this).attr('alt','phone_9digito');
				}else{
					$(this).attr('alt','phone');
				}
				$(this).setMask();
			}
		});
	});

})(jQuery);
