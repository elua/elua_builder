function printpreview()
{
	var OLECMDID = 7;
	/* OLECMDID values:
	* 6 - print
	* 7 - print preview
	* 1 - open window
	* 4 - Save As
	*/
	try 
	{
		var PROMPT = 1; // 2 DONTPROMPTUSER
		var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
		
		document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
		WebBrowser1.ExecWB(OLECMDID, PROMPT);
		WebBrowser1.outerHTML = "";
	}
	catch(e)
	{
		window.print();
	}
}

//MÁSCARA DE VALORES

function txtBoxFormat(Campo,mascara, e){
	//pegando o tamanho do texto da caixa de texto com delay de -1 no event
	//ou seja o caractere que foi digitado não será contado.
	strtext = Campo.value
	tamtext = strtext.length

	//pegando o tamanho da mascara
	tammask = mascara.length
	
	//criando um array para guardar cada caractere da m�scara
	arrmask = new Array(tammask)

	//jogando os caracteres para o vetor
	for (var i = 0 ; i < tammask; i++)
	{
		arrmask[i] = mascara.slice(i,i+1)
	}


	key = e.keyCode ? e.keyCode : e.which;
	

	//começando o trabalho sujo
	if (((((arrmask[tamtext] == "#") || (arrmask[tamtext] == "9"))) || (((arrmask[tamtext+1] != "#") || (arrmask[tamtext+1] != "9")))))
	{
		if ((key >= 48 && key <= 57)||(key == 8)||(key == 9) ||(key == 46) ||(key == 13))
		{
			Organiza_Casa(Campo,arrmask[tamtext],key,strtext)
		}
		else
		{
			Detona_Event(Campo,strtext,e)
		}
	}
	else
	{
		if ((arrmask[tamtext] == "A")) 
		{
			charupper = event.valueOf()
			Detona_Event(Campo,strtext,e)
			masktext = strtext + charupper
			Campo.value = masktext
		}
	}
}
function Organiza_Casa(Campo,arrpos,teclapres_key,strtext)
{
	if (((arrpos == "/") || (arrpos == ".") || (arrpos == ",") || (arrpos == ":") || (arrpos == " ") || (arrpos == "-")) && !(teclapres_key == 8))
	{
		separador = arrpos
		masktext = strtext + separador
		Campo.value = masktext
	}
}

function Detona_Event(Campo,strtext,e)
{
	e.returnValue = false
	if (strtext != "") 
	{
		Campo.value = strtext
	}
}

function makeTimeStamp()
{
	newDate = new Date();
	return newDate.getTime()
}


function backFromForm(url)
{
	if(confirm("Deseja realmente voltar? Quaisquer alterações serão perdidas!"))
	{
		window.location.href = url;
	}
}

var dtCh= "/";
var minYear=1900;
var maxYear=2100;

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this;
}

function isDate(dtStr){
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		return false
	}
return true
}

function checkdate(data){
	if (isDate(data)==false){
		return false
	}
    return true
 }


function textCounter(field, countfield, maxlimit) 
{
	if ($(field).value.length > maxlimit) // if too long...trim it!
		$(field).value = $(field).value.substring(0, maxlimit);
	// otherwise, update 'characters left' counter
	else 
		$(countfield).value = maxlimit - $(field).value.length;
}

function compareDates(initial, final)
{
	if(initial != "" && final != "")
	{
		if(parseInt(final) < parseInt(initial))
		{
			return false;
		}
		else
		{
			return true;
		}
	}
}

function checkAndSelectNode(frame,treeName,nodeList,maxAttempts)
{
	if(top.window.frames[frame]){
		if (!maxAttempts)
			maxAttempts = 10;
			
		var oInterval = window.setInterval(function() {
		  if (!top.window.frames[frame].isTreeReady(treeName)) {
		    if(maxAttempts == 0) clearInterval(oInterval); else maxAttempts -= 1;
		  }
		  else {
		    clearInterval(oInterval);
		    top.window.frames[frame].selectNode(treeName,nodeList);
		  }
		}, 200);
	}
}

/*UTF8 = {
    	encode: function(s){
    		for(var c, i = -1, l = (s = s.split("")).length, o = String.fromCharCode; ++i < l;
    			s[i] = (c = s[i].charCodeAt(0)) >= 127 ? o(0xc0 | (c >>> 6)) + o(0x80 | (c & 0x3f)) : s[i]
    		);
    		return s.join("");
    	},
    	decode: function(s){
    		for(var a, b, i = -1, l = (s = s.split("")).length, o = String.fromCharCode, c = "charCodeAt"; ++i < l;
    			((a = s[i][c](0)) & 0x80) &&
    			(s[i] = (a & 0xfc) == 0xc0 && ((b = s[i + 1][c](0)) & 0xc0) == 0x80 ?
    			o(((a & 0x03) << 6) + (b & 0x3f)) : o(128), s[++i] = "")
    		);
    		return s.join("");
    	}
    };
*/

