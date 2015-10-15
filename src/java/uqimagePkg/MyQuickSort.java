/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uqimagePkg;

import java.util.Vector;

/**
 *
 * @author uqgzhu1
 */
public class MyQuickSort {
    static boolean myorder=false;
    public static void quicksort(int[] main, int[] index, boolean increase) {
        myorder=increase;
        quicksort(main, index, 0, index.length - 1);
    }
    public static void quicksort(int[] main, int[] index) {
        myorder=false;
        quicksort(main, index, 0, index.length - 1);
    }

// quicksort a[left] to a[right]
    public static void quicksort(int[] a, int[] index, int left, int right) {
        if (right <= left) {
            return;
        }
        int i = partition(a, index, left, right);
        quicksort(a, index, left, i - 1);
        quicksort(a, index, i + 1, right);
    }

// partition a[left] to a[right], assumes left < right
    private static int partition(int[] a, int[] index,
            int left, int right) {
        int i = left - 1;
        int j = right;
        while (true) {
            while (less(a[++i], a[right]))      // find item on left to swap
            ;                               // a[right] acts as sentinel
            while (less(a[right], a[--j])) // find item on right to swap
            {
                if (j == left) {
                    break;           // don't go out-of-bounds
                }
            }
            if (i >= j) {
                break;                  // check if pointers cross
            }
            exch(a, index, i, j);               // swap two elements into place
        }
        exch(a, index, i, right);               // swap with partition element
        return i;
    }

// is x < y ?
    private static boolean less(int x, int y) {
        if (myorder)
        return (x < y);
        else
            return (x > y);
    }

// exchange a[i] and a[j]
    private static void exch(int[] a, int[] index, int i, int j) {
        int swap = a[i];
        a[i] = a[j];
        a[j] = swap;
        int b = index[i];
        index[i] = index[j];
        index[j] = b;
    }
    
   public static void main(String a[]){
         
        //MyQuickSort sorter = new MyQuickSort();
        int[] input = {24,2,45,20,56,75,2,56,99,53,12};
        int[] input1 = {24,2,45,20,56,75,2,56,99,53,12};        
        int []index= new int[input.length];
        for (int i=0;i<index.length;i++) index[i]=i;
        MyQuickSort.quicksort(input,index);
        for (int i=0;i<index.length;i++){
            System.out.print(input1[index[i]]+"\t");
        }
        System.out.println(" ");
        for (int i=0;i<index.length;i++){
            System.out.print(index[i]+"\t");
        }
        System.out.println(" ");        
    }

    public static void quicksort(Vector<Integer> tempInt, int[] index) {
        int main[]=new int[tempInt.size()];
        for (int i=0;i<main.length;i++) main[i]=tempInt.get(i);
        myorder=false;
        quicksort(main, index, 0, index.length - 1);
        main=null;
    }

    public static void quicksort(Vector<Integer> tempInt, int[] index, Vector<Character> tempChar) {
        int main[]=new int[tempInt.size()];
        for (int i=0;i<main.length;i++) {
            main[i]=tempInt.get(i);
            if (tempChar.get(i)=='-'||tempChar.get(i)=='*') main[i]<<=2;
            if (tempChar.get(i)=='N') main[i]*=3;
            if (tempChar.get(i)=='^') main[i]<<=1;
            if (tempChar.get(i)=='V') main[i]<<=1;            
        }
        myorder=false;
        quicksort(main, index, 0, index.length - 1);
        main=null;
    }


}
