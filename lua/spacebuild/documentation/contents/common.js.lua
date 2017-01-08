var previousButton = null;

function addAddon(name, description, version) {
	caf.print(name);
	caf.print(description);
	caf.print(version);
}

function addMessage(time, message){
    caf.print(time);
    caf.print(message);
}

function hideAllViews(){
    $(".view").hide();
    if(previousButton != null){
        previousButton.removeClass("active");
    }
}

function openAddonMenu(){
    hideAllViews();
    previousButton = $( this );
    previousButton.addClass("active");
    var previousView = $("#addon_view");
    previousView.show();
    caf.updateAddons();
}

function openInfoAndHelp(){
    hideAllViews();
    previousButton = $( this );
    previousButton.addClass("active");
    var previousView = $("#info_view");
    previousView.show();
}

function openServerSettings(){
    hideAllViews();
    previousButton = $( this );
    previousButton.addClass("active");
    var previousView = $("#settings_view");
    previousView.show();
}

function openMessageLog(){
    hideAllViews();
    previousButton = $( this );
    previousButton.addClass("active");
    var previousView = $("#log_view");
    previousView.show();
    caf.updateMessages();
}

function openAbout(){
    hideAllViews();
    previousButton = $( this );
    previousButton.addClass("active");
    var previousView = $("#about_view");
    previousView.show();
}

// Register menu hooks
window.onload = function() {
	$("#installed_addons").click(openAddonMenu);
	$("#info_and_help").click(openInfoAndHelp);
	$("#server_settings").click(openServerSettings);
	$("#message_log").click(openMessageLog);
	$("#about").click(openAbout);

	$("#installed_addons").click();
}