/*fun��o que carrega dados via AJAX.
parametros: 
	url -> url que vai ser chamada;
	div_id -> id do objeto que vai receber o conteudo da chamada da url
	loadObj -> objeto que vai servir de loading enquanto o ajax carrega
	func -> fun��o javascript que vai ser executada ap�s a carga da p�gina.
*/

function PL(url, div_id,loadObj,func)
{
	
	showResponse = function(originalRequest)
	        {
	          div = $(div_id);  
	          fechaLoading(loadObj);
	          div.innerHTML = unescape(originalRequest.responseText);
	        } 	
	
	pars = ""
	abreLoading = function (loadObj){
		if(loadObj)
		{	Element.show(loadObj);}
	}
	fechaLoading = function (loadObj){
		if(loadObj)
		{	Element.hide(loadObj);
			if(func) func.call();
		}
	}

	
	var myAjax = new Ajax.Request(
	          url, 
	          {
	            method: 'get',
	            parameters: pars,
				encoding: 'ISO-8859-1', 
				onLoading: abreLoading(loadObj),
	            onSuccess: showResponse
	          });
}

function ajax_request(url,pars, div_id,loadObj,func)
{
	showResponse = function(originalRequest)
	        {
	          div = $(div_id);  
	          close_loading(loadObj);
	          div.innerHTML = unescape(originalRequest.responseText);
	        } 	
	
	
	open_loading = function (loadObj){
		if(loadObj)
		{	Element.show(loadObj);}
	}
	close_loading = function (loadObj){
		if(loadObj)
		{	Element.hide(loadObj);
			if(func) func.call();
		}
	}
	var myAjax = new Ajax.Request(
	          url, 
	          {
	            method: 'post',
	            parameters: pars,
				encoding: 'UTF-8', 
				onLoading: open_loading(loadObj),
	            onSuccess: showResponse
	          });
}

function showHide(element,contentButtonID,contentOpen,ContentClose)
{
	if($(element).style.display == 'none')
	{
		Element.show(element);
		if(contentButtonID)
			$(contentButtonID).innerHTML = contentOpen;
	}
	else
	{
		Element.hide(element);
		if(contentButtonID)
			$(contentButtonID).innerHTML = ContentClose;
	}
}

function showLoading()
{
	Element.show('popLoading');
}

function closeLoading()
{
	Element.hide('popLoading');
}


/**
*
*  URL encode / decode
*  http://www.webtoolkit.info/
*
**/

var Url = {

    // public method for url encoding
    encode : function (string) {
        return escape(this._utf8_encode(string));
    },

    // public method for url decoding
    decode : function (string) {
        return this._utf8_decode(unescape(string));
    },

    // private method for UTF-8 encoding
    _utf8_encode : function (string) {
        string = string.replace(/\r\n/g,"\n");
        var utftext = "";

        for (var n = 0; n < string.length; n++) {

            var c = string.charCodeAt(n);

            if (c < 128) {
                utftext += String.fromCharCode(c);
            }
            else if((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            }
            else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }

        }

        return utftext;
    },

    // private method for UTF-8 decoding
    _utf8_decode : function (utftext) {
        var string = "";
        var i = 0;
        var c = c1 = c2 = 0;

        while ( i < utftext.length ) {

            c = utftext.charCodeAt(i);

            if (c < 128) {
                string += String.fromCharCode(c);
                i++;
            }
            else if((c > 191) && (c < 224)) {
                c2 = utftext.charCodeAt(i+1);
                string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                i += 2;
            }
            else {
                c2 = utftext.charCodeAt(i+1);
                c3 = utftext.charCodeAt(i+2);
                string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                i += 3;
            }

        }

        return string;
    }

}


/*
 * Date Format 1.2.2
 * (c) 2007-2008 Steven Levithan <stevenlevithan.com>
 * MIT license
 * Includes enhancements by Scott Trenda <scott.trenda.net> and Kris Kowal <cixar.com/~kris.kowal/>
 *
 * Accepts a date, a mask, or a date and a mask.
 * Returns a formatted version of the given date.
 * The date defaults to the current date/time.
 * The mask defaults to dateFormat.masks.default.
 */
