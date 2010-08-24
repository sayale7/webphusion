$(document).ready(function(){
	$('a.popup').live('click', function(e) { 
      window.open($(this).attr('href')); 
      e.preventDefault(); 
   });

	$('.ajax_form').live('submit', function(e){	
		e.preventDefault();
		if($(this).find('input:text').val() == ""){
			$(this).find('input:text').css('background-color', '#FFE1E8');
		}else{
			$.post($(this).attr("action"), $(this).serialize(), null, 'script');
		}
	});
	
	$("**:**input[type=text], :input[type='textarea']").live('click', function(){
		$(this).css('background-color', '#FFF');
	});
	
	$('a.data_items').live('click', function(e){
		e.preventDefault();
		if($(this).next().css('display') == 'none'){
			$(this).next().show(50);
		}else{
			$(this).next().hide(50);			
		}
		
	})
	
	$("#container").css('height', $(window).height());
	
});