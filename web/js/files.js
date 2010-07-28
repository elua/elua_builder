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

$(document).ready(function() {
	//seleciona os elementos a com atributo name="view_file_list"
	$('#view_file_list').click(function(e) {
	//cancela o comportamento padrão do link
	e.preventDefault();
	//armazena o atributo href do link
	var id = $(this).attr('href');
	//armazena a largura e a altura da tela
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();
	//Define largura e altura do div#mask iguais ás dimensçoes da tela
	$('#mask').css({'width':maskWidth,'height':maskHeight});
	//efeito de transição
	$('#mask').fadeIn(1000);
	$('#mask').fadeTo("slow",0.8);
	//armazena a largura e a altura da janela
	var winH = $(window).height();
	var winW = $(window).width();
	
	$(id).css('top',  winH/2-$(id).height()/2);
	$(id).css('left', winW/2-$(id).width()/2 + 90);
	//efeito de transição
	$(id).fadeIn(2000);
	});
	//se o botãoo fechar for clicado
	$('.window .close').click(function (e) {
	//cancela o comportamento padrão do link
	e.preventDefault();
	$('#mask, .window').hide();
	});
	//se div#mask for clicado
	$('#mask').click(function () {
	$(this).hide();
	$('.window').hide();
	});
});