var dateFormat = function () {
	var	token = /d{1,4}|m{1,4}|yy(?:yy)?|([HhMsTt])\1?|[LloSZ]|"[^"]*"|'[^']*'/g,
		timezone = /\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g,
		timezoneClip = /[^-+\dA-Z]/g,
		pad = function (val, len) {
			val = String(val);
			len = len || 2;
			while (val.length < len) val = "0" + val;
			return val;
		};

	// Regexes and supporting functions are cached through closure
	return function (date, mask, utc) {
		var dF = dateFormat;

		// You can't provide utc if you skip other args (use the "UTC:" mask prefix)
		if (arguments.length == 1 && (typeof date == "string" || date instanceof String) && !/\d/.test(date)) {
			mask = date;
			date = undefined;
		}

		// Passing date through Date applies Date.parse, if necessary
		date = date ? new Date(date) : new Date();
		if (isNaN(date)) throw new SyntaxError("invalid date");

		mask = String(dF.masks[mask] || mask || dF.masks["default"]);

		// Allow setting the utc argument via the mask
		if (mask.slice(0, 4) == "UTC:") {
			mask = mask.slice(4);
			utc = true;
		}

		var	_ = utc ? "getUTC" : "get",
			d = date[_ + "Date"](),
			D = date[_ + "Day"](),
			m = date[_ + "Month"](),
			y = date[_ + "FullYear"](),
			H = date[_ + "Hours"](),
			M = date[_ + "Minutes"](),
			s = date[_ + "Seconds"](),
			L = date[_ + "Milliseconds"](),
			o = utc ? 0 : date.getTimezoneOffset(),
			flags = {
				d:    d,
				dd:   pad(d),
				ddd:  dF.i18n.dayNames[D],
				dddd: dF.i18n.dayNames[D + 7],
				m:    m + 1,
				mm:   pad(m + 1),
				mmm:  dF.i18n.monthNames[m],
				mmmm: dF.i18n.monthNames[m + 12],
				yy:   String(y).slice(2),
				yyyy: y,
				h:    H % 12 || 12,
				hh:   pad(H % 12 || 12),
				H:    H,
				HH:   pad(H),
				M:    M,
				MM:   pad(M),
				s:    s,
				ss:   pad(s),
				l:    pad(L, 3),
				L:    pad(L > 99 ? Math.round(L / 10) : L),
				t:    H < 12 ? "a"  : "p",
				tt:   H < 12 ? "am" : "pm",
				T:    H < 12 ? "A"  : "P",
				TT:   H < 12 ? "AM" : "PM",
				Z:    utc ? "UTC" : (String(date).match(timezone) || [""]).pop().replace(timezoneClip, ""),
				o:    (o > 0 ? "-" : "+") + pad(Math.floor(Math.abs(o) / 60) * 100 + Math.abs(o) % 60, 4),
				S:    ["th", "st", "nd", "rd"][d % 10 > 3 ? 0 : (d % 100 - d % 10 != 10) * d % 10]
			};

		return mask.replace(token, function ($0) {
			return $0 in flags ? flags[$0] : $0.slice(1, $0.length - 1);
		});
	};
}();

// Some common format strings
dateFormat.masks = {
	"default":      "ddd mmm dd yyyy HH:MM:ss",
	shortDate:      "m/d/yy",
	mediumDate:     "mmm d, yyyy",
	longDate:       "mmmm d, yyyy",
	fullDate:       "dddd, mmmm d, yyyy",
	shortTime:      "h:MM TT",
	mediumTime:     "h:MM:ss TT",
	longTime:       "h:MM:ss TT Z",
	isoDate:        "yyyy-mm-dd",
	isoTime:        "HH:MM:ss",
	isoDateTime:    "yyyy-mm-dd'T'HH:MM:ss",
	isoUtcDateTime: "UTC:yyyy-mm-dd'T'HH:MM:ss'Z'"
};

// Internationalization strings
dateFormat.i18n = {
	dayNames: [
		"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat",
		"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
	],
	monthNames: [
		"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
		"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
	]
};

// For convenience...
Date.prototype.format = function (mask, utc) {
	return dateFormat(this, mask, utc);
};


/* This script and many more are available free online at
The JavaScript Source!! http://javascript.internet.com
Copyright 1999 Idocs, Inc. http://www.idocs.com
Distribute this script freely but keep this notice in place */

function numbersonly(myfield, e, dec) {
  var key;
  var keychar;

  if (window.event)
    key = window.event.keyCode;
  else if (e)
    key = e.which;
  else
    return true;
  keychar = String.fromCharCode(key);

  // control keys
  if ((key==null) || (key==0) || (key==8) || (key==9) || (key==13) || (key==27) || (key == 46))
    return true;

  // numbers
  else if ((("0123456789").indexOf(keychar) > -1))
    return true;

  // decimal point jump
  else if (dec && (keychar == ".")) {
    myfield.form.elements[dec].focus();
    return false;
  } else
    return false;
}