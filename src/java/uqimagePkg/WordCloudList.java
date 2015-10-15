/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uqimagePkg;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;



/**
 *
 * @author uqgzhu1
 */
public class WordCloudList {
    int MaxSize=100;    
    int currentSize;
    private int width;
    private int high;
    private int maxStrLen=1;
    private int maxWeight=1;
    private int WeakRate=1;
    List<WordCloudClass> TermsList =null;
    int Sortindex[] = null;
    public WordCloudList(){
         TermsList=new ArrayList<WordCloudClass>();
    }
    public void setShowSize(int width, int high){
        this.width=width;
        this.high=high;        
    }
    public int size(){
        return TermsList.size();
    }
    public void clear(){
        this.TermsList.clear();
    }
    
    public String getWeight(int i){
            if (Sortindex==null)  sortToken();
            int minv=Math.min(width,high);
            int temp=(minv-i*20)/8;
/*            String x=TermsList.get(Sortindex[i]).token;
*            double temp= TermsList.get(Sortindex[i]).getWeight();
            int rate=maxWeight*x.length();            
            if (x.length()==2) rate+=maxWeight;
            int maxRate=this.width*7/8;
            if (rate>maxRate){
                temp*=(double)maxRate/(double)rate;
              //  System.err.println(rate+": String length is >"+maxRate+" temp="+temp);
                if (WeakRate>(i)){
                    temp/=(WeakRate-i)*2;
                }
//                System.err.println(WeakRate+":"+i+"\ttemp weak to< ="+temp);
            }            
*/
            
            if (temp<20) temp=20;
            return temp+"px";        
    }
    public int sortToken(){
        
       Sortindex=null;
       Sortindex=new int[TermsList.size()];
       int []DataV=new int[TermsList.size()];
       int []oFlag=new int[TermsList.size()];
            int rate=maxWeight;            
            int maxRate=this.width*7/8;
            if (rate>maxRate){
                //*=maxRate/rate;
             //   System.err.println(rate+": String length is >"+maxRate);
            }
       
        for (int i = 0; i < Sortindex.length; i++) {
            Sortindex[i] = i;
            
            DataV[i]=TermsList.get(i).getWeight();
            oFlag[i]=TermsList.get(i).getColor();
        }
        MyQuickSort.quicksort(DataV, Sortindex);
        WeakRate=1;    
        if (Sortindex.length>7){
            System.err.println("rate is" +DataV[Sortindex[0]]+"\t"+DataV[Sortindex[6]]);
            if (DataV[Sortindex[0]]>DataV[Sortindex[6]]*10){
                WeakRate=(DataV[Sortindex[0]]-DataV[Sortindex[6]])/5;    
            }
        }
        return TermsList.size();
    }
    public String getToken(int i){
            String tempStr=TermsList.get(Sortindex[i]).token;            
            System.err.println(tempStr);
            return  tempStr;            
    }
         //a.red { color: #f00 }
            //a.green { color: #0c0 }
            //a.purple { color: #f09 }    
    String AColor[]={" color: ##0000FF", "color: #FA8072", "color: #000000"};
    public String getColor(int i){
            int temp=TermsList.get(Sortindex[i]).getColor();
            return AColor[temp];        
    }
    
    public void add(String [] words){
                if (words==null) return;
                if (words.length<2) return;
                if (words[0].indexOf("http")>=0) return;
                if (words[0].indexOf("https")>=0) return;
                if (words[0].indexOf("pm")>=0) return;
                int Len=words[0].length();
                if (Len<2) return;
                boolean alldigital=true;
                for (int i=0;i<words[0].length();i++){
                    if ((words[0].charAt(i)>='A'&&words[0].charAt(i)<='Z')||(words[0].charAt(i)>='a'&&words[0].charAt(i)<='z')) {
                        alldigital=false; break;
                    }
                }
                if (alldigital) return ;
                if (maxStrLen<Len)  maxStrLen=Len;
                uqimagePkg.WordCloudClass temp = new uqimagePkg.WordCloudClass(words);
                
                if (temp.token==null) return;
                
                int index =-1;
                for (int i=0;i<TermsList.size();i++){
                    uqimagePkg.WordCloudClass temp1=TermsList.get(i);
                    if (temp1.token==null) continue;
                    if (temp1.token.compareToIgnoreCase(temp.token)==0) {
                        index=i;
                        break;
                    }
                }
                
                if (index < 0) {
                    TermsList.add(temp);
                    if (maxWeight<temp.weight[0])  maxWeight=temp.weight[0];
                    if (maxWeight<temp.weight[1])  maxWeight=temp.weight[1];
                    if (maxWeight<temp.weight[2])  maxWeight=temp.weight[2];
                } else {
                    uqimagePkg.WordCloudClass temp1 = TermsList.get(index);
                    temp1.append(temp);
                    TermsList.set(index, temp1);
                    if (maxWeight<temp1.weight[0])  maxWeight=temp1.weight[0];
                    if (maxWeight<temp1.weight[1])  maxWeight=temp1.weight[1];
                    if (maxWeight<temp1.weight[2])  maxWeight=temp1.weight[2];                    
                }        
                
    }
}
