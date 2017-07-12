package com.qianfeng.bean;

import java.io.Serializable;
import java.util.Set;

public  class Resources implements Serializable{

        private int id;
        private String text;
        private String url;
        private Set<Resources> children;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public Set<Resources> getChildren() {
            return children;
        }

        public void setChildren(Set<Resources> children) {
            this.children = children;
        }



}
