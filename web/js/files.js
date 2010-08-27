/**
 * @author carlos
 */
function checked_con_generic()
{
	if ($('#build_con_generic').is(':checked')) {
		$('#build_con_tcp').attr('checked',false);
		$('#build_term').attr('disabled',false);
		if($('#build_term').is(':checked')){
			$('#build_shell').attr('disabled',false);		
			if($('#build_shell').is(':checked')){
				$('#build_xmodem').attr('disabled',false);
			}
		}
	}
	else if(!$('#build_con_tcp').is(':checked')){
		$('#build_term').attr('disabled',true);
		$('#build_shell').attr('disabled',true);
		$('#build_xmodem').attr('disabled',true);
	}
}

function checked_con_tcp()
{
	if ($('#build_con_tcp').is(':checked')) {
		$('#build_con_generic').attr('checked',false);
		$('#build_term').attr('disabled',false);
		if($('#build_term').is(':checked')){
			$('#build_shell').attr('disabled',false);		
			if($('#build_shell').is(':checked')){
				$('#build_xmodem').attr('disabled',false);
			}
		}	
	}	
	else if (!$('#build_con_generic').is(':checked')){
		$('#build_term').attr('disabled',true);
		$('#build_shell').attr('disabled',true);
		$('#build_xmodem').attr('disabled',true);
	}	
}

function checked_term()
{
	if($('#build_term').is(':checked')){
		$('#build_shell').attr('disabled',false);
	}
	else{
		$('#build_shell').attr('disabled',true);
	}
}

function checked_shell()
{
	if ($('#build_shell').is(':checked')) {
		$('#build_xmodem').attr('disabled',false);
	}
	else{
		$('#build_xmodem').attr('disabled',true);
	}
}

function checked_ip()
{
	if ($('#build_uip').is(':checked')) {
		$('#ip_box').show();
		$('#build_dhcpc').attr('disabled',false);
		$('#build_dns').attr('disabled',false);
		if ($('#build_dns').is(':checked')) 
			$('#dns_box').show();
		else 
			$('#dns_box').hide();
	}
	else {
		$('#ip_box').hide();
		$('#dns_box').hide();
		$('#build_dhcpc').attr('disabled',true);
		$('#build_dns').attr('disabled',true);
	}
}

function checked_dns()
{
	if ($('#build_dns').is(':checked')) {
		$('#dns_box').show();
	}
	else{
		$('#dns_box').hide();
	}
}

function basic_mode(){
	$('#tabs').hide();
	$('#basic').attr('disabled',true);
	$('#advanced').attr('disabled',false);
}

function advanced_mode(){
	$('#tabs').show();
	$('#basic').attr('disabled',false);
	$('#advanced').attr('disabled',true);
}

function toogle_check(elem)
{	if(elem.checked)
		elem.checked = false;
	else
		elem.checked = true;
	
}

function effects(id){
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();
	var winH = $(window).height();
	var winW = $(window).width();

	$('#mask').css({'width':maskWidth,'height':maskHeight});	
	$('#mask').fadeIn(250);
	$('#mask').fadeTo("fast",0.8);

	$(id).fadeIn(500);	
}

function file_list(){
	var id = $('#dialog');
	effects(id);
	
	$(id).css('top',  winH/2-$(id).height()/2);
	$(id).css('left', winW/2-$(id).width()/2 + 90);
};

function close_file_list(){
	$('#dialog').hide();
	$('#mask, .window').hide();
}

function msg_download(){
		var id = $('#msg_build_generated');
		effects(id);
		$(id).css('top',  winH/2-$(id).height()/2 - 100);
		$(id).css('left', winW/2-$(id).width()/2);
};

function msg_build_generated(){
	$('#msg_build_generated').hide();
	$('#mask, .window').hide();
}

function generated(){
		var id = $('#generated');
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
		var winH = $(window).height();
		var winW = $(window).width();
	
		$('#mask').css({'width':maskWidth,'height':maskHeight});	
		$('#mask').fadeIn(250);
		$('#mask').fadeTo("fast",0.8);
		$(id).css('top',  winH/2-$(id).height()/2 - 300);
		$(id).css('left', winW/2-$(id).width()/2 - 200);	
		
		$(id).fadeIn(500);	
		
		var pb = document.getElementById("progressBar");
	    pb.innerHTML = '<img src="images/ajax-loader.gif" width="200" height ="40"/>';
	    pb.style.display = '';		
};


