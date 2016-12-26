--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 26/12/2016
-- Time: 12:44
-- To change this template use File | Settings | File Templates.
--
local SPACEBUILD = SPACEBUILD

local menuCss = [===[
    h1 {
        color:red;
    }
]===]

local menuJs = [===[
window.onload = function(){
	caf.print("test");


}

var addons = {}

function updateAddon(name, description, version) {
	var addon = addons[name] || {}
	addon.name = name;
	addon.description = description;
	addon.version = version;
	addons[name] = addon
	caf.print(name);
	caf.print(description);
	caf.print(version);
	caf.print(addons)
}
]===]

local menuHtml = [===[
    <!DOCTYPE html>
    <html>
    <head>
    <link rel="stylesheet" type="text/css" href="css.txt">
            <script type="text/javascript" src="js.txt"></script>
            </head>
            <body>

            <h1>My First Heading</h1>

    <p>My first paragraph.</p>

    </body>
    </html>
]===]

file.Write( "sb/menu.txt", menuHtml)

file.Write( "sb/css.txt", menuCss)

file.Write( "sb/js.txt", menuCss)

file.Append( "sb/menu.txt", "<!--"..SPACEBUILD.version:fullVersion().."-->" )
file.Append( "sb/css.txt", "/*"..SPACEBUILD.version:fullVersion().."*/" )
file.Append( "sb/js.txt", "/*"..SPACEBUILD.version:fullVersion().."*/" )

