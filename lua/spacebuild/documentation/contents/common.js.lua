/*
 * Project spacebuild
 * Copyright Spacebuild project (http://github.com/spacebuild)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 *  limitations under the License.
 */

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