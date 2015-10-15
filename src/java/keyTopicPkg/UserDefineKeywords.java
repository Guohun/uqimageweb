/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package keyTopicPkg;

/**
 *
 * @author uqgzhu1
 */
public class UserDefineKeywords {
    
    private String TopicName;
    private String KeywordsName;
    private String category;

    public UserDefineKeywords ( String firstName, String lastName, String category) {
        
        this.TopicName = firstName;
        this.KeywordsName = lastName;
        this.category = category;
    }

    public String getCategory() {
        return category;
    }

    /**
     * @return the TopicName
     */
    public String getTopicName() {
        return TopicName;
    }


    /**
     * @return the KeywordsName
     */
    public String getKeywordsName() {
        return KeywordsName;
    }

}
