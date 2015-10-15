/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mytopicdetected;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.List;

/**
 *
 * @author uqgzhu1
 */
public class TopicTree {

    public TopicTreeNode root;

    //private HashSet<TopicTreeNode> TopicSets;
//    private List<String> TopicStringSets;
    String base = "/home/uqgzhu1/datasets/data/";//System.getProperty("user.dir") + "/data/";
    private String[] FileLists = {"trends/hastag.tsv"};
    static List<String> KeywordList = null;
    static List<String> SubTopicList = null;
    static List<String> TopicList = null;

    public TopicTree() {

        root = null;
        KeywordList = new ArrayList<String>();
        SubTopicList = new ArrayList<String>();
        TopicList = new ArrayList<String>();

        try {
            for (int i = 0; i < FileLists.length; i++) {
                FileReader fr = new FileReader(base + FileLists[i]);
                BufferedReader textReader = new BufferedReader(fr);
                String aLine = null;
                while ((aLine = textReader.readLine()) != null) {
                    String[] temp = aLine.split(",");
                    if (temp == null) {
                        continue;
                    }
                    if (temp.length < 2) {
                        continue;
                    }
                    //System.err.println(temp[0]+"\t"+temp[1]);
                    KeywordList.add(temp[0]);
                    SubTopicList.add(temp[1]);
                    TopicList.add(temp[2]);
                }
                textReader.close();
            }//end while		
        } catch (FileNotFoundException ex) {
            System.err.println(ex);
        } catch (IOException ex) {
            System.err.println(ex);
        }
        root = createNode("University", null, null, '\0');
        root.add("UQ", "University", '\0');
        
        root.add("Living", "UQ", "University", '\0');
        root.add("Research", "UQ", "University", '\0');
        root.add("Studying", "UQ", "University", '\0');
        root.add("Safety", "UQ", "University", '\0');
        root.add("Events", "UQ", "University", '\0');
        root.add("Teaching", "UQ", "University", '\0');
        root.add("QUT", "University", '\0');
        root.add("Events", "QUT", "University", '\0');
        root.add("GRIFFITHY", "University", '\0');
        root.add("CQU", "University", '\0');
        root.add("USQ", "University", '\0');

    }

    public TopicTreeNode returnRoot() {
        return root;
    }

    public TopicTreeNode getRoot() {
        return root;
    }

    public TopicTreeNode SearchTopic(TopicTreeNode root1, String key) {
        if (root1 != null) {
            if (root1.getTopic().compareTo(key) == 0) {
                return root;
            }
            TopicTreeNode x = SearchTopic(root1.getLeft(), key);
            if (x != null) {
                return x;
            }
            x = SearchTopic(root1.getRight(), key);

            return x;
        }
        return null;
    }

    // using the function ...
    public boolean preOrder(TopicTreeNode root, List<String> Topics) {
        if (root != null) {
//            System.out.print(root.getTopic());; // root root.getWord()            
//            Topics.add(root.getTopic());

            System.out.print("->" + root.getWord());
            //if (preOrder(root.getLeft())==false)
            TopicTreeNode node1 = root.getLeft();
            if (node1 != null) {
                preOrder(node1, Topics);
            }

            node1 = root.getRight();
            if (node1 != null) {
                preOrder(node1, Topics);
            }
            //System.err.println(root.getWord());

            //          Topics.add(root.getWord());
            return true;
        }
        return false;
    }

    public static void main(String[] args) {
        TopicTree myTree = new TopicTree();
//        TopicTreeNode root = myTree.createNode("University",null,null,'\0');
        //      root.add("UQ", "University", '#');

    //    root.add("QUT", "University", '#');
        //  root.add("USQ", "University", '#');        
        //myTree.preOrder(root, null);
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        System.out.println(sdf.format(cal.getTime()));

        System.out.println();

        //root.add("Research", "UQ", '#');
        //root.add("Studying", "UQ", '#');
        //root.add("Living", "UQ", '#');
        //root.add("Teaching", "UQ", '#');
        //root.add("Safety", "UQ", '#');
        //myTree.preOrder(root, null);
        //System.out.println();
        myTree.root.add("turkey", "food", "Living", 'P');
        myTree.root.add("naledifossils", "Science", "Research", 'P');
        myTree.root.add("citizenscience", "Science", "Research", 'P');
        myTree.root.add("fossilfriday", "Research", "Research", 'P');
        myTree.root.add("magpie", "Campus", "Living", 'P');

        //myTree.root.add("refugeeswelcome","Student","Studying",'P');
        //myTree.root.add("citizenscience","Science","Research",'P');
        //root.add("Science", "Research", '#');
        //root.add("neuroscience","Science","Research",'#');        
        //root.add("refugeeswelcome","Studying",'#');
        //TopicTreeNode node1 = myTree.createNode("neuroscience","Science","Research",'#');
        //root.addSubNode(node1);
        //myTree.preOrder(root, null);
        //StringBuffer MyOutJson=new StringBuffer("\n{");
        //String temp=myTree.toJson(root, MyOutJson,0);
        //MyOutJson.append('}');
        System.out.println(myTree.prntJson());
        //System.out.println(MyOutJson.toString());

        Calendar Fcal = Calendar.getInstance();
        System.out.println(sdf.format(Fcal.getTime()));
        System.out.println(sdf.format(Fcal.getTimeInMillis() - cal.getTimeInMillis()));

    }

