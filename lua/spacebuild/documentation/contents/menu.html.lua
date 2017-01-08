<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="bootstrap.css.txt">
    <link rel="stylesheet" type="text/css" href="style.css.txt">
    <script type="text/javascript" src="jquery.js.txt"></script>
    <script type="text/javascript" src="common.js.txt"></script>
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
                <li class="nav-item">
                    <a class="nav-link disabled" href="#">Disabled</a>
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
        <div class="col-sm-12">
            <h1>About</h1>
            <h2>You can find us on<h2>
            <ul class="list-group">
              <li class="list-group-item justify-content-between">
                https://github.com/spacebuild/spacebuild
                <span class="badge badge-info badge-pill">Github</span>
                <span class="badge badge-success badge-pill">Core</span>
              </li>
              <li class="list-group-item justify-content-between">
                https://github.com/spacebuild/sbep
                <span class="badge badge-info badge-pill">Github</span>
                <span class="badge badge-warning badge-pill">Extensions</span>
              </li>
              <li class="list-group-item justify-content-between">
                https://github.com/spacebuild/SB-Addons
                <span class="badge badge-info badge-pill">Github</span>
                <span class="badge badge-warning badge-pill">Extensions</span>
              </li>
              <li class="list-group-item justify-content-between">
                https://steamcommunity.com/sharedfiles/filedetails/?id=693838486
                <span class="badge badge-default badge-pill">Workshop</span>
                <span class="badge badge-success badge-pill">Core</span>
              </li>
              <li class="list-group-item justify-content-between">
                https://steamcommunity.com/sharedfiles/filedetails/?id=695227522
                <span class="badge badge-default badge-pill">Workshop</span>
                <span class="badge badge-warning badge-pill">Extensions</span>
              </li>
              <li class="list-group-item justify-content-between">
                https://discord.gg/3A4dPhD
                <span class="badge badge-primary badge-pill">discord</span>
              </li>
            </ul>
        </div>
    </div>

</div><!-- /.container -->
</body>
</html>