/*
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
 */
var SoftKeyboard = function () {
	cordova.addWindowEventHandler("showKeyboard");
	cordova.addWindowEventHandler("hideKeyboard");
	var err = function (error) {
		console.log("keyboard error" + error)
	};
	//register listeners for keyboard event
	cordova.exec(SoftKeyboard.onKeyboardChange, err, "KeyboardPlugin", "start", []);
};

SoftKeyboard.visible = false;
SoftKeyboard.size = {width: 0, height: 0};
SoftKeyboard.onKeyboardChange = function (result) {
	var type = result.type;
	SoftKeyboard.visible = type == 'showKeyboard';
	if (SoftKeyboard.visible) {
		SoftKeyboard.size = result.size;
	} else {
		SoftKeyboard.size = {width: 0, height: 0};
	}
	cordova.fireWindowEvent(type, result.size);
};

$(document).on('deviceready', function (e) {
	//initialize our listener when cordova says so
	new SoftKeyboard();
	window.keyboard = new SoftKeyboard();
});