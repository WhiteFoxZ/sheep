<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>jQueryMobile - DateBox Demos</title>
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
    <link rel="stylesheet" href="http://cdn.jtsage.com/datebox/1.4.5/jqm-datebox-1.4.5.min.css" />
    <link type="text/css" href="css/demos.css" rel="stylesheet" />
    <!-- NOTE: Script load order is significant! -->
    <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.1.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <script type="text/javascript" src="http://cdn.jtsage.com/external/jquery.mousewheel.min.js"></script>
    <script type="text/javascript" src="http://dev.jtsage.com/jQM-DateBox/js/doc.js"></script>
    <script type="text/javascript" src="http://cdn.jtsage.com/datebox/1.4.5/jqm-datebox-1.4.5.core.min.js"></script>
    <script type="text/javascript" src="http://cdn.jtsage.com/datebox/1.4.5/jqm-datebox-1.4.5.mode.calbox.min.js"></script>
    <script type="text/javascript" src="http://cdn.jtsage.com/datebox/1.4.5/jqm-datebox-1.4.5.mode.datebox.min.js"></script>
    <script type="text/javascript" src="http://cdn.jtsage.com/datebox/1.4.5/jqm-datebox-1.4.5.mode.flipbox.min.js"></script>
    <script type="text/javascript" src="http://cdn.jtsage.com/datebox/1.4.5/jqm-datebox-1.4.5.mode.slidebox.min.js"></script>
    <script type="text/javascript" src="http://cdn.jtsage.com/datebox/1.4.5/jqm-datebox-1.4.5.mode.customflip.min.js"></script>
    <script type="text/javascript" src="http://cdn.jtsage.com/datebox/i18n/jqm-datebox.lang.utf8.js"></script>
    <script type="text/javascript">
    jQuery.extend(jQuery.mobile,
    {
      ajaxEnabled: false
    });
    </script>
  </head>
  <body>
    <div data-role="page" id="main">
      <div data-role="header" data-position="fixed">
        <h1>jQueryMobile - DateBox</h1>
        <a href="javascript:$('#langpicker').datebox('open')" class="ui-btn ui-icon-left ui-icon-user ui-shadow ui-corner-all">i18n</a>
      </div>
      <div class="ui-content" role="main">
        <div class="content-secondary">
          <div id="jqm-homeheader">
            <h1 id="jqm-logo"><img src="img/jquery-logo-db.png" alt="jQuery Mobile Framework :: DateBox" /></h1> 
            <p>A Date and Time Picker plugin for jQueryMobile 1.4.5</p>
          </div>
          <ul data-role="listview" data-inset="true">
            <li data-role="list-divider">Documentation</li>
            <li><a href="doc/">Main Documentation</a>
            </li>
            <li><a href="api/">API Documentation</a>
            </li>
            <li data-role="list-divider">Support</li>
            <li><a href="theme/" rel="external">Theme Builder</a>
            </li>
            <li><a href="builder/" rel="external">Download Builder</a>
            </li>
            <li><a href="https://github.com/jtsage/jquery-mobile-datebox">GitHub Source</a>
            </li>
            <li><a href="http://dev.jtsage.com/forums/">Support Forums</a>
            </li>
            <li><a href="http://crowdin.net/project/jquery-mobile-datebox">i18n Project</a>
              <li><a href="mailto:jtsage+datebox@gmail.com">Contact</a>
              </li>
              <li><a href="http://jquerymobile.com/">jQueryMobile Homepage</a>
              </li>
          </ul>
        </div>
        <!--/content-primary-->
        <div class="content-primary">
          <p class="aintro">DateBox is a jQueryMobile plugin that aims to make user interaction with dates and times simple and intuitive. It is a colloborative work, with a full range of features allowing easy implementation, and painless extensibility.</p>
          <h2>General Look and Feel</h2>
          <div class="ui-field-contain">
            <label for="mode1">CalBox</label>
            <input name="mode1" id="mode1" type="text" data-role="datebox" data-options='{"mode":"calbox"}' />
          </div>
          <div class="ui-field-contain">
            <label for="mode2">DateBox</label>
            <input name="mode2" id="mode2" type="text" data-role="datebox" data-options='{"mode":"datebox"}' />
          </div>
          <div class="ui-field-contain">
            <label for="mode9">TimeBox</label>
            <input name="mode9" id="mode9" type="text" data-role="datebox" data-options='{"mode":"timebox"}' />
          </div>
          <div class="ui-field-contain">
            <label for="mode5">DurationBox</label>
            <input name="mode5" id="mode5" type="text" data-role="datebox" data-options='{"mode":"durationbox"}' />
          </div>
          <div class="ui-field-contain">
            <label for="mode3">FlipBox</label>
            <input name="mode3" id="mode3" type="text" data-role="datebox" data-options='{"mode":"flipbox"}' />
          </div>
          <div class="ui-field-contain">
            <label for="mode7">TimeFlipBox</label>
            <input name="mode7" id="mode7" type="text" data-role="datebox" data-options='{"mode":"timeflipbox"}' />
          </div>
          <div class="ui-field-contain">
            <label for="mode6">DurationFlipBox</label>
            <input name="mode6" id="mode6" type="text" data-role="datebox" data-options='{"mode":"durationflipbox"}' />
          </div>
          <div class="ui-field-contain">
            <label for="mode4">SlideBox</label>
            <input name="mode4" id="mode4" type="text" data-role="datebox" data-options='{"mode":"slidebox"}' />
          </div>
          <div style="display:none">
            <input name="langpicker" type="text" data-role="datebox" data-datebox-close-callback="changeLang" data-datebox-custom-data="langs" data-datebox-custom-head="Language" data-datebox-popup-position="window" data-datebox-override-custom-set="Choose" data-datebox-mode="customflip"
            id="langpicker" />
          </div>
        </div>
      </div>
      <div data-role="footer" data-position="fixed">
        <h1>a project by JTSage</h1>
      </div>
    </div>
</html>
