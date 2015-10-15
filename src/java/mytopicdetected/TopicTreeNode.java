/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mytopicdetected;


import java.util.HashSet;

/**
 *
 * @author uqgzhu1
 */
public class TopicTreeNode {

    private String word; // The data in this node.

    private char TagFlag; // This is the opinion 

//    private int topicWeight; // The data in this node.    
    private int wordWeight; // The data in this node.        
    private TopicTreeNode left; // Pointer to the left subtree.
    private TopicTreeNode right; // Pointer to the right subtree.

    private TopicTreeNode TopicNode; // The data in this node.    
    private String TopicStr;
    private HashSet <String> postCodeList=null;
    private HashSet <String>IdList=null;

    TopicTreeNode(String james_cook_university, String university, char tag) {
        word = james_cook_university;
        this.TopicStr = university;
//        if (tag != 'P' || tag != 'N') {
  //          tag = 'X';
    //    }
        this.TagFlag = tag;
        wordWeight = 0;
        TopicNode = null;
//        topicWeight=0;
        left = null;
        right = null;
    }

    public TopicTreeNode add(String value, String TopicStr, char tag) {

        TopicTreeNode temp = this.Search(value, TopicStr, tag, true);
        if (temp == null) {
            temp = this.Search(TopicStr, tag);
            if (temp == null) {
                temp = new TopicTreeNode(value, TopicStr, tag);
                TopicTreeNode locnode = this.right;
                while (locnode.right != null) {
                    locnode = locnode.right;
                }
                temp.TopicNode = locnode;
                locnode.right = temp;
                IncreaseTopicWeight(temp);
            } else {
                System.err.printf("temp1=%s \t %s\t%s\n", temp.word, value, TopicStr);
                TopicTreeNode _Addnodes = new TopicTreeNode(value, TopicStr, tag);
                TopicTreeNode locnode = temp.left;
                while (locnode != null && locnode.word.compareToIgnoreCase(value) != 0) {
                    temp = locnode;
                    locnode = locnode.right;
                }
                if (temp.TopicStr != null && temp.TopicStr.compareToIgnoreCase(TopicStr) == 0) {
                    temp.right = _Addnodes;
                    _Addnodes.TopicNode = temp.TopicNode;
                } else {
                    temp.left = _Addnodes;
                    _Addnodes.TopicNode = temp;
                }

                //TopicNode = locnode;
                IncreaseTopicWeight(_Addnodes);
                return _Addnodes;
            }
        } else if (temp.word.compareToIgnoreCase(value) != 0) {
            System.err.printf("temp2=%s \t %s\t%s\n", temp.word, value, TopicStr);
            TopicTreeNode _Addnodes = new TopicTreeNode(value, TopicStr, tag);
            TopicTreeNode locnode = temp.right;//only right 
            TopicTreeNode BackTop = temp;
            while (locnode != null && locnode.word.compareToIgnoreCase(value) != 0) {
                temp = locnode;
                locnode = locnode.right;
            }
            if (locnode == null) {
                temp.right = _Addnodes;
                _Addnodes.TopicNode = temp.TopicNode;
            }
            IncreaseTopicWeight(_Addnodes);
        } else {
            temp.wordWeight++;
            IncreaseTopicWeight(temp);
        }

        return temp;
    }

    public TopicTreeNode add(String neuroscience, String science, String research, char c) {
        if (research.compareToIgnoreCase(science)==0) return null;
        if (research.compareToIgnoreCase(neuroscience)==0) return null;
        if (science.compareToIgnoreCase(neuroscience)==0) return null;
        TopicTreeNode temp = Search(neuroscience, science, research, c, true);
        if (temp == null) {
            temp = Search(science, research, c, true);
            
            
            if (temp != null) {
                TopicTreeNode _Addnodes = new TopicTreeNode(neuroscience, science, c);
                System.err.printf("temp3=%s \t %s\t%s\t%s\n", temp.word, neuroscience, science, research);
                TopicTreeNode locnode = temp.left;
                while (locnode != null && locnode.right != null) {
                    locnode = locnode.right;
                }
                if (locnode == null) {
                    temp.left = _Addnodes;
                    _Addnodes.TopicNode = temp;
                } else {
                    locnode.right = _Addnodes;
                    _Addnodes.TopicNode = locnode.TopicNode;
                }
                IncreaseTopicWeight(_Addnodes);
            } else {  //both father, and graterfather cann't get                
                temp = Search(research, c);
                if (temp == null) {
             //       System.err.printf("err =%s \t %s\t%s\t%s\n", temp.word, neuroscience, science, research);
                           System.err.printf("err =  \t %s\t%s\t%s\n", neuroscience, science, research);
                }else{                    
                    TopicTreeNode locnode = temp.left;
                    TopicTreeNode backtemp=temp;
                     //System.err.printf("get =%s \t %s\t%s\t%s\n", temp.word, neuroscience, science, research);
                    while (locnode != null && locnode.right != null) {
                        backtemp=locnode;
                        locnode = locnode.right;
                    }
                    TopicTreeNode _AddSubnodes = new TopicTreeNode(science, research, c);                        
                    TopicTreeNode _Addnodes = new TopicTreeNode(neuroscience,science,c);                                            
                    if (locnode == null) {                        
                        backtemp.left = _AddSubnodes;
                        _AddSubnodes.TopicNode = backtemp;
                    } else {
                        //System.err.printf("err2 =%s \t %s\t%s\t%s\n", locnode.word, neuroscience, science, research);
                        //subtopic add to right
                        locnode.right=_AddSubnodes;
                        _AddSubnodes.TopicNode=locnode;
                    }
                    _AddSubnodes.left = _Addnodes;
                    _Addnodes.TopicNode = _AddSubnodes;                        
                    IncreaseTopicWeight(_Addnodes);
                    
                }
            }
            
        } else if (temp.word.compareToIgnoreCase(neuroscience) != 0) {
            
            TopicTreeNode _Addnodes = new TopicTreeNode(neuroscience, science, c);
            TopicTreeNode locnode = temp.left;
            while (locnode != null && locnode.word.compareToIgnoreCase(neuroscience) != 0) {
                temp = locnode;
                locnode = locnode.right;
            }
            if (locnode == null) {
                if (temp.TopicStr.compareToIgnoreCase(science) != 0) {
                    temp.left = _Addnodes;  //right to left
                    _Addnodes.TopicNode = temp;
                } else {
                    temp.right = _Addnodes;  //right to left
                    _Addnodes.TopicNode = temp.TopicNode;
                }

            }
            IncreaseTopicWeight(_Addnodes);
        } else {
            temp.wordWeight++;
            IncreaseTopicWeight(temp);
        }

        return temp;
    }

