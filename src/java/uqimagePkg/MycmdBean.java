/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uqimagePkg;

import java.beans.*;
import java.io.Serializable;

/**
 *
 * @author uqgzhu1
 */
public class MycmdBean implements Serializable {
    
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    public static final String CMD_PROPERTY = "CmdName";
    
    private String sampleProperty;
    
    private PropertyChangeSupport propertySupport;
    
    private String CmdName = null;
    
    public MycmdBean() {
        propertySupport = new PropertyChangeSupport(this);
    }
    
    public String getSampleProperty() {
        return sampleProperty;
    }
    
    public void setSampleProperty(String value) {
        String oldValue = sampleProperty;
        sampleProperty = value;
        propertySupport.firePropertyChange(PROP_SAMPLE_PROPERTY, oldValue, sampleProperty);
    }
    
    public void addPropertyChangeListener(PropertyChangeListener listener) {
        propertySupport.addPropertyChangeListener(listener);
    }
    
    public void removePropertyChangeListener(PropertyChangeListener listener) {
        propertySupport.removePropertyChangeListener(listener);
    }

    /**
     * @return the CmdName
     */
    public String getCmdName() {
        return CmdName;
    }

    /**
     * @param CmdName the CmdName to set
     */
    public void setCmdName(String CmdName) {
        this.CmdName = CmdName;
    }
    public String  getCmdHide(String tempCmdName){
        
       //System.out.println(CmdName+"\t-->"+tempCmdName);
        if (CmdName==null) return "";
        if (tempCmdName==null) return "";
        if (CmdName.compareTo(tempCmdName)==0){
            return "sidebar-brand";
        }
        return "";
    }
}
