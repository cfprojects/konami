<cfoutput>

<form method="post" action="#cgi.script_name#" name="konami">
	
	<fieldset>
	
		<legend>Konami Code Setup</legend>
		<p>
			<label for="konamiEasySetup">Konami Code Options:</label>
			<span class="field">
				<select id="konamiEasySetup" name="konamiEasySetup">
					<option value="konamiRickRolled"<cfif getSetting("konamiEasySetup") is "konamiRickRolled"> selected="selected"</cfif>>Rickroll</option>
					<option value="konamiCornify"<cfif getSetting("konamiEasySetup") is "konamiCornify"> selected="selected"</cfif>>Cornify</option>
					<option value="konamiSharkify"<cfif getSetting("konamiEasySetup") is "konamiSharkify"> selected="selected"</cfif>>Sharkify</option>
					<option value="konamiNinjafy"<cfif getSetting("konamiEasySetup") is "konamiNinjafy"> selected="selected"</cfif>>Ninjafy</option>
					<!---<option value="konamiHoffify"<cfif getSetting("konamiEasySetup") is "konamiHoffify"> selected="selected"</cfif>>Hoffify</option>--->
					<option value="konamiNippleit"<cfif getSetting("konamiEasySetup") is "konamiNippleit"> selected="selected"</cfif>>Nippleit</option>
					<option value="konamiCustom"<cfif getSetting("konamiEasySetup") is "konamiCustom"> selected="selected"</cfif>>Custom URL</option>
					<option value="konamiAlertMode"<cfif getSetting("konamiEasySetup") is "konamiAlertMode"> selected="selected"</cfif>>Show Alert Message</option>
				</select>
			</span>
		</p>
		
		<p>
			<label for="konamiPattern">Custom Pattern</label>
			<span class="hint">Define a custom pattern to be matched to trigger konami code. ex. 38383838 matches the up key 4 times. <a href="../components/plugins/user/konami/admin/charcodes.html" target="_blank">View Char Codes</a></span>
			<span class="field"><input type="text" id="konamiPattern" name="konamiPattern" value="#getSetting("konamiPattern")#" size="50" /></span>
		</p>
		
		<p>
			<label for="konamiCustomURL">Load Custom URL</label>
			<span class="field"><input type="text" id="konamiCustomURL" name="konamiCustomURL" value="#getSetting("konamiCustomURL")#" size="50" /></span>
		</p>
		
		<p>
			<label for="konamiAlertMessage">Alert Message</label>
			<span class="field"><textarea id="konamiAlertMessage" name="konamiAlertMessage" rows="7" cols="70">#HTMLEditFormat(getSetting("konamiAlertMessage"))#</textarea></span>
		</p>
	
	</fieldset>
		
	<p class="actions">
		<input type="submit" class="primaryAction" value="Submit"/>
		<input type="hidden" value="event" name="action" />
		<input type="hidden" value="showKonamiSettings" name="event" />
		<input type="hidden" value="true" name="apply" />
		<input type="hidden" value="konami" name="selected" />
	</p>

</form>

</cfoutput>