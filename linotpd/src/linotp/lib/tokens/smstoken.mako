# -*- coding: utf-8 -*-
<%doc>
 *
 *   LinOTP - the open source solution for two factor authentication
 *   Copyright (C) 2010 - 2014 LSE Leading Security Experts GmbH
 *
 *   This file is part of LinOTP server.
 *
 *   This program is free software: you can redistribute it and/or
 *   modify it under the terms of the GNU Affero General Public
 *   License, version 3, as published by the Free Software Foundation.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Affero General Public License for more details.
 *
 *   You should have received a copy of the
 *              GNU Affero General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *
 *    E-mail: linotp@lsexperts.de
 *    Contact: www.linotp.org
 *    Support: www.lsexperts.de
 *
 * contains the sms token web interface
</%doc>


%if c.scope == 'config.title' :
${_("SMS OTP Token")}
%endif


%if c.scope == 'config' :
<!-- #################### SMS Provider ################### -->
<script>
/*
 * 'typ'_get_config_val()
 *
 * this method is called, when the token config dialog is opened
 * - it contains the mapping of config entries to the form id
 * - according to the Config entries, the form entries will be filled
 *
 */
function sms_get_config_val(){
	var ret = {};
	ret['SMSProvider'] 			= 'c_sms_provider';
	ret['SMSProviderConfig'] 	= 'c_sms_provider_config';
	ret['SMSProviderTimeout'] 	= 'c_sms_timeout';
	ret['SMSBlockingTimeout'] 	= 'c_sms_blocking';
	return ret;

}
/*
 * 'typ'_get_config_params()
 *
 * this method is called, when the token config is submitted
 * - it will return a hash of parameters for system/setConfig call
 *
 */
function sms_get_config_params(){
	var ret = {};
	ret['SMSProvider'] 			= $('#c_sms_provider').val();
	ret['SMSProviderConfig'] 	= $('#c_sms_provider_config').val();
	ret['SMSProviderConfig.type'] = 'password';
	ret['SMSProviderTimeout'] 	= $('#c_sms_timeout').val();
	ret['SMSBlockingTimeout'] 	= $('#c_sms_blocking').val();
	return ret;
}

$(document).ready(function () {
    $("#form_smsconfig").validate();
});
 </script>

<form class="cmxform" id="form_smsconfig"><fieldset>
<legend>${_("SMS Provider Config")}</legend>
<table><tr>
	<td><label for="c_sms_provider">${_("SMS Provider")}</label>: </td>
	<td><input type="text" name="sms_provider" class="required"  id="c_sms_provider" size="37" maxlength="80"></td>
</tr><tr>
	<td><label for='c_sms_provider_config'>${_("SMS Provider Config")}</label>: </td>
	<td><textarea name="sms_provider_config" class="required"  id="c_sms_provider_config" cols='35' rows='6' maxlength="400"> </textarea></td>
</tr><tr>
	<td><label for='c_sms_timeout'>${_("SMS Timeout")}</label>: </td>
	<td><input type="text" name="sms_timeout" class="required"  id="c_sms_timeout" size="5" maxlength="5"></td>
</tr><tr>
	<td><label for='c_sms_blocking'>${_("Time between SMS (sec.)")}</label>: </td>
	<td><input type="text" name="sms_blocking" class="required"  id="c_sms_blocking" size="5" maxlength="5" value"30"></td>
</tr></table>
</fieldset></form>

%endif


%if c.scope == 'enroll.title' :
${_("SMS OTP")}
%endif

%if c.scope == 'enroll' :
<script>

function sms_enroll_setup_defaults(config){
	// in case we enroll sms otp, we get the mobile number of the user
	mobiles = get_selected_mobile();
	$('#sms_phone').val($.trim(mobiles[0]));
}

/*
 * 'typ'_get_enroll_params()
 *
 * this method is called, when the token  is submitted
 * - it will return a hash of parameters for admin/init call
 *
 */
function sms_get_enroll_params(){
    var params = {};

	params['phone'] 		= 'sms';
    // phone number
    params['phone'] 		= $('#sms_phone').val();
    params['description'] 	=  $('#sms_phone').val() + " " + $('#enroll_sms_desc').val();
    //params['serial'] 		= create_serial('LSSM');

    jQuery.extend(params, add_user_data());

    return params;
}
</script>

<p>${_("Please enter the mobile phone number for the SMS token")}</p>
<table><tr>
	<td><label for="sms_phone">${_("phone number")}</label></td>
	<td><input type="text" name="sms_phone" id="sms_phone" value="" class="text ui-widget-content ui-corner-all"></td>
</tr><tr>
    <td><label for="enroll_sms_desc" id='enroll_sms_desc_label'>${_("Description")}</label></td>
    <td><input type="text" name="enroll_sms_desc" id="enroll_sms_desc" value="webGUI_generated" class="text" /></td>
</tr>
</table>

% endif



%if c.scope == 'selfservice.title.enroll':
${_("Register SMS")}
%endif


%if c.scope == 'selfservice.enroll':

<%!
	from linotp.lib.user import getUserPhone
%>
<%
	try:
		phonenumber = getUserPhone(c.authUser, 'mobile')
		if phonenumber == None or len(phonenumber) == 0:
			 phonenumber = ''
	except Exception as e:
		phonenumber = ''
%>

<script>
	jQuery.extend(jQuery.validator.messages, {
		required:  "${_('required input field')}",
		minlength: "${_('minimum length must be greater than 10')}",
	});

	jQuery.validator.addMethod("phone", function(value, element, param){
        return value.match(/^[+0-9\/\ ]+$/i);
    }, '${_("Please enter a valid phone number. It may only contain numbers and + or /.")}' );

	$('#form_register_sms').validate({
        rules: {
            sms_mobilephone: {
                required: true,
                minlength: 10,
                number: false,
                phone: true
            }
        }
	});

function self_sms_get_param()
{
	var urlparam = {};
	var mobilephone = $('#sms_mobilephone').val();


	urlparam['type'] 		= 'sms';
	urlparam['phone']		= mobilephone;
	urlparam['description'] = mobilephone + '_' + $("#sms_self_desc").val();

	return urlparam;
}

function self_sms_clear()
{
	return true;
}
function self_sms_submit(){

	var ret = false;

	if ($('#form_register_sms').valid()) {
		var params =  self_sms_get_param();
		enroll_token( params );
		//self_sms_clear();
		ret = true;
	} else {
		alert('${_("Form data not valid.")}');
	}
	return ret;
}

</script>

<h1>${_("Register your SMS OTP Token / mobileTAN")}</h1>
<div id='register_sms_form'>
	<form class="cmxform" id='form_register_sms'>
	<fieldset>
		<table>
		<tr>
		<td><label for='sms_mobilephone'>${_("Your mobile phone number")}</label></td>
		<td><input id='sms_mobilephone'
					name='sms_mobilephone'
					class="required ui-widget-content ui-corner-all"
					value='${phonenumber}'/>
		</td>
		</tr>
		<tr>
		    <td><label for="sms_self_desc" id='sms_self_desc_label'>${_("Description")}</label></td>
		    <td><input type="text" name="sms_self_desc" id="sms_self_desc" value="self_registered"; class="text" /></td>
		</tr>
        </table>
        <button class='action-button' id='button_register_sms' onclick="self_sms_submit();">${_("register SMS Token")}</button>
    </fieldset>
    </form>
</div>
% endif


