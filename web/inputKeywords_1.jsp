<%-- 
    Document   : inputKeywords
    Created on : 22/09/2015, 10:14:17 AM
    Author     : uqgzhu1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
  <style>
fieldset {
  padding: 1em;
  font:80%/1 sans-serif;
  }
label {
  float:left;
  width:25%;
  margin-right:0.5em;
  padding-top:0.2em;
  text-align:right;
  font-weight:bold;
  }
    </style>
    
        <script src="./d3/jquery.js"></script>
        <script src="./d3/d3.js"></script>

        <script type="text/javascript" >
            var req;
            var isIE;

            function init(Inid) {
                completeField = document.getElementById(Inid);
            }

            function doCompletion() {
                var url = "ueserkeywords?action=complete&id=" + escape(completeField.value);
       //         alert(url);
                req = initRequest();
                req.open("GET", url, true);
                req.onreadystatechange = callback;
                req.send(null);
            }

            function doCompletion() {
                var url = "ueserkeywords?action=complete&id=" + escape(completeField.value);
       //         alert(url);
                req = initRequest();
                req.open("GET", url, true);
                req.onreadystatechange = callback;
                req.send(null);
            }

            function initRequest() {
                if (window.XMLHttpRequest) {
                    if (navigator.userAgent.indexOf('MSIE') != -1) {
                        isIE = true;
                    }
                    return new XMLHttpRequest();
                } else if (window.ActiveXObject) {
                    isIE = true;
                    return new ActiveXObject("Microsoft.XMLHTTP");
                }
            }


            function callback() {
                if (req.readyState == 4) {
                    if (req.status == 200) {
                        //alert(req.responseXML);
                        parseMessages(req.responseXML);
                    }
                }
            }

            function appendComposer(firstName, lastName, composerId) {

                var row;
                var cell;
                var linkElement;

                var tempUi= document.getElementById('zhu-keywords');
                
               // alert(tempUi);
                
                if (isIE) {
                   // tempUi.style.display = 'block';
                    //row = completeTable.insertRow(completeTable.rows.length);
                    cell = row.insertCell(0);
                } else {
                   // tempUi.style.display = 'table';
                    //row = document.createElement("tr");
                    cell = document.createElement("li");
                    //row.appendChild(cell);
               //     tempUi.appendedNode(cell);
                    tempUi.appendChild(cell);
                }

                //cell.className = "popupCell";
                cell.setAttribute("data-id",  composerId);
                var linkElement = document.createElement("fieldset");                
                var linkElement1 = document.createElement("label");
                linkElement1.appendChild(document.createTextNode(firstName + " " + lastName));
//                var linkElement2 = document.createElement("button");
  //              linkElement2.appendChild(document.createTextNode("Yes"));
                var linkElement3 = document.createElement("button");
                linkElement3.appendChild(document.createTextNode("×"));
                
                linkElement.appendChild(linkElement1);
                linkElement.appendChild(linkElement2);
                linkElement.appendChild(linkElement3);
                cell.appendChild(linkElement);
                
            }

            function parseMessages(responseXML) {

                // no matches returned
                if (responseXML == null) {
                    return false;
                } else {
                    var tempUi= document.getElementById('zhu-keywords');
                    
                    
                    var composers = responseXML.getElementsByTagName("composers")[0];
                    
                    
                    if (composers.childNodes.length > 0) {


                        for (loop = 0; loop < composers.childNodes.length; loop++) {
                            var composer = composers.childNodes[loop];
                            var firstName = composer.getElementsByTagName("firstName")[0];
                            var lastName = composer.getElementsByTagName("lastName")[0];
                            var composerId = composer.getElementsByTagName("id")[0];
                                            appendComposer(firstName.childNodes[0].nodeValue,
                                              lastName.childNodes[0].nodeValue,
                                           composerId.childNodes[0].nodeValue);
                            //alert(firstName.childNodes[0].nodeValue);
                        }
                    }
                }
            }

        </script>        
    </head>
    <body onload="init('edit-text')">
        <div id="skills-item-edit-clone">
            <form name="editKeywordsForm" method="POST" action="/profile/edit-keywords" id="skills-editor-form">
                <div class="endorsement-settings">
                    <h5>Skills and Endorsements Settings</h5>                    
                    <div class="settings-container">
                        <fieldset class="optin-settings">
                            <ul>
                                <BR>

                                <li>Your topic name:  <input type="text" id="includeMe" name="includeInSuggestions" value="true" checked="">

                                </li>
                                <li>Your email address:  <input type="text" id="showSuggestions" name="showSuggestions" value="true" checked="">

                                </li>
                                <li><input type="checkbox" id="sendNotification" name="emailSubscription" value="true" checked="">                                    
                                </li>
                            </ul>
                        </fieldset>
                    </div>
                </div>

                <div class="add-skill-container">
                    <label for="edit-skills-add-ta" class="ghost" id="control_gen_27" style="display: none;">What are your interested in the keywords?</label>                        
                    <input type="text" id="edit-text" value=""  maxlength="80" >                        

                    <input  id="edit-add-btn" type="button" value="Add"  onclick="doCompletion();">       
                    <p id="skills-counter">You can still add: <strong>3</strong> Keywords</p>                        
                </div>
                <div >
                    <div class="all-skills-list">
                        <ol id="zhu-keywords">
                            <li data-item-name="Graph Theory" data-id="1" >                                
                                <fieldset >                                    
                                    Graph Theory 
                                    <input type="radio" id="optin" name="displayEndorsements" value="true" checked=""><label for="optin">Yes</label>
                                    <input type="radio" id="optout" name="displayEndorsements" value="false">×                                
                                    </fieldset>
                            </li>
                            <li data-item-name="Java" data-id="2" >
                                <fieldset >                                    
                                    <label for="Java">Java</label>                                    
                                    <input type="radio" id="optin" name="displayEndorsements" value="true" checked=""><label for="optin">Yes</label>
                                    <input type="radio" id="optout" name="displayEndorsements" value="false">×
                                </fieldset>
                            </li>

                        </ol>
                    </div>
                </div>


                <div class="hints">
                    <div class="reorder-icon">&nbsp;</div><strong>Drag to reorder. </strong></div>
        </div>
        <input  name="submit" type="submit" value="Save" >                
        <button  type="button" >Cancel</button>
    </form>
</div>
</body>
</html>