    private TopicTreeNode createNode(String james_cook_university, String university, char tag) {
        TopicTreeNode temp = new TopicTreeNode(james_cook_university, university, tag);
        return temp;
    }

    private void clearTree(TopicTreeNode root) {
        if (root != null) {
            clearTree(root.getLeft());
            clearTree(root.getRight());
            root = null;
        }
    }

    public void clear() {
        clearTree(root);
        root = null;
    }

    public mytopicdetected.TopicTreeNode createNode(String neuroscience, String science, String research, char c) {
        mytopicdetected.TopicTreeNode temp = null;
        if (c == '\0') {
            temp = new TopicTreeNode(neuroscience, null, c);
            root = temp;
        } else {

            temp = new TopicTreeNode(neuroscience, science, c);

        }
        return temp;
    }

    private String toJson(mytopicdetected.TopicTreeNode root, StringBuffer object, int level) {

        if (root != null) {
//            System.out.print(root.getTopic());; // root root.getWord()            
//            Topics.add(root.getTopic());
            char flag = root.getTag();
            if (flag=='\0') flag='X';
            if (level == 2 && flag == '\0') {
                return object.toString();
            }

            for (int i = 0; i < level; i++) {
                object.append("\t");
            }
            object.append(" {\"name\":\"");
            object.append(root.getWord());
            object.append("\",\n");
            for (int i = 0; i < level; i++) {
                object.append("\t");
            }
            object.append("\"Opion\":\"");
            
            object.append(flag);
            object.append("\",");
            for (int i = 0; i < level; i++) {
                object.append("\t");
            }
            HashSet <String> tempSet=root.getIdList();
            if (tempSet!=null){
                object.append("\"tw_List\":\"");            
                for (String x:tempSet){
                    object.append(x);
                    object.append(" ");                
                }
                object.append("\",");
            }
            object.append("\"Weight\":");
            object.append(root.getWeight());
            object.append("");

            TopicTreeNode node1 = root.getLeft();

            if (node1 != null) {
                object.append(",\n");
                for (int i = 0; i < level; i++) {
                    object.append("\t");
                }
                object.append("\"children\":[\n");
                for (int i = 0; i < level; i++) {
                    object.append("\t");
                }
//                object.append("{\n");
                toJson(node1, object, level + 1);
                for (int i = 0; i < level; i++) {
                    object.append("\t");
                }
                object.append("]");
            }

            node1 = root.getRight();
            if (node1 != null) {
                for (int i = 0; i < level; i++) {
                    object.append("\t");
                }
                object.append("},\n");
                for (int i = 0; i < level; i++) {
                    object.append("\t");
                }
//                object.append("{\n");
                toJson(node1, object, level);
                for (int i = 0; i < level; i++) {
                    object.append("\t");
                }
//                object.append("}\n");                                
            } else {
                for (int i = 0; i < level; i++) {
                    object.append("\t");
                }
                object.append("}\n");
            }

        } else {
            for (int i = 0; i < level; i++) {
                object.append("\t");
            }
            object.append("}\n");
        }
        return object.toString();

    }

    public void addTopic(String key, Double value, char c,String postcode, String TwIdListStr) {
//        addTopic(key,value,c,null);
        if (key.charAt(0) == '#') {
            key = key.substring(1);
        }else if (key.charAt(0) == '@') {
            key = key.substring(1);
        }
        int loc = KeywordList.indexOf(key);
        if (loc >= 0) {
            String subtopic = SubTopicList.get(loc);
            String topic = TopicList.get(loc);
            //  System.err.printf("%s\t%s\t%s\n",key, subtopic, topic);
            TopicTreeNode temp=root.add(key, subtopic, topic, c);
            if (temp!=null){
                String dysco_items[]=TwIdListStr.split(",");
                for (String next_item : dysco_items) {
                    //System.out.println(next_item.getPostcode() + " " + next_item.getAuthorScreenName() + " " + next_item.getId() + "- " + next_item.getTitle());
                    temp.addIDList(postcode,next_item);
                }
            }
        }
        
    }

    public StringBuffer prntJson() {
        StringBuffer MyOutJson = new StringBuffer("");
        String temp = toJson(root, MyOutJson, 0);
//      MyOutJson.append('}');
        //out.println(MyOutJson.toString());
        return MyOutJson;
    }
/*
    public void addTopic(String key, Double value, char c, List<Item> dysco_items) {
        if (key.charAt(0) == '#') {
            key = key.substring(1);
        }
        int loc = KeywordList.indexOf(key);
        if (loc >= 0) {
            String subtopic = SubTopicList.get(loc);
            String topic = TopicList.get(loc);
            //  System.err.printf("%s\t%s\t%s\n",key, subtopic, topic);
            TopicTreeNode temp=root.add(key, subtopic, topic, c);
            if (temp!=null)
            for (Item next_item : dysco_items) {
                //System.out.println(next_item.getPostcode() + " " + next_item.getAuthorScreenName() + " " + next_item.getId() + "- " + next_item.getTitle());
                temp.addIDList(next_item.getPostcode(),next_item.getId());
            }

        }

    }
*/
}
