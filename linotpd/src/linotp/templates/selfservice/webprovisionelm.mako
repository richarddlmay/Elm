# -*- coding: utf-8 -*-
<!--
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
-->
<h1>${_("Activate Two-Factor Authentication")}</h1>

<div id='elmform'>
	<form class="cmxform" name='myForm'> 
		<fieldset>
			<ol id="provisionElmInstall">
				<li>Install the appropriate authenticator application on your mobile device:
					<ul>
						<li>Android, iOS or Blackberry OS 7 and earlier: <a href='m.google.com/authenticator' target='extern'>Google Authenticator</a></li>
						<li>Blackberry OS 10: <a href='http://appworld.blackberry.com/webstore/content/76023/?lang=en' target='extern'>Duo Mobile</a></li>
						<li>Windows Phone: <a href='go.microsoft.com/fwlink/?LinkId=279710' target='extern'>Microsoft Authenticator</a></li>
					</ul>
					Alternatively, if you are viewing this page on your desktop, you can scan the following QR code with your mobile device:
					<div id="accordion">
						<h3>QR Code</h3>
						<div>
							<span id=qr_code_download></span>
						</div>
					</div>
				</li>
				<li>Choose a four-digit PIN code for the new token. Your PIN is required whenever you are asked for an access code - for example, if your PIN
					is 1234 and your one-time-password is 000000, you would enter '1234000000'.
					<table>
						<tr><td><span id=error_pin></span></td></tr>
						<tr>
							<!--[if lte IE 9]>
								<td><label class="ie-label" for="pin1">PIN</label></td>
							<![endif]-->
							<td><input id="pin1" autocomplete="off" type="password" placeholder="PIN" size="10" maxlength="4" tabindex="1" class="text ui-widget-content ui-corner-all"/></td>
						</tr>
						<tr>
							<!--[if lte IE 9]>
								<td><label class="ie-label" for="pin2">Confirm PIN</label></td>
							<![endif]-->						
							<td><input id="pin2" autocomplete="off" type="password" placeholder="Confirm PIN" size="10" maxlength="4" tabindex="1" onkeyup="checkpins('pin1', 'pin2');" class="text ui-widget-content ui-corner-all"/></td>
						</tr>
					</table>
					<button class='action-button' onclick="elmProvision(); return false;">
						${_("Activate token")}
					</button>
				</li>
			</ol>
			
			<ol id="provisionElmResultDiv" start="3">
				<li>${_("Token")} ${_("successfully created!")}
					<p>${_("If you are viewing this site on the same device as your authenticator app, click the link below to activate your code:")}
						 <a id=google_link>${_("Install token")}</a>
					</p>
					<p>${_("Alternatively, scan the QR code below with your authenticator device.")}</p>
					<div id="accordion2">
						<h3>QR Code</h3>
						<div>
							<span id=google_qr_code></span>
						</div>
					</div>
				</li>
				<li>Enter your PIN followed by a one-time password generated by your authenticator app to complete setup. For example, if your PIN
					is 1234 and your one-time-password is 000000, you would enter '1234000000'. Note that your authenticator <strong>will not work</strong>
					on Single Sign On pages until you complete this step.
					
					<table>
						<tr><td><span id=error_otp></span></td></tr>
						<tr>
							<!--[if lte IE 9]>
								<td><label class="ie-label" for="otp">Access Code</label></td>
							<![endif]-->
							<td><input id="otp" autocomplete="off" type="password" placeholder="Access Code" size="10" maxlength="10" tabindex="1" class="text ui-widget-content ui-corner-all"/></td>
						</tr>
					</table>
					<button class='action-button' onclick="elmProvisionFinal(); return false;">
						${_("Finish installation")}
					</button>
					<input type=hidden id=token_serial value="">
				</li>
			</ol>
			<div id="provisionElmComplete">
				<p>Your token has now been activated. Single Sign-On pages will now prompt you for an access code when you attempt to login.</p>
			</div>
		</fieldset>
		
	</form>
</div>

<script>
		$('#provisionElmInstall').show();
	   	$('#provisionElmResultDiv').hide();
		$('#provisionElmComplete').hide();
	   	$('#qr_code_download').show();
	   	$('#qr_code_download').html(generate_qrcode(10,"https://mfa-test.bsp.ox.ac.uk/selfservice/authenticator.html"));
		$(function() {
			$("#accordion").accordion({
				'collapsible' : true,
				'active' : false
			});
		});
		$(function() {
			$("#accordion2").accordion({
				'collapsible' : true,
				'active' : false
			});
		});
</script>
