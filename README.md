#iOS SoftKeyboard

Quick and dirty Cordova 3.0 plugin for iOS SoftKeyboard events

For those looking for a simple  solution to get keyboard show/hide events add the code in src/ios to your XCode project and add www/SoftKeyboard.js  to your www project.

Add the plugin to config.xml
```
    <feature name="KeyboardPlugin">
        <param name="ios-package" value="KeyboardPlugin" />
        <param name="onload" value="true" />
    </feature>
```

This will add two new events 
```
window.addEventListener('showKeyboard', function(size) { ... });
window.addEventLisener('hideKeyboard', function() {...});
```
Additionally you can check the status through
```
window.keyboard.visible
window.keyboard.size //will be {width:0,height:0} if not visible
```
##TODO
* Cleanup
* Android (probably more important than IOS, can probably leverage old code from phonegap-plugins repo)
* Package as a proper phonegap plugin for CLI install (add plugin.xml)


Copyright 2013 iOffice, Kenton Gray

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
