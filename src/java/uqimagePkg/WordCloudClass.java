/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uqimagePkg;

/**
 *
 * @author uqgzhu1
 */
public class WordCloudClass  implements Comparable<WordCloudClass>{
    String token;
    int  weight[]={0,0,0};
    char mention;
    public WordCloudClass(String word[]){
        if (word.length<2) return;
        if (word[0].compareToIgnoreCase("UQ")==0)  token="UQ";
        else if (word[0].compareToIgnoreCase("QUT")==0)  token="QUT";
        else if (word[0].compareToIgnoreCase("USQ")==0)  token="USQ";
        else if (word[0].compareToIgnoreCase("ACU")==0)  token="ACU";
        else
            token=word[0];
        
        mention=word[2].charAt(0);
        int temp=0;
        try{
            temp=Integer.valueOf(word[1]);
        }catch (java.lang.NumberFormatException ex){
            temp=0;
        }
        temp++;
        if (mention=='P')         weight[0]=temp;
        else if (mention=='N')         weight[1]=temp;
        else weight[2]=temp;
//        if (mention!='P'||mention!='N'||mention!='X')
  //          mention='X';
    }

    @Override
    public int compareTo(WordCloudClass t) {
        return (token.compareToIgnoreCase(t.token));
        
    }
    
    public WordCloudClass append(WordCloudClass t){
                char tempChar=t.mention;
        if (tempChar=='P')         weight[0]+=t.weight[0];
        else if (tempChar=='N')         weight[1]+=t.weight[1];
        else weight[2]+=t.weight[2];

        return this;
    }
    public int getColor(){
        if (this.weight[0]>this.weight[1]&&this.weight[0]>=this.weight[2])
            return 0;
        else if (this.weight[1]>this.weight[0]&&this.weight[1]>=this.weight[2])
            return 1;
        else return 2;
    }
    public String getToken(){
        return this.token;
    }
    public int getWeight(){
       
        int temp=0;
        if (this.weight[0]>this.weight[1]&&this.weight[0]>=this.weight[2])
            temp=weight[0];
        else if (this.weight[1]>this.weight[0]&&this.weight[1]>=this.weight[2])
            temp=weight[1];
        else temp=weight[2];        
            return temp;
    }
    
    
}
