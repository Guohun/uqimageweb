/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package keyTopicPkg;

import java.util.HashMap;

/**
 *
 * @author uqgzhu1
 */
public class UserTopicInputData {
    private  HashMap <Integer, UserDefineKeywords> composers = new HashMap <Integer, UserDefineKeywords>();

    public HashMap getDefineTopics() {
        return composers;
    }

    public UserTopicInputData() {

        composers.put(1, new UserDefineKeywords("UQ", "create change", "Baroque"));
        composers.put(2, new UserDefineKeywords("UQ", "open days", "Baroque"));
        composers.put(3, new UserDefineKeywords("QUT", "uq lakes", "Baroque"));
        composers.put(4, new UserDefineKeywords("QUT", "xue li", "Baroque"));
        composers.put(5, new UserDefineKeywords("Create Change", "eait", "Baroque"));
        composers.put(6, new UserDefineKeywords("Create Change", "rcc", "Baroque"));
        composers.put(0, new UserDefineKeywords("Create Change", "uq", "Baroque"));


    }

    String[] getDefineTopics(String paramValue) {
        int len=composers.size();
        String [] temp=new String[len];
        for (int i=0;i<len;i++){
            UserDefineKeywords temp2=composers.get(i);
            temp[i]=temp2.getKeywordsName();
        }
        return temp;
        
    }
}
