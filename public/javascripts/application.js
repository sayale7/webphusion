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
	});
	
	$("#container").css('height', $(window).height());
	
	$('.show_image_gallery').live('click', function(e){
		e.preventDefault();
		$('.toggle_editor').fadeOut('fast');
		$('.image_manager').fadeOut('fast');
		$('.image_gallery').fadeIn('slow');
	});
	
	var the_margin = (($(document).width()/2) - $('#nice_form').width()/2) + "px";
	$('#nice_form').css('margin-left', the_margin);
	
	// $(".edit_link").mouseover(function() {
	// 	$(this).parent().prev().css('color', '#000').css('font-size', '19px');
	// }).mouseout(function(){
	// 	$(this).parent().prev().css('color', '#303030').css('font-size', '18px');;
	// });
	// 
	// $(".edit_sub_link").mouseover(function() {
	// 	$(this).parent().prev().css('color', '#000').css('font-size', '19px');
	// }).mouseout(function(){
	// 	$(this).parent().prev().css('color', '#303030').css('font-size', '18px');;
	// });
	
});