    public TopicTreeNode Search(String TopicStr, char tag) {
        TopicTreeNode temp = null;
        if (TopicStr == null) {
            return null;
        }
        if (TopicStr.compareToIgnoreCase(word) == 0) {
            return this;
        }
        if (right != null) {
            temp = right.Search(TopicStr, tag);
        }
        if (temp == null) {
            if (left != null) {
                temp = left.Search(TopicStr, tag);
            }
        }
        return temp;
    }

    public TopicTreeNode Search(String subTopicStr, String TopicStr, char tag, boolean fuzzy) {
        if (TopicStr == null) {
            return Search(subTopicStr, tag);
        }
        TopicTreeNode temp = null;
        temp = Search(TopicStr, tag);
        if (temp == null) {
            if (fuzzy) {
                return null;
            }
            return this;
        }
        //top is equal just right and root        
        if (temp.left != null) {
            if (temp.left.word.compareToIgnoreCase(subTopicStr) == 0) {
                return temp.left;
            } else {                
                TopicTreeNode Backtemp = temp.left;
                temp = temp.left.right;
                while (temp != null && temp.word.compareToIgnoreCase(subTopicStr) != 0) {
                    Backtemp = temp;
                    temp = temp.right;
                }
                if (temp == null) {
                    if (fuzzy == false) {
                        return Backtemp;
                    }
                }
                return temp;
            }
        }
        if (temp.right != null) {
            if (temp.right.word.compareToIgnoreCase(subTopicStr) == 0) {
                return temp.right;
            } else {
                temp = temp.right.Search(subTopicStr, tag);
                if (temp == null) {
                    if (fuzzy) {
                        return null;
                    } else {
                        System.err.println("did not implement search (subtop, topic)");
                        return temp.right;
                    }
                }
                return temp;
            }

        }
        if (fuzzy) {
            return null;
        }

        return temp;
    }

    public TopicTreeNode Search(String words, String subTopicStr, String TopicStr, char tag, boolean fuzzy) {
        if (TopicStr == null) {
            return Search(words, subTopicStr, tag, fuzzy);
        }

        TopicTreeNode temp = Search(subTopicStr, TopicStr, tag, true);
        if (temp == null) {
            return null;
        }

        TopicTreeNode backtemp = temp;

        while (temp != null && (words.compareToIgnoreCase(temp.word) != 0)) {
            backtemp = temp;
            temp = temp.right;
        }
        if (temp == null) {
            return backtemp;
        }
        return temp;

    }

    //Count the nodes in the binary tree to which root points, and
    public static int countNodes(TopicTreeNode root) {
        if (root == null) {
            // The tree is empty. It contains no nodes.
            return 0;
        } else {
            // Start by counting the root.
            int count = 1;
            // Add the number of nodes in the left subtree.
            count += countNodes(root.left);
            // Add the number of nodes in the right subtree.
            count += countNodes(root.right);
            return count; // Return the total.
        }
    }

    public TopicTreeNode getLeft() {
        return left;
    }

    public TopicTreeNode getRight() {
        return right;
    }

    public String getWord() {
        return word;
    }

    char getTag() {
        return this.TagFlag;
    }

    String getTopic() {
        return this.TopicStr;
    }

    void IncreaseTopicWeight(TopicTreeNode root) {
        TopicTreeNode temp = root;

        while (temp.TopicNode != null) {
            temp.wordWeight++;
            if (temp.TagFlag=='\0')
                temp.TagFlag='X';
            temp = temp.TopicNode;
        }
        temp.wordWeight++;
    }

    void IncreaseWordWeight() {
        this.wordWeight++;
        if (this.TagFlag=='\0') this.TagFlag='X';
    }

    void setWord(String word) {
        this.word = word;
        this.wordWeight = 1;
    }

    private TopicTreeNode getTopicNode() {
        return this.TopicNode;
    }

    Object getWeight() {
        return this.wordWeight;
    }

    void addIDList(String postcode, String id) {
        if (postCodeList==null)postCodeList= new HashSet<String>();
        if (IdList==null)  IdList= new HashSet<String>();
        if (postcode!=null)
        this.postCodeList.add(postcode);
        if (id!=null)
        this.IdList.add(id);
    }

    HashSet<String> getIdList() {
        return IdList;
    }

}
