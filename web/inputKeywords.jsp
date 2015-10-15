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

            function DelKeywords(inputEle) {
                alert(inputEle.id);
            }

            function doCompletion() {
                var completeField = document.getElementById('edit-text');
                var url = "ueserkeywords?action=complete&id=" + escape(completeField.value);
                //         alert(url);
                //req = initRequest();
                //req.open("GET", url, true);
                //req.onreadystatechange = callback;
                //req.send(null);
                $.ajax({
                    type: "GET",
                    contentType: "application/json; charset=utf-8",
                    url: url,
                    dataType: 'json',
                    async: true,
                    data: "{}",
                    success: function (data) {
                        parseMessages(data);
                    },
                    error: function (result) {

                    }
                });
            }


            function parseMessages(responseXML) {
                // no matches returned
                if (responseXML == null) {
                    return false;
                } else {
                    $('#zhu-keywords').empty()
                    d3.select("#zhu-keywords")
                            .selectAll("li")
                            .data(responseXML)
                            .enter().append("li")
                            //.style("width", function(d) { return d.textContent * 10 + "px"; })
                            .html(function (d) {
                                return "<fieldset >" + d.Keywords + "<input id=" + d.Keywords + " type='button' value='x' onclick='DelKeywords(this)' > </fieldset>";
                            });
                }
            }


        </script>        
    </head>
    <body >
        <div id="skills-item-edit-clone">
            <form name="editKeywordsForm" method="POST" action="keywords-process-do" id="skills-editor-form">
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
                                    <input type="button" id="optout" value="×" onclick="DelKeywords('Graph Theory')">
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

                <input  name="submit" type="submit" value="Save" >                
                <input  name="submit" type="submit" value="Search" >                        
                <button  type="button" >Cancel</button>
            </form>
        </div>
    </body>
</html>
