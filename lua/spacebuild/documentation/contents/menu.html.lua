<!DOCTYPE html>
<!--
  ~ Project spacebuild
  ~ Copyright Spacebuild project (http://github.com/spacebuild)
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~  you may not use this file except in compliance with the License.
  ~  You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~  limitations under the License.
  -->

<html>
<head>
    <link rel="stylesheet" type="text/css" href="bootstrap.css.lua">
    <link rel="stylesheet" type="text/css" href="style.css.lua">
    <link rel="stylesheet" type="text/css" href="prism.css.lua">
    <script type="text/javascript" src="jquery.js.lua"></script>
    <script type="text/javascript" src="prism.js.lua"></script>
    <script type="text/javascript" src="common.js.lua"></script>
</head>
<body>
<nav class="navbar navbar-toggleable-md navbar-inverse bg-inverse">
    <a class="navbar-brand" href="#">Spacebuild</a>
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" href="#" id="installed_addons"> <img src="../../materials/icon16/application.png"/>
                Installed addons</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" id="info_and_help"> <img src="../../materials/icon16/box.png"/> Info
                and help</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" id="server_settings"> <img src="../../materials/icon16/wrench.png"/>
                Server settings</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" id="message_log"> <img src="../../materials/icon16/wrench.png"/> Message
                log</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" id="about"> <img src="../../materials/icon16/group.png"/> About</a>
        </li>
    </ul>
</nav>

<div class="container">

    <div id="addon_view" class="view row">
        <h1>Addons</h1>
        <pre><code class="language-lua">
local base = "spacebuild/documentation/"

AddCSLuaFile(base.."menu.lua")
for key, val in pairs(file.Find(base.."contents/*.lua", "LUA")) do
    AddCSLuaFile( base.."contents/"..val )
end
        </code></pre>
    </div>

    <div id="info_view" class="view row" data-spy="scroll" data-target="#nav-info">
        <div class="col-sm-3 sidebar">
            <ul class="nav nav-pills flex-column" id="nav-info">
                <li class="nav-item">
                    <a class="nav-link" href="#info_sb">Spacebuild</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#info_rd">Resource Distribution</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#info_ls">Life Support</a>
                </li>
            </ul>
        </div>
        <div class="col-sm-9 offset-sm-3">
            <h1>Info and help</h1>
            <h2 id="info_sb">Spacebuild</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean egestas metus non semper pharetra. Cras nec neque faucibus, condimentum urna et, volutpat nibh. Nulla luctus, sem feugiat fermentum tempor, lorem neque volutpat turpis, varius varius dolor purus nec arcu. Cras vehicula lacinia faucibus. Nullam ultricies blandit consectetur. Aenean sit amet turpis eu nisl pellentesque sagittis viverra a augue. Quisque sit amet justo purus. Sed nec diam mollis, fringilla elit et, viverra arcu. Cras imperdiet ante eu diam tristique, finibus rutrum arcu faucibus. Aliquam dictum, purus ac aliquet sollicitudin, purus erat feugiat sapien, id egestas augue justo quis sem.</p>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean egestas metus non semper pharetra. Cras nec neque faucibus, condimentum urna et, volutpat nibh. Nulla luctus, sem feugiat fermentum tempor, lorem neque volutpat turpis, varius varius dolor purus nec arcu. Cras vehicula lacinia faucibus. Nullam ultricies blandit consectetur. Aenean sit amet turpis eu nisl pellentesque sagittis viverra a augue. Quisque sit amet justo purus. Sed nec diam mollis, fringilla elit et, viverra arcu. Cras imperdiet ante eu diam tristique, finibus rutrum arcu faucibus. Aliquam dictum, purus ac aliquet sollicitudin, purus erat feugiat sapien, id egestas augue justo quis sem.</p>
            <h2 id="info_rd">Resource distribution</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean egestas metus non semper pharetra. Cras nec neque faucibus, condimentum urna et, volutpat nibh. Nulla luctus, sem feugiat fermentum tempor, lorem neque volutpat turpis, varius varius dolor purus nec arcu. Cras vehicula lacinia faucibus. Nullam ultricies blandit consectetur. Aenean sit amet turpis eu nisl pellentesque sagittis viverra a augue. Quisque sit amet justo purus. Sed nec diam mollis, fringilla elit et, viverra arcu. Cras imperdiet ante eu diam tristique, finibus rutrum arcu faucibus. Aliquam dictum, purus ac aliquet sollicitudin, purus erat feugiat sapien, id egestas augue justo quis sem.</p>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean egestas metus non semper pharetra. Cras nec neque faucibus, condimentum urna et, volutpat nibh. Nulla luctus, sem feugiat fermentum tempor, lorem neque volutpat turpis, varius varius dolor purus nec arcu. Cras vehicula lacinia faucibus. Nullam ultricies blandit consectetur. Aenean sit amet turpis eu nisl pellentesque sagittis viverra a augue. Quisque sit amet justo purus. Sed nec diam mollis, fringilla elit et, viverra arcu. Cras imperdiet ante eu diam tristique, finibus rutrum arcu faucibus. Aliquam dictum, purus ac aliquet sollicitudin, purus erat feugiat sapien, id egestas augue justo quis sem.</p>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean egestas metus non semper pharetra. Cras nec neque faucibus, condimentum urna et, volutpat nibh. Nulla luctus, sem feugiat fermentum tempor, lorem neque volutpat turpis, varius varius dolor purus nec arcu. Cras vehicula lacinia faucibus. Nullam ultricies blandit consectetur. Aenean sit amet turpis eu nisl pellentesque sagittis viverra a augue. Quisque sit amet justo purus. Sed nec diam mollis, fringilla elit et, viverra arcu. Cras imperdiet ante eu diam tristique, finibus rutrum arcu faucibus. Aliquam dictum, purus ac aliquet sollicitudin, purus erat feugiat sapien, id egestas augue justo quis sem.</p>
            <h2 id="info_ls">Life support</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean egestas metus non semper pharetra. Cras nec neque faucibus, condimentum urna et, volutpat nibh. Nulla luctus, sem feugiat fermentum tempor, lorem neque volutpat turpis, varius varius dolor purus nec arcu. Cras vehicula lacinia faucibus. Nullam ultricies blandit consectetur. Aenean sit amet turpis eu nisl pellentesque sagittis viverra a augue. Quisque sit amet justo purus. Sed nec diam mollis, fringilla elit et, viverra arcu. Cras imperdiet ante eu diam tristique, finibus rutrum arcu faucibus. Aliquam dictum, purus ac aliquet sollicitudin, purus erat feugiat sapien, id egestas augue justo quis sem.</p>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean egestas metus non semper pharetra. Cras nec neque faucibus, condimentum urna et, volutpat nibh. Nulla luctus, sem feugiat fermentum tempor, lorem neque volutpat turpis, varius varius dolor purus nec arcu. Cras vehicula lacinia faucibus. Nullam ultricies blandit consectetur. Aenean sit amet turpis eu nisl pellentesque sagittis viverra a augue. Quisque sit amet justo purus. Sed nec diam mollis, fringilla elit et, viverra arcu. Cras imperdiet ante eu diam tristique, finibus rutrum arcu faucibus. Aliquam dictum, purus ac aliquet sollicitudin, purus erat feugiat sapien, id egestas augue justo quis sem.</p>
        </div>
    </div>

    <div id="settings_view" class="view row">
        <h1>Server settings</h1>
    </div>

    <div id="log_view" class="view row">
        <h1>Log</h1>
    </div>

    <div id="about_view" class="view row">
        <div class="col-sm-3 sidebar">
            <ul class="nav nav-pills flex-column" id="nav-about">
                <li class="nav-item">
                    <a class="nav-link" href="#about_talk">Chat/Ask questions</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#about_downloads">Download</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#about_github">Github</a>
                </li>
            </ul>
        </div>
        <div class="col-sm-9 offset-sm-3">
            <h1>About</h1>
            <h2 id="about_talk">Want to chat or ask us questions?</h2>
            <table class="table">
                <thead class="thead-inverse">
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>Link</th>
                        <th>Tags</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th scope="row">1</th>
                        <td>Discord</td>
                        <td>https://discord.gg/3A4dPhD</td>
                        <td><span class="badge badge-primary badge-pill">discord</span></td>
                    </tr>
                </tbody>
            </table>
            <h2 id="about_downloads">You can install us using</h2>
            <table class="table">
                <thead class="thead-inverse">
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Link</th>
                    <th>Tags</th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                        <th scope="row">1</th>
                        <td>Spacebuild release</td>
                        <td>https://steamcommunity.com/sharedfiles/filedetails/?id=693838486</td>
                        <td><span class="badge badge-success badge-pill">Core</span></td>
                    </tr>
                    <tr>
                        <th scope="row">2</th>
                        <td>SBEP release</td>
                        <td>https://steamcommunity.com/sharedfiles/filedetails/?id=695227522</td>
                        <td><span class="badge badge-warning badge-pill">Extensions</span></td>
                    </tr>
                </tbody>
            </table>
            <h2 id="about_github">Github repositories</h2>
            <table class="table">
                <thead class="thead-inverse">
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Link</th>
                    <th>Tags</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th scope="row">1</th>
                    <td>Spacebuild</td>
                    <td>https://github.com/spacebuild/spacebuild</td>
                    <td><span class="badge badge-success badge-pill">Core</span></td>
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td>SBEP</td>
                    <td>https://github.com/spacebuild/sbep</td>
                    <td><span class="badge badge-warning badge-pill">Extensions</span></td>
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td>SB addons</td>
                    <td>https://github.com/spacebuild/SB-Addons</td>
                    <td><span class="badge badge-warning badge-pill">Extensions</span></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

</div><!-- /.container -->
</body>
</html>