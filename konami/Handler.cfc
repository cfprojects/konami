<cfcomponent extends="BasePlugin">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		
			<cfset setManager(arguments.mainManager) />
			<cfset setPreferencesManager(arguments.preferences) />
			<cfset setPackage("com/visual28/mango/plugins/konami") />
			
			<cfset initSettings(
					konamiEasySetup = "konamiRickRolled",
					konamiCustomURL = "",
					konamiAlertMessage = "",
					konamiPattern = ""
				) />
		
		<cfreturn this/>
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		
		<cfreturn "plugin activated. Would you like to <a href='generic_settings.cfm?event=showKonamiSettings&amp;owner=konami&amp;selected=showKonamiSettings'>configure it now</a>" />
	</cffunction>
	
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<cfreturn "Deactivated Plugin: Was it something I said? Have problems with it? For support go to <a href='http://www.visual28.com'>www.visual28.com</a>" />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />		
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />

			<cfset var konamiJS = "" />
			<cfset var data =  "" />
			<cfset var eventName = arguments.event.name />
			<cfset var pod = "" />
			<cfset var link = "" />
			<cfset var page = "" />
			
			
			<cfif eventName EQ "beforeHtmlHeadEnd">	
				<cfsavecontent variable="konamiJS"><cfoutput>
<script type="text/javascript" src="http://konami-js.googlecode.com/svn/trunk/konami.js"></script>
<script type="text/javascript">
	konami = new Konami()
	<cfif getSetting("konamiPattern") neq "">
	konami.pattern = "#getSetting('konamiPattern')#"</cfif>
	<cfif getSetting("konamiEasySetup") eq "konamiRickRolled">
	konami.load("http://www.yougotrickrolled.com");
	<cfelseif getSetting("konamiEasySetup") eq "konamiCustom">
	konami.load("#getSetting('konamiCustomURL')#");
	<cfelseif getSetting("konamiEasySetup") eq "konamiAlertMode">
	konami.code = function() {
		alert("#getSetting('konamiAlertMessage')#")
		}
	konami.load()
	</cfif>
	<cfif getSetting("konamiEasySetup") eq "konamiCornify">
	konami.code = function() {
		$.getScript('http://www.cornify.com/js/cornify.js',function(){
			cornify_add();
			$(document).keydown(cornify_add);
		}); 
	}
	konami.load()
	</cfif>
	<cfif getSetting("konamiEasySetup") eq "konamiSharkify">
	konami.code = function() {
		$.getScript('http://www.iamcal.com/sharkify/sharkify.js',function(){
			sharkify_add();
			$(document).keydown(sharkify_add);
		}); 
	}
	konami.load()
	</cfif>
	<cfif getSetting("konamiEasySetup") eq "konamiNinjafy">
	konami.code = function() {
		$.getScript('http://ninjafy.com/js/ninjafy.js',function(){
			ninjafy_add();
			$(document).keydown(ninjafy_add);
		}); 
	}
	konami.load()
	</cfif>
	<cfif getSetting("konamiEasySetup") eq "konamiHoffify">
	konami.code = function() {
		$.getScript('http://hoffify.co.uk/hoffify.js',function(){
			hoffify_add();
			$(document).keydown(hoffify_add);
		}); 
	}
	konami.load()
	</cfif>
	<cfif getSetting("konamiEasySetup") eq "konamiNippleit">
	konami.code = function() {
		$.getScript('http://www.nippleit.com/js/nippleit.js',function(){
			nipple_add();
			$(document).keydown(nipple_add);
		}); 
	}
	konami.load()
	</cfif>
</script>
				</cfoutput></cfsavecontent>
				
				<cfset data = arguments.event.outputData />
				<cfset data = data & konamiJS />
				<cfset arguments.event.outputData = data />
			
			
			
			
			<!--- admin nav event --->
			<cfelseif eventName EQ "settingsNav">
				<cfset link = structnew() />
				<cfset link.owner = "konami">
				<cfset link.page = "settings" />
				<cfset link.title = "konami" />
				<cfset link.eventName = "showKonamiSettings" />
				<cfset arguments.event.addLink(link)>
			
			
			<!--- admin event --->
			<cfelseif eventName EQ "showKonamiSettings" AND getManager().isCurrentUserLoggedIn()>
				<cfset data = arguments.event.data />				
				<cfif structkeyexists(data.externaldata,"apply")>
					
					<cfset setSettings(
							konamiEasySetup = data.externaldata.konamiEasySetup,
							konamiCustomURL = data.externaldata.konamiCustomURL,
							konamiAlertMessage = data.externaldata.konamiAlertMessage,
							konamiPattern = data.externaldata.konamiPattern
						) />
					
					<cfset persistSettings() />
					<cfset data.message.setstatus("success") />
					<cfset data.message.setType("settings") />
					<cfset data.message.settext("Konami Code Updated") />
				</cfif>
				
				<cfsavecontent variable="page">
					<cfinclude template="admin/settingsForm.cfm">
				</cfsavecontent>
					
					<!--- change message --->
					<cfset data.message.setTitle("Konami Code Settings") />
					<cfset data.message.setData(page) />
			
			<cfelseif eventName EQ "getPodsList"><!--- no content, just title and id --->
				<cfset pod = structnew() />
				<cfset pod.title = "Konami" />
				<cfset pod.id = "konami" />
				<cfset arguments.event.addPod(pod)>
			</cfif>
		
		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>