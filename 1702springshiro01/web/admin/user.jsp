<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!--搜索  -->
<div class="easyui-panel" title="搜索" style="width:100%;height:100px">
    <div class="easyui-searchbox" style="width:180px;" data-options="menu:'#choice',prompt:'输入搜索关键字',searcher:dosearch">
        <div id="choice">
            <div data-options="name:'account'">账号</div>
            <div data-options="name:'pwd'">密码</div>
        </div>
    </div>
</div>
<div id="first"></div>

<!-- 弹窗 -->
<div id="users_window" title="权限分配" class="easyui-window"
     style="width:300px;height:400px" data-options="closed:true,modal:true">
    <ul id="muen_tree" class="easyui-tree"
        data-options="url:'../seleteAllResource.do',checkbox:true"></ul>
    <div style="display:flex;justify-content:center">
        <a href="javascript:dofenp()" class="easyui-linkbutton">保存</a>
    </div>

</div>

<script type="text/javascript">
    function init() {
        //表格的设计
        $("#first").datagrid({
            title : "用户管理",
            // url:"selectByUsers.do",
            pagination : true,
            striped:true,
            columns : [ [
                {
                    field : 'uid',
                    width : 50,
                    checkbox : true
                },
                {
                    field : "account",
                    title : "账号",
                    width : 100
                },
                {
                    field : "pwd",
                    title : "密码",
                    width : 100
                }
            ] ],
            //width : 600,
            striped : true,

            loadMsg : '我们正在努力获取数据，请您稍等。。。',
            rownumbers : true,
            //表格自适应父容器
            //fit:true
            toolbar : [
                {
                    <shiro:hasPermission name="user:delete">
                    text: "删除",
                    iconCls: 'icon-remove',
                    handler: function () {
                      remove();
                    }

                    </shiro:hasPermission>

                }, {
                    <shiro:hasPermission name="user:update">
                    text: '权限分配',
                    iconCls: "icon-edit",
                    handler: function () {
                        fenp();
                    }
                    </shiro:hasPermission>

                },{
                <shiro:hasPermission name="user:add">
                    text:"添加",
                    iconCls:'icon-add',
                    handler:function () {
                        alert("添加")
                    }
                    </shiro:hasPermission>

                }
            ]
        });
        load2(1);
    }
    $(init);
    //分页处理
    function load2(p) {
        $.getJSON("../selectByUsers.do",
            {
                page : p
            },
            function(msg) {
                // alert(msg)
                $("#first").datagrid("loadData", msg);
                var pager = $("#first").datagrid("getPager");
                pager.pagination({
                    //总记录数
                    total : 7,
                    //每页显示的数
                    pageSize : 2,
                    //当分页创建完毕时显示当前的页码(当前页)
                    pageNumber : p,
                    //用户能够灵活的改变每页显示的记录数
                    pageList : [ 1, 2 ],
                    onSelectPage : function(page, size) {
                        load2(page);
                    },
                    beforePageText : '第',
                    afterPageText : '页,共{pages}页',
                    displayMsg : '共{total}条数据',
               /*     buttons : [ {
                        text : '添加',
                        iconCls : 'icon-add',
                        handler : function() {
                            alert("123");
                        }
                    }, '-', {
                        text : '修改',
                        iconCls : 'icon-edit',
                        handler : function() {
                            alert("修改");
                        }
                    }
                    ]*/
                });
            })
    }
    //多条数据删除
    function remove() {
        var data = $("#first").datagrid('getSelections');
        if(data.length!=0){
            $.messager.confirm('提示框', '你确定要删除吗', function (r) {
                if (r) {
                    var ids = []
                    for (var i = 0; i < data.length; i++) {
                        ids[i] = data[i].uid;
                    }
                    var x = JSON.stringify(ids);
                    alert(x)
                    $.ajax({
                        url : "../removeUser.do",
                        method : "post",
                        data : x,
                        contentType : "application/json",
                        success : function(msg) {
                            alert(msg)
                            if (msg ==1) {
                                $.messager.alert('提示框', '恭喜您删除成功');
                                load2(1);
                            }else {
                                $.messager.alert('提示框', '删除数据失败');
                            }
                        }
                    });
                }

            });

        }else {
            $.messager.alert('提示框',"请选择要删除的用户");
        }


    }
    //获取该用户的权限
    function findqx(){
        var user= $("#first").datagrid('getSelected');
       // alert(user.uid)
        var x = JSON.stringify(user);
       // alert("转换后的"+x)
        $.ajax({
            url:"../selectQxByUser1.do",

            method: "post",
            data:{id:user.uid},
            success:function(x){
                 alert("后台传过来的"+x)
                if(x){
                    alert(x)
                    var data= JSON.parse(x);
                    for(var i=0;i<data.length;i++){
                        var childrendata= data[i].children;
                        for(var j=0;j<childrendata.length;j++){
                            // alert(childrendata[j].id)
                            var node=$("#muen_tree").tree('find',childrendata[j].id);
                            // alert(node.target)
                            if (null != node && undefined != node)
                            {
                                $('#muen_tree').tree('check', node.target);
                            }

                        }
                    }

                }
            }

        });
    }
    //打开分配权限窗口
    function fenp(){
        var user= $("#first").datagrid('getSelected');
        //判断是否为空
        if(user){
            findqx();
            $("#users_window").window({
                onClose:function(){
                    /*  $.messager.confirm('提示框','窗口正在关闭，请确认您当前的操作已保存。\n 是否继续关闭窗口？',function(r){
                     $("#muen_tree").tree("reload");
                     //$('#users_window').window('close'); //这里调用close 方法，true 表示面板被关闭的时候忽略onBeforeClose 回调函数。
                     }); */
                    $("#muen_tree").tree("reload");
                }
            })

            $("#users_window").window('open');
            //$("#muen_tree").tree("reload");
        }else{
            $.messager.alert('提示框',"请选择要分配权限的用户");
        }

    }

    //分配权限
    function dofenp(){

        var user= $("#first").datagrid('getSelected');
        var data= $("#muen_tree").tree("getChecked");
        //初始化一个数组，并保存用户的ID
        var inds=[user.id];
        for(var i=0;i<data.length;i++){
            //alert(data[i].id)
            //把所选的节点也存贮在数组中
            inds[i+1]=data[i].id;
        }
        var idarr= JSON.stringify(inds);
        //alert(idarr)
        $.ajax({
            url:"../assignPermissions.do",
            method: "post",
            cache:false,
            contentType: "application/json",
            data:idarr,
            success:function(x){
                if(x){
                    //alert(x);
                    $("#first").datagrid("reload");
                    $("#muen_tree").tree("reload");
                    $("#users_window").window("close");
                }
            }

        });
    }
    //key是要搜索的关键字,type 是传的要搜索的字段名字
    function dosearch(key,type){
        //alert(type+"**"+key)
        $.getJSON("../search.do",{type:type,key:key},function(d){
            //alert(d);
            $("#first").datagrid("loadData" ,d);
        })
    }
</script>

