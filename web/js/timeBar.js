
function DrawEventChart(width, height) {

    $(window).on("location_move", function (event, result) {
        var x1 = result.x1;
        var y1 = result.y1;
        var x2 = result.x2;
        var y2 = result.y2;
        var SURL = "function/rankEvent_1.jsp?x1=" + x1 + "&y1=" + y1 + "&x2=" + x2 + "&y2=" + y2;
        $.get(SURL)
                .done(function (graph) {
                    var temp = graph.trim();
                    $("#series_chart_div").empty();
                    var format = d3.time.format("%Y-%m-%d");
                    var format2 = d3.time.format("%m-%d");
//                    var temp = '[ {"EventName": "uqxcourses-uq:", "StartTime":"Thu 23 Jul 2015 05:26", "Value": "5.598438816686623", "Opion":"X"},{"EventName": "usceduau-uq:", "StartTime":"Sat 4 Jul 2015 10:14", "Value": "6.287322751500658", "Opion":"P"},{"EventName": "4th-annual-international-feminist-journal-of-politics-conference-held-in-brisbane-in-june-2015-master:", "StartTime":"Thu 18 Jun 2015 08:50", "Value": "1.933846044080254", "Opion":"P"},{"EventName": "alex-j-bellamy-qld:", "StartTime":"Tue 8 Sep 2015 04:37", "Value": "3.2419459292914077", "Opion":"P"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:28", "Value": "2.2015568840605093", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:28", "Value": "6.636447418021561", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:28", "Value": "2.5091898538975608", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:28", "Value": "9.086657084413304", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:28", "Value": "4.641313315229025", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:28", "Value": "7.879738731395522", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:31", "Value": "1.7941460609680915", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:31", "Value": "4.102161644385153", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:28", "Value": "0.6185825475314499", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:28", "Value": "6.893105719227449", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:28", "Value": "3.4774346441298762", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:28", "Value": "7.020116451752143", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:28", "Value": "0.43652497624375286", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:28", "Value": "4.608631724973666", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:31", "Value": "2.2613222547908283", "Opion":"X"},{"EventName": "dr-krystal-uq:", "StartTime":"Mon 6 Jul 2015 05:31", "Value": "5.07639849047715", "Opion":"X"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "5.387804542576225", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "9.825063841916812", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "5.691075062402957", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "1.3778479878743433", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "7.007065615483769", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "8.933992681372159", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Thu 16 Jul 2015 08:21", "Value": "1.2968448818434009", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Thu 16 Jul 2015 08:21", "Value": "9.90360885454582", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "2.5112400146953706", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "6.212903557520279", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "4.453566595121345", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "4.008060854034246", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "1.994395224345038", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "9.971053011246108", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Thu 16 Jul 2015 08:21", "Value": "4.014838110932301", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Thu 16 Jul 2015 08:21", "Value": "2.5833722753045993", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "8.50047667372028", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "8.281383749564275", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "4.739639201581136", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "9.14320089559337", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "2.9664351985293305", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "4.291456811204437", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Thu 16 Jul 2015 08:21", "Value": "7.806143826352767", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Thu 16 Jul 2015 08:21", "Value": "3.0051015748279797", "Opion":"N"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "2.2098743834217363", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "5.1786535728343015", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "3.2947636813186865", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "8.477702354158907", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "9.629491440500498", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Mon 13 Jul 2015 12:49", "Value": "0.6996524309013263", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Thu 16 Jul 2015 08:21", "Value": "1.4229564239879977", "Opion":"P"},{"EventName": "jcu-uq:", "StartTime":"Thu 16 Jul 2015 08:21", "Value": "7.499733782773681", "Opion":"P"},{"EventName": "kark-group-uq:", "StartTime":"Wed 8 Jul 2015 09:28", "Value": "5.0932260067370265", "Opion":"X"},{"EventName": "naturecomms-uq:", "StartTime":"Wed 22 Jul 2015 10:29", "Value": "6.981464059950535", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "2.5272206376107818", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "3.5315090137877547", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "2.6081715103685923", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "8.711066332728578", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "9.313090661062533", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "9.665468849712349", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "1.7979454996726052", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "8.202945390758405", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "8.731834190790725", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "1.9009213143887294", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "1.9573566098221085", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "2.958623423399902", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "4.992947637567128", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "9.319119034317367", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "5.510841151402545", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "4.279508136492924", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "9.684433973402133", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "6.498338072649121", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "1.0702926482485053", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "8.254171964494972", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "9.748237766137605", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "9.92463129037392", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "4.969538163823637", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "7.013434427520685", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "9.146105698209752", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "9.382450610216987", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "4.146861548192314", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "2.531379997969063", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "5.4515258829108015", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "7.350344420772819", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "2.553614801080907", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "7.447720113333132", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "8.316296140769065", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "4.280453384611138", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "7.88609502763426", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "7.396663256341272", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "2.7856592187852556", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "5.306544293023686", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "5.369510565377324", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "7.1497290207176505", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "6.773831113940446", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "4.403834510525682", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "0.5669950709787075", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "8.514707693771054", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "8.662144203173618", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "5.314879852028529", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "3.743273684319528", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "1.3802250726458443", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "7.944913542648364", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "4.659307659297869", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "4.181722506669018", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "0.5551507055553739", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "9.123528572843496", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "1.561201212993485", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "4.0352059935843325", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "0.12434076610233546", "Opion":"P"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "6.637158651649458", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "9.856447308595778", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "7.7852154446265285", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "3.92697962740204", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "6.518856918602061", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Tue 7 Jul 2015 03:29", "Value": "3.4833838368184935", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "5.19047168059393", "Opion":"X"},{"EventName": "uq-gpem-uq:", "StartTime":"Fri 17 Jul 2015 02:52", "Value": "5.461048739968931", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "8.678733598127398", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "3.013592331867494", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "2.725301152101105", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "3.0272144877379805", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "2.2412603892521044", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "1.4457007413949474", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 18 Jul 2015 06:54", "Value": "0.939727451443948", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 18 Jul 2015 06:54", "Value": "6.247695452728143", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "5.201662361674445", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "0.36357654684700647", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "2.917364834762518", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "8.23043427496026", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "8.816740266418782", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "3.351303100366565", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 18 Jul 2015 06:54", "Value": "2.0638439395335437", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 18 Jul 2015 06:54", "Value": "3.596161391420921", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "6.608356592460927", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "2.160852181233998", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "5.827634207754827", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "6.345711532220232", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "7.6332136547611205", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "2.5443766217073693", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 18 Jul 2015 06:54", "Value": "5.636772565380395", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 18 Jul 2015 06:54", "Value": "3.117209290314168", "Opion":"P"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "3.7604379240182952", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "0.8915674825459496", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "2.329147123339128", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "6.767515659235705", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "1.09887764840629", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 11 Jul 2015 09:14", "Value": "9.853531151945592", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 18 Jul 2015 06:54", "Value": "0.6606261014478798", "Opion":"X"},{"EventName": "uq-news-uq:", "StartTime":"Sat 18 Jul 2015 06:54", "Value": "2.40958396114904", "Opion":"X"},{"EventName": "uq-sport-university:", "StartTime":"Sat 27 Jun 2015 03:56", "Value": "6.428912078907947", "Opion":"X"},{"EventName": "uqalumni-qld:", "StartTime":"Sun 28 Jun 2015 06:17", "Value": "0.9881606304636015", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:25", "Value": "6.094460618306179", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:25", "Value": "3.0471484671228333", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:25", "Value": "0.5189585044871459", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:25", "Value": "5.127989035742255", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:25", "Value": "2.0070337824840276", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:25", "Value": "4.770424989908191", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:28", "Value": "1.5447581130331212", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:28", "Value": "6.650031700208875", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:25", "Value": "5.689166636127535", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:25", "Value": "2.11127616553871", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:25", "Value": "3.4799074745332845", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:25", "Value": "6.1181333274377", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:25", "Value": "7.078832882206002", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:25", "Value": "2.603555976478754", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:28", "Value": "6.288996181604089", "Opion":"P"},{"EventName": "uqdi-news-uq:", "StartTime":"Fri 3 Jul 2015 11:28", "Value": "6.8718589330956", "Opion":"P"},{"EventName": "uqnorthamerica-uq:", "StartTime":"Thu 23 Jul 2015 06:30", "Value": "5.030275692753129", "Opion":"X"}]';

                    var events = JSON.parse(temp);

                    var time = {"start": "01 May 2015", "end": "15 Sep 2015"},
                    chart;
                    var padding = 15;
                    //width = $("#series_chart_div").width() - 2 * margin,
                    var bar_height = 20;

                    var XStartTime = new Date(time.start);
                    var one_day = 24 * 60 * 1000 * 60;
                    //var one_day = 24 * 60 *60*  1000;
                    var XEndTime = new Date(time.end);
                    //total_days = parseInt((format.parse(time.end).getTime() - format.parse(time.start).getTime()) / one_day);
                    var total_days = (XEndTime.getTime() - XStartTime.getTime()) / one_day;
                    // alert(XStartTime)
                    var margin = {top: 40, right: 40, bottom: 40, left: 40};
                    //height = $("#series_chart_div").height();
                    var timeUnit = (width - margin.left - margin.right) / (XEndTime.getTime() - XStartTime.getTime());
                    //alert(timeUnit)



                    var days = [];
                    for (var i = 0; i <= total_days; i++) {
                        days.push(one_day * i)
                    }


                    var colors = ['#FF3333', '#D6475C', '#AD5C85', '#8570AD', '#5C85D6', '#3399FF'];


                    var tip = d3.tip()
                            .attr('class', 'd3-tip')
                            .offset([-10, 0])
                            .html(function (d) {
                                return "<div style='font-style:bold;text-align:center;'>" + d["name"] + "</div>\
                <div style='font-style:bold; text-align:center;'>" + d["x"] + " to "+d["EndTime"]+ " </div>";
                            });


                    var x = d3.time.scale()
//                            .domain([new Date(events[0].StartTime), d3.time.day.offset(new Date(events[events.length - 1].StartTime), 1)])
                            .domain([XStartTime, d3.time.month.offset(XEndTime, 1)])
                            //.domain([XStartTime, XEndTime])    // values between for month of january
                            .rangeRound([0, width - margin.left - margin.right]);

                            
                    var y = d3.scale.linear().range([height,0]);
                    //var yAxis = d3.svg.axis().scale(y).orient("left");
                    y.domain(d3.extent(events, function (d) {
                          return Math.max(d.Value);
                    }));
                    
                    //y.domain([0, d3.max(events, function (d) {
                      //      return Math.max(d.Value);
                        //})]);

                    var xAxis = d3.svg.axis()
                            .scale(x)
                            .orient('bottom')
                            .ticks(d3.time.months, 1)
                            .tickFormat(d3.time.format('%b %m'))
                            .tickSize(16, 0)
                            .tickPadding(8);

                    var yAxisLeft = d3.svg.axis().scale(y)
                            .orient("left").ticks(5);

                    chart = d3.select($("#series_chart_div")[0])
                            .append('svg')
                            .attr('class', 'chart')
                            .attr('width', width + margin.left + margin.right)
                            .attr('height', height + margin.top + margin.bottom)
                            .append('g')
                            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");


                    chart.append('g')
                            .attr('class', 'x axis')
                            .attr('transform', 'translate(0, ' + (height ) + ')')
                            .call(xAxis);

                    chart.append("g")
                            .attr("class", "y axis")
                            .attr("transform", "translate(" + margin.left+ " ,0)")	
                            .style("fill", "steelblue")
                            .call(yAxisLeft);

                    //chart.xAxis.tickValues(d3.time.month.range(XStartTime,XEndTime),1);

                    chart.call(tip);

                    chart.selectAll("rect")
                            .data(events)
                            .enter().append("rect")
                            .attr("x", function (d) {
                                var temp1 = new Date(d["StartTime"]);
                                return   x(temp1);//timeUnit * (temp1.getTime() - XStartTime.getTime());
                            })
                            .attr("y", function (d) {
                                if (d.Value<1) d.Value=1;
                                return y(d.Value);// * (bar_height + padding);
                            })
                            .attr("width", function (d) {
                                var temp1 = new Date(d["StartTime"]);
                                var temp2 = new Date(d["EndTime"]);
                                var temp3 = x(temp2) - x(temp1); //timeUnit*(temp2.getTime() - temp1.getTime());// / one_day;
                                if (temp3<1) temp3=1;
                                return Math.floor(temp3);
//                    return timeUnit * (format.parse(d.StartTime).getTime() - format.parse(d.start).getTime() + 1);
                            })
                            .attr("height", bar_height)
                            .attr("STime", function (d) {
                                return d.StartTime;
                            })
                            .attr("ETime", function (d) {
                                return d.EndTime;
                            })                            
                            .attr("name", function (d) {
                                return d.EventName;
                            })
                            .attr("postcode", function (d) {
                                return d.Postcode;
                            })
//                .attr("keywords", function (d) {
//                    return d.keywords;
//                })
//                .attr("dist", function (d) {
//                    return d.dist;
//                })
                            .style('opacity', '0.8')
                            .style("cursor", "pointer")
                            .style("fill", function (d) {
                                //return colors[idx];
                                var colorArray = 'black';
                                if (d.Opion == 'P')
                                    colorArray = 'green';
                                else if (d.Opion == 'N')
                                    colorArray = 'red';
                                return colorArray;
                            })
                            .on("mouseover", function (event) {
                                tip.show({"name": d3.select(this).attr("name"), "date": d3.select(this).attr("date")});
                            })
                            .on("mouseout", tip.hide)
                            .on("click", function () {
                                var name = d3.select(this).attr('name');
                                //var date = d3.select(this).attr('date');
                                var date = d3.select(this).attr('postcode');
                                //  var keyword = d3.select(this).attr('keywords');
                                //    var dist = d3.select(this).attr('dist');
                                //alert('The user selected facebook' + topping);
                                //window.open("https://www.facebook.com/" + topping);
                                //window.open("https://www.facebook.com/" + topping);
                                window.open("function/showEventTopics.jsp?word=" + date + "&eventName=" + encodeURIComponent(name), "", "left=200, top=200, width=1000, height=500");

                                /*   		var eventWindow = window.open("http://uqimage.uqcloud.net/static.php", "", "left=200, top=200, width=1000, height=500");
                                 $(eventWindow.document).ready(function () {
                                 eventWindow.window.name = name;
                                 eventWindow.window.time = date;
                                 eventWindow.window.keyword = keyword;
                                 eventWindow.window.dist = dist;
                                 });
                                 */
                            });

                    /*                    chart.selectAll("line")
                     .data(days)
                     .enter().append("line")
                     .attr("x1", function (d) {
                     return padding + timeUnit * d
                     })
                     .attr("x2", function (d) {
                     return padding + timeUnit * d
                     })
                     .attr("y1", 0)
                     .attr("y2", height - 2 * padding);
                     
                     chart.selectAll(".rule")
                     .data(days)
                     .enter().append("text")
                     .attr("class", "rule")
                     .attr("x", function (d) {
                     return padding + timeUnit * d
                     })
                     .attr("y", height - padding)
                     .attr("dy", -6)
                     .attr("text-anchor", "middle")
                     .attr("font-size", 10)
                     .text(function (d) {
                     var timeStamp = XStartTime.getTime() - d;
                     var t = new Date(timeStamp);
                     return format2(t)
                     });
                     */
                });
    });
}